CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_artbew_vw_sum_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT V1.mandant_id,
 V1.art_id,
 V1.bewart_id,
 V1.bewart_det_id,
 V1.gp_id,
 V1.herst_id,
 V1.dat,
 V1.bezugsweg_id,
  CASE
  WHEN V1.ean_kasse BETWEEN 100000 AND 999999
  THEN V1.ean_kasse * 10000000
  ELSE V1.ean_kasse
  END AS ean_kasse,
 CAST(V1.menge AS BIGNUMERIC) AS vk_menge,
 CAST(V1.umsatz_netto AS BIGNUMERIC) AS umsatz_netto,
 CAST(V1.umsatz_mwst_betrag AS BIGNUMERIC) AS umsatz_mwst_betrag,
 CAST(V1.ek_mep AS BIGNUMERIC) AS ek_mep_umsatz,
 CAST(V1.einstandspreis AS BIGNUMERIC) AS ek_kl_umsatz,
 CAST(V1.ek_nettonetto AS BIGNUMERIC) AS ek_nn_umsatz,
 CAST(V1.diff_einstandspreis_konz AS BIGNUMERIC) AS diff_ek_kl_ums_konz,
 CAST(V1.diff_ek_brutto_konz AS BIGNUMERIC) AS diff_ek_brutto_ums_konz,
 CAST(V1.diff_ek_kal_basis_konz AS BIGNUMERIC) AS diff_ek_kbasis_ums_konz,
 CAST(V1.diff_ek_mep_konz AS BIGNUMERIC) AS diff_ek_mep_ums_konz,
 CAST(V1.diff_ek_netto_konz AS BIGNUMERIC) AS diff_ek_n_ums_konz,
 CAST(V1.diff_ek_nettonetto_konz AS BIGNUMERIC) AS diff_ek_nn_ums_konz,
 CAST(V1.diff_logkostenzuschlag_konz AS BIGNUMERIC) AS diff_logkostenzuschlag_konz,
 CAST(V1.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC) AS diff_mwst_betrag_ums_konz,
 CAST(V1.diff_umsatz_netto_konz AS BIGNUMERIC) AS diff_netto_ums_konz,
 CAST(V1.ek_brutto AS BIGNUMERIC) AS ek_brutto_umsatz,
 CAST(V1.ek_kal_basis AS BIGNUMERIC) AS ek_kbasis_umsatz,
 CAST(V1.ek_netto AS BIGNUMERIC) AS ek_n_umsatz,
 CAST(V1.ek_netto_bnk AS BIGNUMERIC) AS ek_netto_bnk_umsatz,
 CAST(V1.ek_netto_bnk_sachk AS BIGNUMERIC) AS ek_netto_bnk_sachk_umsatz,
 CAST(V1.logkostenzuschlag AS BIGNUMERIC) AS logkostenzuschlag,
 CAST(V1.diff_ek_kal_basis_konz - V1.diff_logkostenzuschlag_konz AS BIGNUMERIC) AS diff_ek_nn2_ums_konz,
 CAST(V1.ek_kal_basis - V1.logkostenzuschlag AS BIGNUMERIC) AS ek_nn2_umsatz,
 V1.wrg_id,
 CAST(CASE
   WHEN V1.bewart_id = 1001 AND V2.posten_id NOT IN ('PN', 'PF', 'SP')
   THEN ''
   ELSE 'PN'
   END AS STRING) AS posten_id_per,
 CAST(CASE
   WHEN V2.posten_id NOT IN ('PN', 'PF', 'SP')
   THEN 'SO'
   ELSE 'PN'
   END AS STRING) AS posten_kz_per,
 V1.wup_bereinigt_fg,
 V1.aktionsart_liste_id,
 V1.aktion_typ_liste_id
FROM kfl_production_dbp_data.artbew_vw_sum_2 AS V1
 LEFT JOIN kfl_production_dbp_view.v_art_per_2 AS V2 ON V1.art_id = V2.art_id AND V1.mandant_id = V2.mandant_id AND V1.dat
   BETWEEN V2.dat_von AND V2.dat_bis
WHERE V1.mandant_id = 1;