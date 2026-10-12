CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_artbew_wg_mo_gp_sum
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  bewart_id AS bewart_id,
  bewart_det_id AS bewart_det_id,
  CAST(diff_ek_brutto_konz AS BIGNUMERIC) AS diff_ek_brutto_ums_konz,
  CAST(diff_ek_kal_basis_konz AS BIGNUMERIC) AS diff_ek_kbasis_ums_konz,
  CAST(diff_ek_mep_konz AS BIGNUMERIC) AS diff_ek_mep_ums_konz,
  CAST(diff_ek_netto_konz AS BIGNUMERIC) AS diff_ek_n_ums_konz,
  CAST(diff_ek_nettonetto_konz AS BIGNUMERIC) AS diff_ek_nn_ums_konz,
  CAST(diff_logkostenzuschlag_konz AS BIGNUMERIC) AS diff_logkostenzuschlag_konz,
  CAST(diff_umsatz_mwst_betrag_konz AS BIGNUMERIC) AS diff_mwst_betrag_ums_konz,
  CAST(diff_umsatz_netto_konz AS BIGNUMERIC) AS diff_netto_ums_konz,
  CAST(ek_brutto AS BIGNUMERIC) AS ek_brutto_umsatz,
  CAST(ek_kal_basis AS BIGNUMERIC) AS ek_kbasis_umsatz,
  CAST(ek_mep AS BIGNUMERIC) AS ek_mep_umsatz,
  CAST(ek_netto AS BIGNUMERIC) AS ek_n_umsatz,
  CAST(ek_nettonetto AS BIGNUMERIC) AS ek_nn_umsatz,
  kjmo AS kjmo,
  CAST(logkostenzuschlag AS FLOAT64) AS logkostenzuschlag,
  mandant_id AS mandant_id,
  CAST(menge AS FLOAT64) AS vk_menge,
  nb_id AS nb_id,
  CAST(umsatz_mwst_betrag AS FLOAT64) AS umsatz_mwst_betrag,
  CAST(umsatz_netto AS FLOAT64) AS umsatz_netto,
  wg_id AS wg_id,
  wup_id AS wup_id,
  diff_ek_kal_basis_konz - diff_logkostenzuschlag_konz AS diff_ek_nn2_ums_konz,
  ek_kal_basis - logkostenzuschlag AS ek_nn2_umsatz,
  arthiertyp_id AS arthiertyp_id,
  CAST(ek_netto_bnk AS FLOAT64) AS ek_netto_bnk_umsatz,
  CAST(ek_netto_bnk_sachk AS FLOAT64) AS ek_netto_bnk_sachk_umsatz,
  SUBSTR(
    CASE
      WHEN bewart_id = 1001 AND NOT posten_id IN ('PN', 'PF', 'SP')
      THEN ''
      ELSE 'PN'
    END,
    1,
    2
  ) AS posten_id,
  SUBSTR(CASE WHEN NOT posten_id IN ('PN', 'PF', 'SP') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz
FROM kfl_production_dbp_view.v_artbew_wg_mo_sum
WHERE
  mandant_id = 1 AND arthiertyp_id = 2;
