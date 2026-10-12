/* --------------------------------------------------------------------------------
   DDL for table: t_ref_building_closing_reason_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_building_closing_reason_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
closing_reason_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='IMS_ESB : identifier for the reason of closing : object.status_1-development.status.status_1-date.closing-reason-id'),
closing_reason_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='IMS_ESB : description for the reason of closing : initial load from business'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, closing_reason_id) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Description of the reason for closing a building (permanently or temporary)');