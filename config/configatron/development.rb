configatron.secret_key_base = '2bd450959dad5e41f09c976e3ec9c91e5d7bb6f12e8774953c778389f984fc2b0dc64357e7e04498c55b2a03cb04c255fb2b864152fa9089143484c0703cac08'
configatron.our_email = "okrsky@svobodni.cz"
configatron.our_email_password = "heslo"
configatron.admin_email = "kubicek@svobodni.cz"

configatron.registry.uri="https://registr.svobodni.cz"

configatron.registr_oauth2_client_id='fc23b28d3f15d84c04177cd869b50d6e30ad6f03e6e256b380e4a036e352dda0'
configatron.registr_oauth2_client_secret='f8546307e84c19cf77ea0767fa4ede742285ff22afa3e0711dec2314da67533e'

# Středočeský, Pardubický, Zlínský, Jihomoravský, Královéhradecký, Karlovarský, Ústecký, Liberecký
configatron.coalition_region_ids=[27, 94, 141, 116, 86, 51, 60, 78]

configatron.registration_ends_at=Date.parse("2016-09-01")
configatron.registration_allowed = Configatron::Dynamic.new {configatron.registration_ends_at >= Time.now}
