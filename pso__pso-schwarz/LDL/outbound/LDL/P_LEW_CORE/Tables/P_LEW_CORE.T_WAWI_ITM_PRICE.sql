/* --------------------------------------------------------------------------------
   DDL for table: t_wawi_itm_price
   generated from Powerdesigner on Dienstag, 21. November 2023 20:00:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_price (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='DWH-Mandant; FK auf CLIENT; table name before the trans-all migration: client_id'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='column name before the trans-all migration: item_sid'),
pricegroup_id INTEGER NOT NULL OPTIONS(description='column name before the trans-all migration: pricegroup_id'),
dat_valid_from DATE NOT NULL OPTIONS(description='column name before the trans-all migration: dat_valid_from'),
dat_valid_until DATE NOT NULL OPTIONS(description='column name before the trans-all migration: dat_valid_until'),
vat_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='column name before the trans-all migration: vat_id'),
tare_cd BIGNUMERIC(38,0) OPTIONS(description='column name before the trans-all migration: tare_cd'),
price_retail NUMERIC(18,4) OPTIONS(description='column name before the trans-all migration: price_retail'),
price_retail_net NUMERIC(19,5) OPTIONS(description='column name before the trans-all migration: price_retail_net'),
val_refund NUMERIC(18,4) OPTIONS(description='column name before the trans-all migration: val_refund'),
val_net_refund NUMERIC(19,5) OPTIONS(description='column name before the trans-all migration: val_net_refund'),
val_beverage_tax NUMERIC(18,4) OPTIONS(description='column name before the trans-all migration: val_beverage_tax'),
load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id'),
pcwo_reason_id BIGNUMERIC(38,0)
OPTIONS(description='reason identifier for price changes, subset of general set of identifiers of write off and price change reasons                        WAWI:  T201_ITEMPRICES.C201_REASON_ID'),
PRIMARY KEY (item_sid, pricegroup_id, dat_valid_from, dat_valid_until) NOT ENFORCED
) OPTIONS(description='data from WAWI table T201_ITEMPRICES ');