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

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT_TERM_TYPE_2(
	INDIVIDUAL_LOGISTICS_AGMT_TERM_TYPE_CD COMMENT 'The term type of an individual logistic agreement ',
	INDIVIDUAL_LOGISTICS_AGMT_TERM_TYPE_DESCR COMMENT 'The description of an individual logistic term type code: can be Individual Logistics Project or Individual Logistics Contract.'
) COMMENT='The term type of an individual logistic agreement (Individual Logistics Project or Individual Logistics Contract) distinguishes Agreement based on their duration.'
 AS 
 SELECT
   individual_logistics_agmt_term_type_cd
  ,individual_logistics_agmt_term_type_descr
FROM CORE.T_DIM_INDIVIDUAL_LOGISTICS_AGREEMENT_TERM_TYPE_2;