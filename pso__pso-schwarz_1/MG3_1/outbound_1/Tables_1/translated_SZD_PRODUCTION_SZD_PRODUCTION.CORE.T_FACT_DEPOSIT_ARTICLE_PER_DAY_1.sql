CREATE OR REPLACE TABLE szd_production_core.t_fact_deposit_article_per_day_1 (
item_sid INTEGER NOT NULL OPTIONS(description='The unique identifier for an item_1'),
rvm_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
lob_cd STRING(50) NOT NULL
OPTIONS(description='The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland lob=line os business'),
country_pol_cd STRING(2) NOT NULL OPTIONS(description='The code identifying a political country_1 according to ISO 3166.'),
item_gtin STRING(20) NOT NULL OPTIONS(description='A European article number'),
return_dt DATE NOT NULL OPTIONS(description='The date for returned deposit articles.'),
return_cnt INTEGER NOT NULL OPTIONS(description='The number for the item_1 return'),
item_container_type_cd STRING(50) NOT NULL
OPTIONS(description='The description of a container which can be foreign or own container'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (item_sid, rvm_sid, return_dt) NOT ENFORCED
) OPTIONS(description='A table for the deposit articles per day of RVMs');