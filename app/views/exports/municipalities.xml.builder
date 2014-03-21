xml.instruct!                               # <?xml version="1.0" encoding="UTF-8"?>
xml.regions {                               # <municipalities>
  @municipalities.each { |municipality|
    xml.municipality {                      #   <municipality>
      xml.id(municipality.id)               #     <id>1</id>
      xml.name(municipality.name)           #     <name>Praha</name>
      xml.region_id(municipality.region_id) #     <region_id>1</region_id>
    }                                       #   </municipality>
  }
}                                           # </municipalities>
