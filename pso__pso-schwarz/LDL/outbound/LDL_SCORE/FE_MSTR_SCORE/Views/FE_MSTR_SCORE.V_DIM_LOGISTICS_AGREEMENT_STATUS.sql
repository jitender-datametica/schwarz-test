/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_logistics_agreement_status
Description		| Agreement status describes the current work status/status of the contract. A distinction is made between different forms
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_logistics_agreement_status (logistics_agmt_status_cd
OPTIONS(description='Status of an agreement'), logistics_agmt_status_descr
OPTIONS(description='Values are: Created, Processed, Checked, Approved, Sent, Signed'))
OPTIONS(DESCRIPTION = `AGREEMENT STATUS DESCRIBES THE CURRENT WORK STATUS/STATUS OF THE CONTRACT. A DISTINCTION IS MADE BETWEEN DIFFERENT FORMS.`)
AS SELECT logistics_agmt_status_cd,
 logistics_agmt_status_descr
FROM ldl_score_core.t_dim_logistics_agreement_status;