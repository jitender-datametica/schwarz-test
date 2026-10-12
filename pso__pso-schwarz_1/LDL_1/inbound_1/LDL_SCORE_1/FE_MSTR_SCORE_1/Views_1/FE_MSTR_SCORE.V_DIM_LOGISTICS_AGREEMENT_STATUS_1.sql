/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_logistics_agreement_status_1
Description		| Agreement status_1 describes the current work status_1/status_1 of the contract. A distinction is made between different forms
Created on    |	25.06.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_DIM_LOGISTICS_AGREEMENT_STATUS_1(
	LOGISTICS_AGMT_STATUS_CD COMMENT 'Status_1 of an agreement',
	LOGISTICS_AGMT_STATUS_DESCR COMMENT 'Values are: Created, Processed, Checked, Approved, Sent, Signed'
) COMMENT='Agreement status_1 describes the current work status_1/status_1 of the contract. A distinction is made between different forms.'
 AS 
SELECT
   logistics_agmt_status_cd
  ,logistics_agmt_status_descr
FROM CORE.T_DIM_LOGISTICS_AGREEMENT_STATUS_1;