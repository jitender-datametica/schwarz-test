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


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_logistics_agreement_status_1 (logistics_agmt_status_cd
OPTIONS(description='Status_1 of an agreement'), logistics_agmt_status_descr
OPTIONS(description='Values are: Created, Processed, Checked, Approved, Sent, Signed'))
OPTIONS(DESCRIPTION = `AGREEMENT STATUS_1 DESCRIBES THE CURRENT WORK STATUS_1/STATUS_1 OF THE CONTRACT. A DISTINCTION IS MADE BETWEEN DIFFERENT FORMS.`)
AS SELECT logistics_agmt_status_cd,
 logistics_agmt_status_descr
FROM ldl_score_core.t_dim_logistics_agreement_status_1;