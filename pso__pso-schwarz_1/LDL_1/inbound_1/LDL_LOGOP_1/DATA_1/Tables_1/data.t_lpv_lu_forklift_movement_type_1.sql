/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	data
DB view			|	t_lpv_lu_forklift_movement_type_1
Description		|	LPV Forklift - lookup for FE
====================================================================================================
*/

CREATE TABLE DATA.t_lpv_lu_forklift_movement_type_1 (
	mvmt_type_nr NUMBER(2) NOT NULL COMMENT 'Movement type number (Technical number with no business requirement)',
	mvmt_type_desc VARCHAR(100) NOT NULL COMMENT 'Movement type description',
	mvmt_type_desc_de VARCHAR(100) NOT NULL COMMENT 'Movement type description in German',
	dwh_sort NUMBER(3) COMMENT 'DWH sorting number',
	dwh_created TIMESTAMP_NTZ(9) COMMENT 'DWH creation timestamp',
	dwh_ai_job VARCHAR(50) COMMENT 'DWH AbInitio job name',
	PRIMARY KEY (mvmt_type_nr)
	)
COMMENT = 'LPV Forklift - lookup for FE'
;
