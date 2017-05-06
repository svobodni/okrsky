prawn_document() do |pdf|

pdf.font_families.update(
   "Times-Roman" => { :bold        => File.join(Rails.root, "fonts", "Times New Roman Bold.ttf"),
                      :italic      => File.join(Rails.root, "fonts", "Times New Roman Italic.ttf"),
                      :bold_italic => File.join(Rails.root, "fonts", "Times New Roman Bold Italic.ttf"),
                      :normal      => File.join(Rails.root, "fonts", "Times New Roman.ttf") })
pdf.font "Times-Roman"

for town_hall, commisaries in @town_halls do

#if params[:region_id] && town_hall.region.id!=params[:region_id].to_i
#  nil
#else

pdf.move_down 60
pdf.indent(300) do
pdf.text town_hall.name
pdf.text "k rukám starosty"
pdf.text town_hall.address
end
pdf.text "IDDS #{town_hall.idds}"

pdf.move_down 40
pdf.text "Naše značka: PSP2017-OVK-D-#{town_hall.id}"
pdf.text "Vyřizuje: kancelar@svobodni.cz, tel.: 773 697 986"
pdf.move_down 20

pdf.text "Seznam delegovaných členů do okrskových volebních komisí pro volby do Poslanecké sněmovny Parlamentu České republiky konané ve dnech 20. a 21. října 2017.", :style => :bold
pdf.move_down 20
pdf.text "V souladu s ust. § 14e odst. 3 a 4 zákona č. 247/1995 Sb., o volbách do Parlamentu České republiky a o změně a doplnění některých dalších zákonů, ve znění pozdějších předpisů tímto politická strana Strana svobodných občanů, jejíž kandidátní listina byla zaregistrována pro volby do Poslanecké sněmovny Parlamentu České republiky, deleguje níže uvedené členy do okrskových volebních komisí vaší obce/města."

pdf.move_down 20

pdf.text "Členové :", :style => :bold
for commisary in commisaries.sort{|a, b| a.ward.external_id.to_i<=>b.ward.external_id.to_i} do
  pdf.text "Jméno a příjmení: " + commisary.name
  pdf.text "Datum narození: " + commisary.birth_number
  pdf.text "Místo, kde je člen přihlášen k trvalému pobytu: " + commisary.address
  pdf.text "Telefon: " + commisary.phone
  pdf.text "Email: " + commisary.email
  pdf.text "Korespondenční adresa: " + commisary.postal_address unless commisary.postal_address.blank?
  pdf.text "Údaj, do které okrskové volební komise má být delegovaný člen zařazen: č. #{commisary.ward.external_id}"
  pdf.move_down 20
end
pdf.move_down 40

if configatron.registration_ends_at>Time.now
  pdf.text "Tištěno před uzávěrkou, neposílat!", style: :bold, size: 20
end

pdf.text "
                                                                  .......................................................
                                                                  podpis zmocněnce politické strany

                                                                  #{commisary.ward.municipality.region.representative.try(:name)}
                                                                  .......................................................
                                                                  jméno zmocněnce politické strany
"+
#                                                                  .......................................................
#                                                                  kontaktní údaje zmocněnce politické strany
"
                                                                  Strana svobodných občanů
                                                                  Perucká 14
                                                                  120 00 Praha 2"

pdf.start_new_page # unless @town_halls.last==town_hall
end
#end
end
