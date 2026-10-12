/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_pcwo_id_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_map_mis_pcwo_id_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
move_type_cd STRING(20) NOT NULL
OPTIONS(description='ELWIS: mov_type_cd; pendant: f_lew_core.t_item_movement_record_pos_2'),
move_reason_cd STRING(20) NOT NULL
OPTIONS(description='ELWIS: mov_reason_cd; pendant: f_lew_core.t_item_movement_record_pos_2'),
move_reason_descr STRING(100) OPTIONS(description='ELWIS: mov_reason_descr'),
mis_pcwo_reason_id BIGNUMERIC(38,0) OPTIONS(description='ELWIS: pcwo_reason_id'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, move_type_cd, move_reason_cd) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Tabelle zur Ermittlung des MIS-PCWO-REASON-ID;             Inhalt wird manuell gepflegt;             ELWIS: t_r_pcwo_id_mis');