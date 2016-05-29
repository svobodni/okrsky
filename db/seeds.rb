require "csv"

ciselniky = %w(UI_OBEC UI_OKRES UI_MOMC UI_VUSC UI_VOLEBNI_OKRSEK)
progressbar_format = "%a %e %P% Zpracovano: %c z %C %bᗧ%i %p%% %t"
registration_ends_at = Date.parse("2016-09-01")

ciselniky.each{|ciselnik|
  unless File.exist?("#{ciselnik}.csv")
    unless File.exist?("#{ciselnik}.zip")
      `wget http://www.cuzk.cz/CUZK/media/CiselnikyISUI/#{ciselnik}/#{ciselnik}.zip`
    end
    `unzip #{ciselnik}.zip`
    `sed -i '' '$d' #{ciselnik}.csv`
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
  Municipality.where(id: o[:kod]).first_or_create { |mun|
    okres = data['UI_OKRES'].detect{|okres| okres[:kod]==o[:okres_kod]}
    kraj = data['UI_VUSC'].detect{|kraj| kraj[:kod]==okres[:vusc_kod]}
    mun.name="#{o[:nazev]} (#{okres[:nazev]})"
    mun.region_id=kraj[:kod]
    mun.registration_allowed=true
  }

  filename = "epusa/obce/#{o[:kod]}.html"
  unless File.exist?(filename)
    `wget -O #{filename} "https://www.epusa.cz/index.php?obec=#{o[:kod]}"`
  end

  TownHall.create(
    name: o[:nazev],
    ic: Nokogiri.parse(File.open(filename)).at("span.zkratka106:contains('(6)')").parent.next_element.text.rjust(8,"0"),
    municipality_id: o[:kod]
  ) unless o[:kod]=="539996" # Brdy
  progressbar.increment
}

progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "Obvody", starting_at: 0, total: data['UI_MOMC'].size)
data['UI_MOMC'].each{|d|
  District.where(id: d[:kod]).first_or_create { |dis|
    dis.name=d[:nazev]
    dis.municipality_id=d[:obec_kod]
  }
  filename = "epusa/momc/#{d[:kod]}.html"
  unless File.exist?(filename)
    `wget -O #{filename} "https://www.epusa.cz/index.php?mestcast=#{d[:kod]}"`
  end

  DistrictTownHall.create(
    name: d[:nazev],
    ic: Nokogiri.parse(File.open(filename)).at("span.zkratka106:contains('(6)')").parent.next_element.text.rjust(8,"0"),
    municipality_id: d[:obec_kod],
    district_id: d[:kod],
  ) unless ["556904","555321"].member?(d[:kod]) # FIXME: Liberec, Opava
  progressbar.increment
}

progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "Okrsky", starting_at: 0, total: data['UI_VOLEBNI_OKRSEK'].size)
data['UI_VOLEBNI_OKRSEK'].each{|o|
  Ward.where(id: o[:kod]).first_or_create { |okr|
    okr.external_id=o[:cislo]
    okr.municipality_id=o[:obec_kod]
    okr.district_id=o[:momc_kod]
  }
  progressbar.increment
}

require 'crack'

unless File.exist?("ovm.xml")
  `wget -O ovm.xml "https://seznam.gov.cz/ovm/datafile.do?format=xml&service=seznamovm"`
end

c=Crack::XML.parse(File.open("ovm.xml"))
ovm = c["SeznamOvmIndex"]["Subjekt"].select{|d| d["TypDS"]=="OVM"}
progressbar=ProgressBar.create(format: progressbar_format, progress_mark: ' ', remainder_mark: '･', title: "OVM", starting_at: 0, total: ovm.size)
typy = ovm.collect{|o|
  # progressbar.log "Updating #{o['Zkratka']}"
  filename = "ovm/#{o['Zkratka']}.xml"
  url = o['DetailSubjektu']
  unless File.exist?(filename)
    `wget -O #{filename} "#{url}"`
  end
  data = Crack::XML.parse(File.open(filename))["DetailSubjektu"]
  if [
    "Obec I. Typu",
    "Obec II. Typu",
    "Obec III. Typu",
    "Statutární města (Magistráty) a jejich obvody"
  ].member?(data["TypSubjektu"])
    hall=TownHall.find_by_ic(data["ICO"])
    unless ["BOLETICE", "BRDY", "LIBAVA"].member?(o["Zkratka"])
      if data['AdresaUradu']['UliceNazev'].blank?
        ulice = "č.p."
      else
        ulice = data['AdresaUradu']['UliceNazev']
      end
      address = "#{ulice} #{data['AdresaUradu']['CisloDomovni']}\n#{data['AdresaUradu']['PSC']} #{data['AdresaUradu']['ObecNazev']}"
      hall.update_attributes(
        idds: data["IdDS"],
        name: data["Nazev"],
        address: address
      )
    end
  end
  progressbar.increment
}

#  c["SeznamOvmIndex"]["Subjekt"].detect{|s| s["Nazev"]=="Obec Kojetice"}
# => {"Zkratka"=>"KojeticeT", "ICO"=>"00289612", "Nazev"=>"Obec Kojetice", "AdresaUradu"=>{"AdresniBod"=>"2676516", "CisloDomovni"=>"131", "ObecNazev"=>"Kojetice", "ObecKod"=>"590860", "CastObceNeboKatastralniUzemi"=>"Kojetice", "PSC"=>"67523", "KrajNazev"=>"Vysočina"}, "Email"=>{"Polozka"=>[{"Typ"=>"1", "Email"=>"info@oukojetice.cz"}, {"Typ"=>"2", "Email"=>"ou.kojetice@quick.cz"}]}, "TypSubjektu"=>"Obec I. Typu", "PravniForma"=>"Obec", "PrimarniOvm"=>"Ano", "IdDS"=>"cw3ax5s", "TypDS"=>"OVM", "StavDS"=>"1", "StavSubjektu"=>"1", "DetailSubjektu"=>"http://seznam.gov.cz/ovm/datafile.do?format=xml&service=seznamovm&id=KojeticeT"}
# d=Crack::XML.parse(open("http://seznam.gov.cz/ovm/datafile.do?format=xml&service=seznamovm&id=KojeticeT"))
