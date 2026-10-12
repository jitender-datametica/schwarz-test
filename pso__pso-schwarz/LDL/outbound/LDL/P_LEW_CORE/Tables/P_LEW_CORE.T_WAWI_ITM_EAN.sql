/* --------------------------------------------------------------------------------
   DDL for table: t_wawi_itm_ean
   generated from Powerdesigner on Freitag, 27. Oktober 2023 10:49:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_wawi_itm_ean (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='DWH-Mandant; FK auf CLIENT; table name before the trans-all migration: client_id'),
item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Systemgenerierte Artikelnummer; table name before the trans-all migration: item_sid'),
dat_rec_start DATE NOT NULL OPTIONS(description='column name before the trans-all migration: dat_rec_start'),
dat_rec_end DATE NOT NULL OPTIONS(description='column name before the trans-all migration: dat_rec_end'),
ean STRING(13) COLLATE 'und:ci' NOT NULL OPTIONS(description='column name before the trans-all migration: ean'),
ean_item_desc STRING(50) OPTIONS(description='column name before the trans-all migration: ean_item_desc'),
ean_item_long_descr STRING(250)
OPTIONS(description='extended desription of the EAN            WAWI: ARTEANCODES.ONLINE_DESC'),
custom_nr STRING(100) COLLATE 'und:ci' OPTIONS(description='column name before the trans-all migration: custom_nr'),
custom_key STRING(100) COLLATE 'und:ci' OPTIONS(description='column name before the trans-all migration: custom_key'),
language_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Sprache; table name before the trans-all migration: language_id'),
load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id'),
PRIMARY KEY (client_id, item_sid, dat_rec_start, language_id) NOT ENFORCED
) OPTIONS(description='$Revision: 5995 $. Auto Generated  9/27/2017');