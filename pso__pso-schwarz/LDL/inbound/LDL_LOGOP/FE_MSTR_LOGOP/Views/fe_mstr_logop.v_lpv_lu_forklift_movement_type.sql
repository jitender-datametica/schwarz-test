/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_lpv_lu_forklift_movement_type
Description		|	LPV Forklift - lookup for FE
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_LOGOP.V_LPV_LU_FORKLIFT_MOVEMENT_TYPE(
	MVMT_TYPE_NR COMMENT 'Area number (PK)',
	MVMT_TYPE_DESC COMMENT 'Area description',
	MVMT_TYPE_DESC_DE COMMENT 'Area description in German',
	MVMT_TYPE_DESC_EN COMMENT 'Area description in English',
	DWH_SORT COMMENT 'DWH sorting number',
	DWH_CREATED COMMENT 'DWH creation timestamp',
	DWH_AI_JOB COMMENT 'DWH AbInitio job name'
) COMMENT='LPV Forklift - lookup for attribute in FE'
AS
SELECT
	 mvmt_type_nr
	,mvmt_type_desc
	,mvmt_type_desc_de
	,IFF(mvmt_type_nr =1,'Putaway'
	,IFF(mvmt_type_nr = 2,'Replenishment'
	,IFF(mvmt_type_nr = 3,'Direct Putaway'
	,IFF(mvmt_type_nr = 4,'Internal Movement',NULL)))) AS mvmt_type_desc_en 
	,dwh_sort
	,dwh_created
	,dwh_ai_job
FROM DATA.t_lpv_lu_forklift_movement_type;
