/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_lpv_lu_forklift_movement_type
Description		|	LPV Forklift - lookup for FE
====================================================================================================
*/


CREATE TABLE IF NOT EXISTS ldl_logop_data.t_lpv_lu_forklift_movement_type (
mvmt_type_nr NUMERIC(2) NOT NULL
OPTIONS(description='Movement type number (Technical number with no business requirement)'),
mvmt_type_desc STRING(100) NOT NULL OPTIONS(description='Movement type description'),
mvmt_type_desc_de STRING(100) NOT NULL OPTIONS(description='Movement type description in German'),
dwh_sort NUMERIC(3) OPTIONS(description='DWH sorting number'),
dwh_created DATETIME OPTIONS(description='DWH creation timestamp'),
dwh_ai_job STRING(50) OPTIONS(description='DWH AbInitio job name'),
PRIMARY KEY (mvmt_type_nr) NOT ENFORCED
) OPTIONS(description='LPV Forklift - lookup for FE');