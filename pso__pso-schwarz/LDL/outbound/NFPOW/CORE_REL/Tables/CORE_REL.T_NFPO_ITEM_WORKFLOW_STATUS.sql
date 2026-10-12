CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_workflow_status (
nfpo_item_workflow_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='PK Item Workflow Status;'),
nfpo_item_workflow_status_descr STRING(250) NOT NULL OPTIONS(description='Item Workflow Status;'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_workflow_status_id) NOT ENFORCED
)
OPTIONS(description='NFPO Item lifecycle status;             Static data:             1 : New             2 : Design in Progress             3 : Quality Data Completed             4 : Design Completed             5 : Confirmed to Buy             6 : Rejected');