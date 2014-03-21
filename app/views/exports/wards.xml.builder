xml.instruct!                                   # <?xml version="1.0" encoding="UTF-8"?>
xml.regions {                                   # <wards>
  @wards.each { |ward|            
    xml.ward {                                  #   <ward>
      xml.id(ward.external_id)                  #     <id>1</id>
      xml.taken(ward.taken?)                    #     <taken>true</taken>
      xml.municipality_id(ward.municipality.id) #     <municipality_id>1</municipality_id>
    }                                           #   </ward>
  }
}                                               # </wards>
