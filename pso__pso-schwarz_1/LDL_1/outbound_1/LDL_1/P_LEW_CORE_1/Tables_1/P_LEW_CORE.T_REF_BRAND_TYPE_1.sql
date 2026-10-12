/* --------------------------------------------------------------------------------
   DDL for table: t_ref_brand_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_brand_type_1 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='FK MDM Client;            CBX: Static 7 (Stiftung);            ESB: Static 7 (Stiftung);'),
brand_type_cd STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='PK Brand_1 Type;'),
brand_type STRING(100) OPTIONS(description='Brand_1 Type;'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.')
)
OPTIONS(description='$Revision: 0000 $ Brand_1 Type;             Static data:             M: Marke             EM: Eigenmarke');