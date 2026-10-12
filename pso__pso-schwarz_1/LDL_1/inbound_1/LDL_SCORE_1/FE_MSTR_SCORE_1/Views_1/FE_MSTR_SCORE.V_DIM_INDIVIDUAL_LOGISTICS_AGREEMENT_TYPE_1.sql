/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_individual_logistics_agreement_type_1
Description		| Type of an individual logistic agreement (land_1 and sea freight types)
Created on    |	02.11.2023
====================================================================================================
*/

CREATE OR REPLACE VIEW fe_mstr_score.v_dim_individual_logistics_agreement_type_1 (
  individual_logistics_agmt_type_cd  COMMENT 'The type of an individual logistic agreement',
  individual_logistics_agmt_type_descr COMMENT 'The description of an individual logistic type code: can be land_1 freight or sea freight'
)COMMENT = 'The type of an individual logistic agreement (land_1 and sea freight types)'
AS
SELECT
   individual_logistics_agmt_type_cd
  ,individual_logistics_agmt_type_descr
FROM core.t_dim_individual_logistics_agreement_type_1;
