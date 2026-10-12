-- 03.05.2023 twie: INC6523697 wird in MSI nur auf Tagesebene ausgewertet, deshalb die Belege aufsummieren

CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_f_lifecycle_rvm_deposit_cash_data_2 (receipt_dt, store_nr, country_pol_cd,
lob_cd, local_curr_cd, global_curr_cd, deposit_outpayment_type_cd, store_sid, deposit_local_val, deposit_global_val) AS
SELECT receipt_dt,
 store_nr,
 country_pol_cd,
 lob_cd,
 local_curr_cd,
 global_curr_cd,
 deposit_outpayment_type_cd,
 store_sid,
 SUM(deposit_local_val) AS deposit_local_val,
 SUM(deposit_global_val) AS deposit_global_val
FROM szd_core.t_fact_deposit_cash_data_2 AS V01
GROUP BY receipt_dt,
 store_nr,
 country_pol_cd,
 lob_cd,
 local_curr_cd,
 global_curr_cd,
 deposit_outpayment_type_cd,
 store_sid;