/* --------------------------------------------------------------------------------
   DDL for table: t_ref_building_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_building_type_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
building_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='building type code; IMS_ESB: object.info.type'),
building_type_descr STRING(100) COLLATE 'und:ci'
OPTIONS(description='description of the building type; IMS_ESB: business initial load'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, building_type_id) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Description of building types, such as Store, Warehouse, Apartment, ...');