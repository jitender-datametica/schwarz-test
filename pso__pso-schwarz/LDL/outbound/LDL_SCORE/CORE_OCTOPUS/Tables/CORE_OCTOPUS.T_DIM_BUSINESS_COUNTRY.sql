CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_business_country (
bus_country_cd STRING(2) NOT NULL OPTIONS(description='Business country to which the good is dedicated to'),
bus_country_descr STRING(100)
OPTIONS(description='A textual description for bus_country_cd (written out) in group language (German).'),
reporting_country_descr STRING(100)
OPTIONS(description='The code for the country which is used for the reporting tool '),
reporting_territory_descr STRING(100)
OPTIONS(description='The code for the territory (Bundesland) which is used for the reporting tool '),
link_to_nat_flag_txt STRING(1000)
OPTIONS(description='The reporting tool uses a small picture file to show the national flag of the business country. This attribute contains the link to this file.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (bus_country_cd) NOT ENFORCED
)
OPTIONS(description='The country defined by Lidl terms. It is different from a political country e.g. Beligum and Luxemburg or Spain and its islands. In this case Lidl separates the countries by its geographical borders.');