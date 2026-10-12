/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_individual_logistics_agreement_term_type_2
Description		| The term type of an individual logistic agreement (Individual Logistics Project or Individual Logistics Contract) distinguishes Agreement based on their duration.
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_individual_logistics_agreement_term_type_2 (individual_logistics_agmt_term_type_cd
OPTIONS(description='The term type of an individual logistic agreement '), individual_logistics_agmt_term_type_descr
OPTIONS(description='The description of an individual logistic term type code: can be Individual Logistics Project or Individual Logistics Contract.'))
OPTIONS(DESCRIPTION = `THE TERM TYPE OF AN INDIVIDUAL LOGISTIC AGREEMENT (INDIVIDUAL LOGISTICS PROJECT OR INDIVIDUAL LOGISTICS CONTRACT) DISTINGUISHES AGREEMENT BASED ON THEIR DURATION.`)
AS SELECT individual_logistics_agmt_term_type_cd,
 individual_logistics_agmt_term_type_descr
FROM ldl_score_core.t_dim_individual_logistics_agreement_term_type_2;