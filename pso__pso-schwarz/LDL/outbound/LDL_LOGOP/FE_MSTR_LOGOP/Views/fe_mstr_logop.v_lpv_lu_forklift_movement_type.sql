/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB view			|	v_lpv_lu_forklift_movement_type
Description		|	LPV Forklift - lookup for FE
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_lu_forklift_movement_type (mvmt_type_nr
OPTIONS(description='Area number (PK)'), mvmt_type_desc OPTIONS(description='Area description'), mvmt_type_desc_de
OPTIONS(description='Area description in German'), mvmt_type_desc_en OPTIONS(description='Area description in English'),
dwh_sort OPTIONS(description='DWH sorting number'), dwh_created OPTIONS(description='DWH creation timestamp'),
dwh_ai_job OPTIONS(description='DWH AbInitio job name'))
OPTIONS(DESCRIPTION = `LPV FORKLIFT - LOOKUP FOR ATTRIBUTE IN FE`) AS SELECT mvmt_type_nr,
 mvmt_type_desc,
 mvmt_type_desc_de,
 IF(mvmt_type_nr = 1, 'Putaway', IF(mvmt_type_nr = 2, 'Replenishment', IF(mvmt_type_nr = 3, 'Direct Putaway', IF(mvmt_type_nr
       = 4, 'Internal Movement', NULL)))) AS mvmt_type_desc_en,
 dwh_sort,
 dwh_created,
 dwh_ai_job
FROM ldl_logop_data.t_lpv_lu_forklift_movement_type;