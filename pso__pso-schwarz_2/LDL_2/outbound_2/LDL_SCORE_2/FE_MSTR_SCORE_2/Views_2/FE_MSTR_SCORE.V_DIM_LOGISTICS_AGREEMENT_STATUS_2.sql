/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	|	v_dim_logistics_agreement_status_2
Description		| Agreement status_2 describes the current work status_2/status_2 of the contract. A distinction is made between different forms
Created on    |	25.06.2024
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_logistics_agreement_status_2 (logistics_agmt_status_cd
OPTIONS(description='Status_2 of an agreement'), logistics_agmt_status_descr
OPTIONS(description='Values are: Created, Processed, Checked, Approved, Sent, Signed'))
OPTIONS(DESCRIPTION = `AGREEMENT STATUS_2 DESCRIBES THE CURRENT WORK STATUS_2/STATUS_2 OF THE CONTRACT. A DISTINCTION IS MADE BETWEEN DIFFERENT FORMS.`)
AS SELECT logistics_agmt_status_cd,
 logistics_agmt_status_descr
FROM ldl_score_core.t_dim_logistics_agreement_status_2;