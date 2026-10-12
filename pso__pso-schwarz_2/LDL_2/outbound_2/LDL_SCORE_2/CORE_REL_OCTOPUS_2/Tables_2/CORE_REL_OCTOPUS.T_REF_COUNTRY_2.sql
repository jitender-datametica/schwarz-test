CREATE TABLE IF NOT EXISTS ldl_score_core_rel_octopus.t_ref_country_2 (
country_cd STRING(2) NOT NULL OPTIONS(description='The code for the country_2 to which t_site_2 references on. '),
geo_region_cd STRING(20) OPTIONS(description='Surrogate key for the country_2 region_2 of this country_2'),
curr_cd STRING(3)
OPTIONS(description='A three-character code for a currency according to ISO 4217. E.g.:\'EUR\',\'USD\',\'GBP\', …'),
country_descr STRING(100) NOT NULL
OPTIONS(description='Descriptive name of a country_2 e.g. DE- Germany, GB - Great Britain'),
country_descr_de STRING(100) OPTIONS(description='A textual description for country_cd written out in German.'),
country_descr_en STRING(100) OPTIONS(description='A textual description for country_cd written out in English.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (country_cd) NOT ENFORCED
) OPTIONS(description='this is the geographical country_2 with an ISO2 2-letter code e.g. Germany - DE, Italy - IT etc.');