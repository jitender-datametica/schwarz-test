CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_crossdock (
crossdock_sid BIGNUMERIC NOT NULL
OPTIONS(description='Contains crossdock and operating hauler_sid. In addition the crossdock_name. '),
operating_hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='Hauler (Spediteur) who is running the crossdock'),
country_cd STRING(2) NOT NULL
OPTIONS(description='The code for the country in which the site (cross docks) resides in.'),
country_descr STRING(100)
OPTIONS(description='A textual description for country_cd written out in group language (German).'),
crossdock_nr STRING(20)
OPTIONS(description='Contains crossdock and operating hauler_sid. In addition the crossdock_name. '),
crossdock_abbr_name STRING(100)
OPTIONS(description='Contains crossdock and operating hauler_sid. In addition the crossdock_name. '),
crossdock_name STRING(100)
OPTIONS(description='Contains crossdock and operating hauler_sid. In addition the crossdock_name. '),
longitude NUMERIC(9,6) OPTIONS(description='Object.address-data.coordinates x'),
latitude NUMERIC(9,6) OPTIONS(description='Object.address-data.coordinates y'),
city_name STRING(100) OPTIONS(description='Name of the city'),
zip STRING(10) OPTIONS(description='Zip code / PLZ'),
street_name STRING(100) OPTIONS(description='Name of the street'),
gln_nr STRING(13) OPTIONS(description='The Global Location Number where the supplier is located.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (crossdock_sid) NOT ENFORCED
)
OPTIONS(description='This entity contains all cross-docks that are known. A cross-dock is a subtype of a site.              Different goods are delivered by different carriers at a main hub. In addition, goods also leave from a crossdock.              The operating hauler (Spediteur) is the entity which runs and manages the crossdock.');