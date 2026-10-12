/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_individual_logistics_agreement_type_2
Description		| Type of an individual logistic agreement (land_2 and sea freight types)
Created on    |	02.11.2023
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_individual_logistics_agreement_type_2 (individual_logistics_agmt_type_cd
OPTIONS(description='The type of an individual logistic agreement'), individual_logistics_agmt_type_descr
OPTIONS(description='The description of an individual logistic type code: can be land_2 freight or sea freight'))
OPTIONS(DESCRIPTION = `THE TYPE OF AN INDIVIDUAL LOGISTIC AGREEMENT (LAND_2 AND SEA FREIGHT TYPES)`) AS SELECT
 individual_logistics_agmt_type_cd,
 individual_logistics_agmt_type_descr
FROM ldl_score_core.t_dim_individual_logistics_agreement_type_2;