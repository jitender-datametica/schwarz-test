/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_workflow_status
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 16:45:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_item_workflow_status (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
workflow_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='identifier of the NFPO item workflow status'),
workflow_status STRING(100) COLLATE 'und:ci' NOT NULL
OPTIONS(description='assigned name of the NFPO item workflow status'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (workflow_status_id) NOT ENFORCED
)
OPTIONS(description='NFPO Item lifecycle status;             Static data:             1 : New             2 : Design in Progress             3 : Quality Data Completed             4 : Design Completed             5 : Confirmed to Buy             6 : Rejected');