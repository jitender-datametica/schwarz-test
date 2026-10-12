/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_item_missing_reason_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_map_mis_item_missing_reason_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
missing_reason_cd STRING(20) NOT NULL
OPTIONS(description='ELWIS: x_bdo_coex_data.t_ref_miss_reason_map.elwis_itm_miss_reason_cd; pendant: f_lew_core.t_item_missing_progress.missing_reason_cd'),
mis_item_missing_reason_cd STRING(20)
OPTIONS(description='ELWIS: x_bdo_coex_data.t_ref_miss_reason_map.wawi_itm_miss_reason_cd;'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, missing_reason_cd) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Tabelle zum Mapping zwischen WAWI und SAP Missing-Reason-Codes;             Inhalt wird manuell gepflegt;             COEX: x_bdo_coex_data.t_ref_miss_reason_map');