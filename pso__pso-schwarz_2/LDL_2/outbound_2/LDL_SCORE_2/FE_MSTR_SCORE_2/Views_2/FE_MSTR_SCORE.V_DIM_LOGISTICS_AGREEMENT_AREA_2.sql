/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_logistics_agreement_area_2
Description		| This table defines areas of logistics agreement. For example Logistics and Import.
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_logistics_agreement_area_2 (logistics_agmt_area_cd
OPTIONS(description='Code of Logistics agreement area, for example: IMP/LOG.'), logistics_agmt_area_descr
OPTIONS(description='Description of logistics agreement area, for example: Import/Logistik.'))
OPTIONS(DESCRIPTION = `THIS TABLE DEFINES AREAS OF LOGISTICS AGREEMENT. FOR EXAMPLE LOGISTICS AND IMPORT.`) AS SELECT
 logistics_agmt_area_cd,
 logistics_agmt_area_descr
FROM ldl_score_core.t_dim_logistics_agreement_area_2;