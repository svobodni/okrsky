configatron.secret_key_base = '2bd450959dad5e41f09c976e3ec9c91e5d7bb6f12e8774953c778389f984fc2b0dc64357e7e04498c55b2a03cb04c255fb2b864152fa9089143484c0703cac08'
configatron.our_email = "okrsky@svobodni.cz"
configatron.our_email_password = "heslo"
configatron.admin_email = "kubicek@svobodni.cz"

configatron.registry.uri="https://registr.svobodni.cz"

configatron.registr_oauth2_client_id='fc23b28d3f15d84c04177cd869b50d6e30ad6f03e6e256b380e4a036e352dda0'
configatron.registr_oauth2_client_secret='f8546307e84c19cf77ea0767fa4ede742285ff22afa3e0711dec2314da67533e'

# Středočeský, Pardubický, Zlínský, Jihomoravský, Královéhradecký, Karlovarský, Ústecký, Liberecký
configatron.coalition_region_ids=Region.ids #[27, 94, 141, 116, 86, 51, 60, 78]

configatron.registration_ends_at=Date.parse("2021-09-03")
configatron.registration_allowed = Configatron::Dynamic.new {configatron.registration_ends_at >= Time.now}
configatron.public_registration_allowed = false
# "do Senátu Parlamentu České republiky, které se uskuteční ve dnech 10. a 11. října 2014"
# "do zastupitelstev krajů a do Senátu konaných ve dnech 2. a 3. října 2020"

configatron.votes_name="do Poslanecké sněmovny Parlamentu ČR"
configatron.votes_human_date="8. a 9. října 2021"
configatron.votes_full_name="volby #{configatron.votes_name} konaných ve dnech #{configatron.votes_human_date}"
# configatron.letter_text "V souladu s ust. § 17 odst. 2 a 3 zákona č. 130/2000 Sb., o volbách do zastupitelstev krajů a o změně některých zákonů, ve znění pozdějších předpisů tímto politická strana Svobodní, jejíž kandidátní listina byla zaregistrována pro volby do zastupitelstva kraje, deleguje níže uvedené členy do okrskových volebních komisí vaší obce/města.
configatron.letter_text="V souladu s ust. § 14e odst. 3 a 4 zákona č. 247/1995 Sb., o volbách do Parlamentu České republiky a o změně a doplnění některých dalších zákonů, ve znění pozdějších předpisů tímto politická strana Svobodní, jejíž kandidátní listina byla zaregistrována pro volby do Poslanecké sněmovny Parlamentu České republiky, deleguje níže uvedené členy do okrskových volebních komisí vaší obce/města."
