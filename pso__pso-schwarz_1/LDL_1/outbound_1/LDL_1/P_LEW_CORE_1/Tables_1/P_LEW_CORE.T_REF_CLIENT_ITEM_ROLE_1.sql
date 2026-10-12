/* --------------------------------------------------------------------------------
   DDL for table: t_ref_client_item_role_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_client_item_role_1 (
client_system STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='System (SAP, WAWI...)'),
client_item_role_cd STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='PK'),
client_item_role STRING(100) COLLATE 'und:ci' NOT NULL OPTIONS(description='Mutable description'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.')
)
OPTIONS(description='$Revision: 0000 $ Item_1 role in client;             SAP : ZBA_0 : Bestellartikel - Konfigurationsmaterial             SAP : ZBA_1 : Bestellartikel - Verkaufsvariante             SAP : ZBA_2 : Bestellartikel - Logistische Variante             SAP : ZSK : Sortierkarton - Stucklistenkopf             SAP : ZEA : Einzelartikel             WAWI : WAWI_SK : Sortierkarton');