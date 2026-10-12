/* --------------------------------------------------------------------------------
   DDL for table: t_movement_type_detail
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_movement_type_detail (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
move_type_dtl_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key MOVEMENT TYPE DETAIL'),
src_bwart STRING(20) NOT NULL OPTIONS(description='Bewegungsart; SAP-Retail: T156T.BWART'),
src_sobkz STRING(20) NOT NULL OPTIONS(description='Sonderbestandskennzeichen: T156T.SOBKZ'),
src_kzbew STRING(20) NOT NULL OPTIONS(description='Bewegungskennzeichen: T156T.KZBEW'),
src_kzzug STRING(20) NOT NULL OPTIONS(description='Zugangskennzeichen: T156T.KZZUG'),
src_kzvbr STRING(20) NOT NULL OPTIONS(description='Verbrauchsbuchung: T156T.KZVBR'),
move_type_dtl_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Verbrauchsbuchung: T156T.BTEXT in Stiftungssprache'),
move_type_cd STRING(20) OPTIONS(description='Bewegungsart; SAP-Retail: T156T.BWART'),
special_stock_mark STRING(20) OPTIONS(description='Sonderbestandskennzeichen: T156T.SOBKZ'),
special_stock_label STRING(100) COLLATE 'und:ci' OPTIONS(description='Sonderbestand - Beschreibung'),
move_indicator_mark STRING(20) OPTIONS(description='Bewegungskennzeichen: T156T.KZBEW'),
move_indicator_label STRING(100) COLLATE 'und:ci' OPTIONS(description='Bewegungskennzeichen Beschreibung'),
receipt_indicator_mark STRING(20) OPTIONS(description='Zugangskennzeichen: T156T.KZZUG'),
receipt_indicator_label STRING(100) COLLATE 'und:ci' OPTIONS(description='Zugangskennzeichen - Beschreibung'),
consumption_posting_mark STRING(20) OPTIONS(description='Verbrauchsbuchung: T156T.KZVBR'),
consumption_posting_label STRING(100) COLLATE 'und:ci' OPTIONS(description='Verbrauchsbuchung - Beschreibung'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (move_type_dtl_sid) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. IMTD; Bewegungsart-Detail;              SAP-Retail: t156t;             SAP-BW: z_ds_matd0005;             https://lzp.lidl.net/sites/p370/WIKI/DWH-Core.aspx');