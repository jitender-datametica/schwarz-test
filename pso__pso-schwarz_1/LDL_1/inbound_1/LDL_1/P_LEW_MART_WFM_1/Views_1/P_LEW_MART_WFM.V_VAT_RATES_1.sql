CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_VAT_RATES_1
AS
   SELECT
        clnt.src_country_lidl_cd AS country_lidl_cd,
   rv.vat_id                AS vat_code,
   rv.pct_vat               AS vat_rate,
   rv.vat_desc              AS vat_descr,
   rlen.language_id         AS language_id
   FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 rv
   INNER JOIN p_lew_core_ac.v_client_1 clnt
   ON rv.client_id = clnt.client_id
   INNER JOIN p_lew_core_ac.v_wawi_ref_language_1 rlen
   ON (clnt.src_country_lidl_cd = rlen.language_iso_cd
   OR rlen.language_iso_cd = 'EU')

/* Conditions:
      - only actual valid records from v_wawi_ref_vat_1
      - only records with positive VAT_ID or zero
      - only records with pct_vat NOT NULL
*/
WHERE Current_Date BETWEEN rv.dat_rec_start AND rv.dat_rec_end
AND rv.vat_id >= 0
AND rv.pct_vat IS NOT NULL
;