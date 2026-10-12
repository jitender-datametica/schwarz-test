CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_artbew_mo_sum
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT kjmo,
 art_id,
 bewart_id,
 bewart_det_id,
 mandant_id,
 wup_id,
 nb_id,
 gp_id,
 herst_id,
  CASE
  WHEN ean_kasse BETWEEN 100000 AND 999999
  THEN ean_kasse * 10000000
  ELSE ean_kasse
  END AS ean_kasse,
 CAST(diff_logkostenzuschlag_konz AS BIGNUMERIC) AS diff_logkostenzuschlag_konz,
 CAST(diff_ek_brutto_konz AS BIGNUMERIC) AS diff_ek_brutto_ums_konz,
 CAST(diff_ek_kal_basis_konz AS BIGNUMERIC) AS diff_ek_kbasis_ums_konz,
 CAST(diff_ek_mep_konz AS BIGNUMERIC) AS diff_ek_mep_ums_konz,
 CAST(diff_ek_netto_konz AS BIGNUMERIC) AS diff_ek_n_ums_konz,
 CAST(diff_ek_nettonetto_konz AS BIGNUMERIC) AS diff_ek_nn_ums_konz,
 CAST(diff_umsatz_mwst_betrag_konz AS BIGNUMERIC) AS diff_mwst_betrag_ums_konz,
 CAST(diff_umsatz_netto_konz AS BIGNUMERIC) AS diff_netto_ums_konz,
 CAST(ek_brutto AS BIGNUMERIC) AS ek_brutto_umsatz,
 CAST(ek_kal_basis AS BIGNUMERIC) AS ek_kbasis_umsatz,
 CAST(ek_mep AS BIGNUMERIC) AS ek_mep_umsatz,
 CAST(ek_netto AS BIGNUMERIC) AS ek_n_umsatz,
 CAST(ek_nettonetto AS BIGNUMERIC) AS ek_nn_umsatz,
 CAST(umsatz_mwst_betrag AS BIGNUMERIC) AS umsatz_mwst_betrag,
 CAST(umsatz_netto AS BIGNUMERIC) AS umsatz_netto,
 CAST(menge AS BIGNUMERIC) AS vk_menge,
 CAST(diff_ek_kal_basis_konz - diff_logkostenzuschlag_konz AS BIGNUMERIC) AS diff_ek_nn2_ums_konz,
 CAST(diff_einstandspreis_konz AS BIGNUMERIC) AS diff_ek_kl_ums_konz,
 CAST(einstandspreis AS BIGNUMERIC) AS ek_kl_umsatz,
 CAST(ek_kal_basis - logkostenzuschlag AS BIGNUMERIC) AS ek_nn2_umsatz,
 CAST(logkostenzuschlag AS BIGNUMERIC) AS logkostenzuschlag,
 CAST(ek_netto_bnk AS BIGNUMERIC) AS ek_netto_bnk_umsatz,
 CAST(ek_netto_bnk_sachk AS BIGNUMERIC) AS ek_netto_bnk_sachk_umsatz,
  CASE
  WHEN bewart_id = 1001 AND posten_id NOT IN ('PN', 'PF', 'SP')
  THEN ''
  ELSE 'PN'
  END AS posten_id_,
 CAST(CASE
   WHEN posten_id NOT IN ('PN', 'PF', 'SP')
   THEN 'SO'
   ELSE 'PN'
   END AS STRING) AS posten_kz,
 aktionsart_liste_id,
 aktion_typ_liste_id
FROM kfl_production_dbp_data.artbew_mo_sum
WHERE mandant_id = 1;