require "csv"

ciselniky = %w(UI_OBEC UI_OKRES UI_MOMC UI_VUSC UI_VOLEBNI_OKRSEK)
progressbar_format = "%a %e %P% Zpracovano: %c z %C %bᗧ%i %p%% %t"
registration_ends_at = Date.parse("2021-09-03")

ciselniky.each{|ciselnik|
  unless File.exist?("#{ciselnik}.csv")
    unless File.exist?("#{ciselnik}.zip")
      `wget http://www.cuzk.cz/CUZK/media/CiselnikyISUI/#{ciselnik}/#{ciselnik}.zip`
    end
    `unzip #{ciselnik}.zip`
    `sed -i '' '$d' #{ciselnik}.csv`
    `sed -i 's/\r//g' #{ciselnik}.csv`
  end
}

def read_csv(file)
  CSV.foreach(file, col_sep: ";", headers: true, skip_blanks: true, encoding: "windows-1250").collect do |row|
    row.to_hash.transform_keys{|key| key.to_s.downcase.to_sym }
  end
end

data={}
ciselniky.each{|ciselnik|
  data[ciselnik]=read_csv("#{ciselnik}.csv")
}

progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "Kraje", starting_at: 0, total: data['UI_VUSC'].size)
data['UI_VUSC'].each{|r|
  Region.where(id: r[:kod]).first_or_create {|region|
    region.name=r[:nazev]
    region.registration_ends_at = registration_ends_at
  }
  progressbar.increment
}

progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "Obce", starting_at: 0, total: data['UI_OBEC'].size)
data['UI_OBEC'].each{|o|
  Municipality.where(id: o[:kod]).first_or_create! { |mun|
    okres = data['UI_OKRES'].detect{|okres| okres[:kod]==o[:okres_kod]}
    kraj = data['UI_VUSC'].detect{|kraj| kraj[:kod]==okres[:vusc_kod]}
    mun.name=o[:nazev]==okres[:nazev] ? okres[:nazev] : "#{o[:nazev]} (okres #{okres[:nazev]})"
    mun.region_id=kraj[:kod]
    mun.registration_allowed=true
  }

  # filename = "epusa/obce/#{o[:kod]}.html"
  # unless File.exist?(filename)
  #   `wget -O #{filename} "https://www.epusa.cz/index.php?obec=#{o[:kod]}"`
  # end

  TownHall.create!(
    name: o[:nazev],
    # ic: Nokogiri.parse(File.open(filename)).at("span.zkratka106:contains('(6)')").parent.next_element.text.rjust(8,"0"),
    municipality_id: o[:kod]
  ) unless o[:kod]=="539996" # Brdy
  progressbar.increment
}

progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "MOMC", starting_at: 0, total: data['UI_MOMC'].size)
data['UI_MOMC'].each{|d|
  District.where(id: d[:kod]).first_or_create! { |dis|
    dis.name=d[:nazev]
    dis.municipality_id=d[:obec_kod]
  }
  # filename = "epusa/momc/#{d[:kod]}.html"
  # unless File.exist?(filename)
  #   `wget -O #{filename} "https://www.epusa.cz/index.php?mestcast=#{d[:kod]}"`
  # end

  DistrictTownHall.create!(
    name: d[:nazev],
    # ic: Nokogiri.parse(File.open(filename)).at("span.zkratka106:contains('(6)')").parent.next_element.text.rjust(8,"0"),
    municipality_id: d[:obec_kod],
    district_id: d[:kod],
  ) unless ["556904","555321"].member?(d[:kod]) # FIXME: Liberec, Opava
  progressbar.increment
}

progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "Okrsky", starting_at: 0, total: data['UI_VOLEBNI_OKRSEK'].size)
data['UI_VOLEBNI_OKRSEK'].each{|o|
  Ward.find_or_create_by!(id: o[:kod]) { |okr|
    if o[:cislo_s_prefixem]
      okr.external_id=o[:cislo_s_prefixem]
    else
      okr.external_id=o[:cislo]
    end
    okr.municipality_id=o[:obec_kod]
    okr.district_id=o[:momc_kod]
  } if o[:plati_do].blank?
  progressbar.increment
}

progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "Obce RISY", starting_at: 0, total: TownHall.where(district_id:nil).count)
TownHall.where(district_id:nil).each{|hall|
  filename="risy/obce/#{hall.municipality_id}.html"
  unless File.exist?(filename)
    `wget -O #{filename} "http://www.risy.cz/cs/vyhledavace/obce/detail?zuj=#{hall.municipality_id}"`
  end
  progressbar.increment
}

progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "Momc RISY", starting_at: 0, total: DistrictTownHall.count)
DistrictTownHall.all.each{|hall|
  filename="risy/momc/#{hall.district_id}.html"
  unless File.exist?(filename)
    `wget -O #{filename} "http://www.risy.cz/cs/vyhledavace/obce/detail?zuj=#{hall.municipality_id}&mc=#{hall.district_id}"`
  end
  progressbar.increment
}

files = Dir.glob("risy/obce/*.html")
progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "IDDS Obci", starting_at: 0, total: files.size)
files.each do |fn|
  id = fn.match(/\d+/)[0]
  f=File.open(fn)
  idds_match = f.read.match(/<tr><td>Datov. schr.nka:<\/td><td>(\w{7})<\/td><\/tr>/)
  f.close
  unless idds_match
    puts "ERROR FINDING IDDS #{fn}" unless id=='541303'
  else
    TownHall.find_by(district_id:nil,municipality_id:id).update_attribute :idds, idds_match[1]
  end
  progressbar.increment
end

# Vidnava fix - risy nema data
TownHall.find_by(municipality_id:541303).update_attribute :idds, '7ywbajq'

files = Dir.glob("risy/momc/*.html")
progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "IDDS Momc", starting_at: 0, total: files.size)
files.each do |fn|
  id = fn.match(/\d+/)[0]
  f=File.open(fn)
  idds_match = f.read.match(/<td><label id="Label35" style="border: 0;">(\w{7})<\/label><\/td>/)
  f.close
  unless idds_match
    puts "ERROR FINDING IDDS #{fn}" unless ['554324', '554715', '545970'].member?(id)
  else
    DistrictTownHall.find_by(district_id:id).update_attribute :idds, idds_match[1]
  end
  progressbar.increment
end

# fixy - risy nema validni hodnoty
DistrictTownHall.find_by(district_id:554324).update_attribute :idds, '2r7bt6b'
DistrictTownHall.find_by(district_id:554715).update_attribute :idds, 'wu8bzk6'
DistrictTownHall.find_by(district_id:545970).update_attribute :idds, '2dibh62'

unless File.exist?("ovm.xml")
  `wget -O ovm.xml.gz "https://www.mojedatovaschranka.cz/sds/datafile.do?format=xml&service=seznam_ds_ovm"`
  `gzip -d ovm.xml.gz`
end

c=Crack::XML.parse(File.open("ovm.xml"))
boxes = c["list"]["box"] #.select{|d| d["type"]=="OVM"}

data = TownHall.where.not(idds:nil)
progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "OVM", starting_at: 0, total: data.count)

data.each do |townhall|
  box = boxes.detect{|b| b['id']==townhall.idds}

  ulice = if box['address']['street'].blank?
    "č.p."
  else
    box['address']['street']
  end

  cislo = if box['address']['co'].blank?
    box['address']['cp']
  else
    "#{box['address']['cp']}/#{box['address']['co']}"
  end

  address = "#{ulice} #{cislo}\n#{box['address']['zip']} #{box['address']['city']}"

  townhall.update name: box['name']['tradeName'], address: address
  progressbar.increment
end

# (1..200).to_a.each{|id|
#   Commisary.create(name: "Jan Novák", birth_number: "123456/#{id.to_s.rjust(4,'0')}", address: "Adresa Neco nekde", email: "jiri.kubicek+#{id}@kraxnet.cz", phone: "220199201", ward_id: id, user_id: 1)
# }
