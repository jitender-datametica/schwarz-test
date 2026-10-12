CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artbew_vw_sum_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.umsatz_mwst_betrag AS umsatz_mwst_betrag,
  v01.diff_umsatz_mwst_betrag_konz AS diff_umsatz_mwst_betrag_konz,
  v01.umsatz_netto AS umsatz_netto,
  v01.diff_umsatz_netto_konz AS diff_umsatz_netto_konz,
  v01.menge AS menge,
  v01.ek_nettonetto AS ek_nettonetto,
  v01.diff_ek_nettonetto_konz AS diff_ek_nettonetto_konz,
  v01.ek_mep AS ek_mep,
  v01.diff_ek_mep_konz AS diff_ek_mep_konz,
  v01.einstandspreis AS einstandspreis,
  v01.diff_einstandspreis_konz AS diff_einstandspreis_konz,
  v01.bewart_id AS bewart_id,
  v01.bewart_det_id AS bewart_det_id,
  v02.posten_id AS posten_id,
  v01.wup_bereinigt_fg AS wup_bereinigt_fg,
  v01.pv_aktion AS pv_aktion,
  v01.pv_aktion_konz AS pv_aktion_konz,
  v01.pv_aktion_bby AS pv_aktion_bby,
  v01.pv_aktion_bby_konz AS pv_aktion_bby_konz,
  v01.pv_aktion_kdn_bby AS pv_aktion_kdn_bby,
  v01.pv_aktion_kdn_bby_konz AS pv_aktion_kdn_bby_konz,
  v01.pv_aktion_kdp_bby AS pv_aktion_kdp_bby,
  v01.pv_aktion_kdp_bby_konz AS pv_aktion_kdp_bby_konz,
  v01.pv_bby AS pv_bby,
  v01.pv_bby_konz AS pv_bby_konz,
  v01.pv_kdn_bby AS pv_kdn_bby,
  v01.pv_kdn_bby_konz AS pv_kdn_bby_konz,
  v01.pv_kdp_bby AS pv_kdp_bby,
  v01.pv_kdp_bby_konz AS pv_kdp_bby_konz,
  v01.dat AS dat,
  v01.art_id AS art_id,
  v01.mandant_id AS mandant_id,
  v01.gp_id AS gp_id,
  v01.herst_id AS herst_id,
  v01.ean_kasse AS ean_kasse,
  v01.vw_id AS vw_id,
  v01.bezugsweg_id AS bezugsweg_id,
  v01.wrg_id AS wrg_id,
  v01.ek_brutto AS ek_brutto,
  v01.diff_ek_brutto_konz AS diff_ek_brutto_konz,
  v01.ek_gld AS ek_gld,
  v01.diff_ek_gld_konz AS diff_ek_gld_konz,
  v01.ek_netto AS ek_netto,
  v01.diff_ek_netto_konz AS diff_ek_netto_konz,
  v01.ek_netto_bnk AS ek_netto_bnk,
  v01.diff_ek_netto_bnk_konz AS diff_ek_netto_bnk_konz,
  v01.bonusbasis AS bonusbasis,
  v01.bonusbasis_konz AS bonusbasis_konz,
  v01.ek_mep_vor_fwu AS ek_mep_vor_fwu,
  v01.ek_mep_vor_fwu_konz AS ek_mep_vor_fwu_konz,
  v01.ek_kal_basis AS ek_kal_basis,
  v01.diff_ek_kal_basis_konz AS diff_ek_kal_basis_konz,
  v01.pv_bonrabatt_bby AS pv_bonrabatt_bby,
  v01.pv_bonrabatt_bby_konz AS pv_bonrabatt_bby_konz,
  v01.umrechnungskurs_hist AS umrechnungskurs_hist
FROM kfl_production_dbp_data.artbew_vw_sum_2 AS v01
LEFT JOIN kfl_production_dbp_data.art_per_2 AS v02
  ON v01.art_id = v02.art_id
  AND v01.mandant_id = v02.mandant_id
  AND v01.dat BETWEEN DATE_SUB(v02.dat_von, INTERVAL '1' DAY) AND (
    DATE_SUB(v02.dat_bis, INTERVAL '1' DAY)
  )
WHERE
  v01.mandant_id <> 1
  AND (
    v01.mandant_id <> 5 OR v01.art_id <> 206731500
  )
  AND (
    v01.mandant_id <> 2 OR v01.art_id <> 208124500
  )
  AND (
    v01.mandant_id <> 3 OR v01.art_id <> 208113690
  )
  AND (
    v01.mandant_id <> 6 OR v01.art_id <> 208131570
  )
  AND (
    NOT v01.mandant_id IN (4, 7) OR v01.art_id <> 208114740
  )
  AND (
    v01.mandant_id <> 8 OR v01.art_id <> 208131640
  );
