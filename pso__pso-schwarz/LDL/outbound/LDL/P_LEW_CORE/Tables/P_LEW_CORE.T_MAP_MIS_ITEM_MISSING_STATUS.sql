/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_item_missing_status
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:14 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_map_mis_item_missing_status (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
item_status_cd STRING(20) NOT NULL
OPTIONS(description='ELWIS: itm_state_bges_id; pendant: f_lew_core.item_info_per_location'),
missing_state_cd STRING(20) NOT NULL
OPTIONS(description='ELWIS: itm_missing_state; pendant: f_lew_core.t_item_missing_progress'),
missing_reason_cd STRING(20)
OPTIONS(description='ELWIS: itm_missing_reason_cd: pendant: f_lew_core.t_item_missing_progress'),
mis_item_missing_reason_cd STRING(20) OPTIONS(description='ELWIS: itm_missing_reason_cd'),
mis_end_cd_pp STRING(20) OPTIONS(description='ELWIS: end_cd_pp_mis'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, item_status_cd, missing_state_cd) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Tabelle zur Ermittlung des MIS-Item-Missing-Status-Codes;             Inhalt wird manuell gepflegt;             ELWIS: t_r_itm_missing_state_map_mis');