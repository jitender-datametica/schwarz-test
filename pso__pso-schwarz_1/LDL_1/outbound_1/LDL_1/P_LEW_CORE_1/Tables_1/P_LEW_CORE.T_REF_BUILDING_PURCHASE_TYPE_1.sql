/* --------------------------------------------------------------------------------
   DDL for table: t_ref_building_purchase_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_building_purchase_type_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='unique identifier of the DWH client / slice'),
purchase_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='purchase type code'),
purchase_type_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='purchase type description;'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, purchase_type_id) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Description of how the rigth of owning the building is purchased (buying, renting, leasing)');