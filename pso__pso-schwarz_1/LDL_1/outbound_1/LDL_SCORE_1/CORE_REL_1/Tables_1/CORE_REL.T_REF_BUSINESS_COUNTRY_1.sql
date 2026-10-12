CREATE TABLE IF NOT EXISTS ldl_score_core_rel.t_ref_business_country_1 (
bus_country_cd STRING(2) NOT NULL
OPTIONS(description='A two-character code according to the business definition of Kaufland or Lidl.'),
bus_country_descr STRING(100) NOT NULL
OPTIONS(description='A textual description for the xxx_1 in group language (German).'),
bus_country_descr_de STRING(100) OPTIONS(description='A textual description for the xxx_1 in German.'),
bus_country_descr_en STRING(100) OPTIONS(description='A textual description for the xxx_1 in English.'),
reporting_country_descr STRING(100)
OPTIONS(description='A textual description for the country_1 which is used for the reporting tool.'),
reporting_territory_descr STRING(100)
OPTIONS(description='A textual description for the territory (Bundesland) which is used for the reporting tool.'),
link_to_nat_flag_txt STRING(1000) OPTIONS(description='A link to a picture of the national flag.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.')
) OPTIONS(description='This minor dimension defines the xxx_1');