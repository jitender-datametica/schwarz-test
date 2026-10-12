CREATE OR REPLACE VIEW FE_MSTR_LIFECYCLE.MV_F_LIFECYCLE_RVM_RECEIPT_PER_HOUR_2
AS SELECT
 COUNT (core.t_fact_deposit_receipt.receipt_nr) AS Bons_pro_Stunde
,core.t_fact_deposit_receipt.receipt_hr
,core.t_fact_deposit_receipt.rvm_sid
,core.t_fact_deposit_receipt.receipt_dt
FROM
core.t_fact_deposit_receipt_2
GROUP BY
 receipt_hr
,receipt_dt
,rvm_sid
;