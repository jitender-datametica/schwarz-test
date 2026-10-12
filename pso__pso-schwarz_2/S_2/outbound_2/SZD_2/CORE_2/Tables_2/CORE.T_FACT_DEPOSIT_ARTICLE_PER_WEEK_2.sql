CREATE TABLE IF NOT EXISTS szd_core.t_fact_deposit_article_per_week_2 (
item_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier for an item_2'),
rvm_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the despotie machine which is located in a store'),
lob_cd STRING(50) NOT NULL
OPTIONS(description='The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland lob=line os business'),
country_pol_cd STRING(2) NOT NULL OPTIONS(description='The code identifying a political country_2 according to ISO 3166.'),
item_gtin STRING(20) NOT NULL OPTIONS(description='A European article number'),
cy_week BIGNUMERIC NOT NULL
OPTIONS(description='The week containing the partial week as a number of the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the year. I.e. the week that was split to form this partial week. '),
reject_cnt BIGNUMERIC NOT NULL OPTIONS(description='The number for the item_2 rejections.'),
return_cnt BIGNUMERIC NOT NULL OPTIONS(description='The number for the item_2 return'),
item_container_type_cd STRING(50) NOT NULL
OPTIONS(description='The description of a container which can be foreign or own container'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (item_sid, rvm_sid, cy_week) NOT ENFORCED
) OPTIONS(description='A table for the deposit articles per week of RVMs');