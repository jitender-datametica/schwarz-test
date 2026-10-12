CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_vat_rates AS SELECT CLNT.src_country_lidl_cd AS country_lidl_cd,
 RV.vat_id AS vat_code,
 RV.pct_vat AS vat_rate,
 RV.vat_desc AS vat_descr,
 RLEN.language_id
FROM ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values AS RV
 INNER JOIN ldl_p_lew_core_ac.v_client AS CLNT ON RV.client_id = CLNT.client_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_language AS RLEN ON CLNT.src_country_lidl_cd = RLEN.language_iso_cd OR RLEN.language_iso_cd
    = 'EU'
WHERE CURRENT_DATE BETWEEN RV.dat_rec_start AND RV.dat_rec_end
 AND RV.vat_id >= 0
 AND RV.pct_vat IS NOT NULL;