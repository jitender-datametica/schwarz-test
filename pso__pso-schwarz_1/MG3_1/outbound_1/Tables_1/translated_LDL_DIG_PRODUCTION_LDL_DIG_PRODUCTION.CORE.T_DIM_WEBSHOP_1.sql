CREATE OR REPLACE TABLE ldl_dig_production_core.t_dim_webshop_1 (
wshop_cd STRING(5) NOT NULL
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1'),
wshop_name_de STRING(250) NOT NULL
OPTIONS(description='The name for the Lidl webshop, where an order can be placed by a customer'),
wshop_name_en STRING(250)
OPTIONS(description='The name for the Lidl webshop, where an order can be placed by a customer in English.'),
wshop_display_order_nr INTEGER
OPTIONS(description='The number indicates in which order the webshop will appear in front end '),
country_cd STRING(5)
OPTIONS(description='The unique code for a country_1 according to ISO-3166 Alpha-2. E.g. DE for Germany or FR for France'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wshop_cd) NOT ENFORCED
)
OPTIONS(description='There is one webshop per each country_1 where Lidl webshop operates. The gobal weshop has a code\'INTEGER\'');