xml.instruct!                   # <?xml version="1.0" encoding="UTF-8"?>
xml.regions {                   # <regions>
  @regions.each { |region|
    xml.region {                #   <region>
      xml.id(region.id)         #     <id>1</id>
      xml.name(region.name)     #     <name>Praha</name>
    }                           #   </region>
  }
}                               # </regions>
