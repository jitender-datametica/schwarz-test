/* --------------------------------------------------------------------------------
   DDL for table: t_item_group_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_item_group_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_1; FK auf CLIENT'),
item_grp_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key ITEM_1 GROUP'),
src_matkl STRING(20)
OPTIONS(description='Warengruppen-Code (SAP-Retail); SAP-Retail: t023.matkl; SAP-BW: t_bw_0matl_group_text.matkl'),
src_wawi_cd STRING(20) OPTIONS(description='Warengruppen-Code (WAWI)'),
item_grp_name STRING(100) COLLATE 'und:ci'
OPTIONS(description='Bezeichnung in Stiftungssprache; SAP-Retail: t023t.wgbez; SAP-BW: t_bw_0matl_group_text.wgbez'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (item_grp_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. IGRP; Warengruppen;              SAP-Retail: T023_1;              SAP-BW: t_bw_0matl_group_text;             WAWI-Tabelle             Code wahrscheinlich 1:1 Subitemgroup');