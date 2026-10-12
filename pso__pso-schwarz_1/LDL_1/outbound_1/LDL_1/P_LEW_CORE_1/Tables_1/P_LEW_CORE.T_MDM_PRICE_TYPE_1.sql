CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_price_type_1 (
mdm_price_type_cd STRING(100) NOT NULL OPTIONS(description='representing code of the price type'),
mdm_price_type_name STRING(100) OPTIONS(description='name of the price type'),
mdm_price_type_descr STRING(250) OPTIONS(description='description of the price type'),
lob_fg BIGNUMERIC(38,0)
OPTIONS(description='indicates whether the price type has different prices for different lines of business (LDL/KFL)'),
market_fg BIGNUMERIC(38,0)
OPTIONS(description='indicates whether the price type has different prices for different markets_1 (EU/US)'),
incoterm_fg BIGNUMERIC(38,0)
OPTIONS(description='indicates whether the price type has different prices for different incoterms (FOB/DDP)'),
int_org_fg BIGNUMERIC(38,0)
OPTIONS(description='indicates whether the price type has different prices for different targeted internal organisations'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_price_type_cd) NOT ENFORCED
) OPTIONS(description='price types used in the non food product development and ordering process');