/* --------------------------------------------------------------------------------
   DDL for table: t_ref_planned_cycle
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:16 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_planned_cycle (
cycle_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='id of the cycle to derive stock correction requests from a plan'),
cycle_descr STRING(100) NOT NULL
OPTIONS(description='description of the cycle to derive stock correction requests from a plan'),
cycle_descr_en STRING(100) NOT NULL
OPTIONS(description='english description of the cycle to derive stock correction requests from a plan'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (cycle_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. Table contains the cycles to create requests from a plan;             Source: static reference');