CREATE TABLE IF NOT EXISTS szd_core.t_dim_company_2 (
company_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The Company number of a store e.g. 13'),
company_name STRING(100) NOT NULL,
country_pol_cd STRING(3) NOT NULL OPTIONS(description='The code identifying a political country_2 according to ISO 3166.'),
lob_cd STRING(50) NOT NULL
OPTIONS(description='The code for the line of business within the Schwarz Group, i.e.Lidl or Kauflandlob=line os business'),
street_name STRING(100) OPTIONS(description='The name of the street where the store is located.'),
house_nr STRING(20) OPTIONS(description='The number of the building within the street where the store is located.'),
city_name STRING(100) OPTIONS(description='The name of the city where the store is located.'),
zip STRING(15) OPTIONS(description='The postal code of the store address.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (company_id, lob_cd, country_pol_cd) NOT ENFORCED
)
OPTIONS(description='The company identifies the name under which a store is affiliated e.g. Kob Lidl GmbH & Co. KG, KL Vertrieb KAPPA GmbH&Co...');