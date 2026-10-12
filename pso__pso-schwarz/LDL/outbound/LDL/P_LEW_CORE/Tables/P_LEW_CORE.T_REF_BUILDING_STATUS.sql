/* --------------------------------------------------------------------------------
   DDL for table: t_ref_building_status
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_building_status (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
building_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='building status describing the lifecycle; IMS_ESB: object.status-development.status.id'),
building_status_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='building status description; IMS_ESB: status    master-data.objects_status.object_status.name.lang                                                                                      status_* master-data.objects_status.object_status.name.name (lang=*)            '),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, building_status_id) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Description of building status representing the building lifecycle from initialization, via opening to closing (and steps in between); but also building rejected or finally closed ');