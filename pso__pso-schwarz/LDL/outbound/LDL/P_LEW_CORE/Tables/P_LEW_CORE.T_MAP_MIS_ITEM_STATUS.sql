/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_item_status
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_map_mis_item_status (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
item_status_cd STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ELWIS: p_core_data.t_r_itm_state_map_mis.itm_state_bges_id'),
item_status_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='ELWIS: p_core_data.t_r_itm_state_map_mis.itm_state_descr'),
mis_itm_state_id BIGNUMERIC(38,0) OPTIONS(description='ELWIS: mis_itm_state_id'),
mis_state_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='ELWIS: mis_state_descr'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. Tabelle zur Ermittlung des MIS-Item-Status-Codes;             Inhalt wird manuell gepflegt;             ELWIS: t_r_itm_state_map_mis');