CREATE OR REPLACE TABLE ldl_p_lew_core.t_mdm_price_type_1 (
mdm_price_type_cd STRING(100) NOT NULL OPTIONS(description='representing code of the price type'),
mdm_price_type_name STRING(100) OPTIONS(description='name of the price type'),
mdm_price_type_descr STRING(250) OPTIONS(description='description of the price type'),
lob_fg INTEGER
OPTIONS(description='indicates whether the price type has different prices for different lines of business (LDL/KFL)'),
market_fg INTEGER
OPTIONS(description='indicates whether the price type has different prices for different markets_1 (EU/US)'),
incoterm_fg INTEGER
OPTIONS(description='indicates whether the price type has different prices for different incoterms (FOB/DDP)'),
int_org_fg INTEGER
OPTIONS(description='indicates whether the price type has different prices for different targeted internal organisations'),
dwh_load_id INTEGER NOT NULL OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp_ntz(9) of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp_ntz(9) of the last update of the record in the DWH'),
PRIMARY KEY (mdm_price_type_cd) NOT ENFORCED
) OPTIONS(description='price types used in the non food product development and ordering process');