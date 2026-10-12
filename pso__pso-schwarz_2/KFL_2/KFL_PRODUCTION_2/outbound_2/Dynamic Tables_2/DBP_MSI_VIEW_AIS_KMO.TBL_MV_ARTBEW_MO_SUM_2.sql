CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artbew_mo_sum_2
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  kjmo AS kjmo,
  art_id AS art_id,
  mandant_id AS mandant_id,
  gp_id AS gp_id,
  nb_id AS nb_id,
  wup_id AS wup_id,
  bewart_id AS bewart_id,
  bewart_det_id AS bewart_det_id,
  CAST(CASE
    WHEN bewart_id = 1001 AND NOT posten_id IN ('PN', 'PF', 'SP', '1')
    THEN 'SO'
    ELSE 'PN'
  END AS STRING) AS posten_id_per,
  SUBSTR(CASE WHEN NOT posten_id IN ('PN', 'PF', 'SP', '1') THEN 'SO' ELSE 'PN' END, 1, 2) AS posten_kz_per,
  ean_kasse AS ean_kasse,
  posten_id AS posten_id,
  CASE WHEN bewart_id IN (1001, 1010) THEN CAST(menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_af,
  CASE WHEN bewart_id = 1002 THEN CAST(menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_sa,
  diff_einstandspreis_konz AS diff_einstandspreis_konz,
  diff_ek_brutto_konz AS diff_ek_brutto_konz,
  diff_ek_mep_konz AS diff_ek_mep_konz,
  diff_ek_netto_bnk_konz AS diff_ek_netto_bnk_konz,
  diff_ek_netto_konz AS diff_ek_netto_konz,
  diff_ek_nettonetto_konz AS diff_ek_nettonetto_konz,
  diff_umsatz_mwst_betrag_konz AS diff_umsatz_mwst_betrag_konz,
  diff_umsatz_netto_konz AS diff_umsatz_netto_konz,
  einstandspreis AS einstandspreis,
  ek_brutto AS ek_brutto,
  ek_mep AS ek_mep,
  ek_netto AS ek_netto,
  ek_netto_bnk AS ek_netto_bnk,
  ek_nettonetto AS ek_nettonetto,
  menge AS menge,
  umsatz_mwst_betrag AS umsatz_mwst_betrag,
  umsatz_netto AS umsatz_netto,
  diff_ek_gld_konz AS diff_ek_gld_konz,
  ek_gld AS ek_gld,
  CASE
    WHEN bewart_det_id IN (100110, 100130)
    THEN CAST(menge AS BIGNUMERIC)
    ELSE NULL
  END AS vk_menge_af_non_loyalty,
  CASE
    WHEN bewart_det_id IN (100111, 100121, 100131)
    THEN CAST(menge AS BIGNUMERIC)
    ELSE NULL
  END AS vk_menge_af_loyalty,
  CASE WHEN bewart_det_id = 100111 THEN CAST(menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_af_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
  CASE WHEN bewart_det_id = 100110 THEN CAST(menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_af_non_loyalty_exkl_schwarz_media_u_bonrabatt_bby,
  CASE WHEN bewart_det_id = 100111 THEN CAST(menge AS BIGNUMERIC) ELSE 0 END + CASE WHEN bewart_det_id = 100110 THEN CAST(menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_af_exkl_schwarz_media_u_bonrabatt_bby,
  CASE WHEN bewart_det_id = 100121 THEN CAST(menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_af_loyalty_schwarz_media,
  CASE WHEN bewart_det_id = 100210 THEN CAST(menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_sa_non_loyalty,
  CASE WHEN bewart_det_id = 100211 THEN CAST(menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_sa_loyalty,
  CASE WHEN bewart_det_id = 100220 THEN CAST(menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_bby_non_loyalty,
  CASE WHEN bewart_det_id = 100221 THEN CAST(menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_bby_loyalty,
  CASE WHEN bewart_det_id = 100231 THEN CAST(menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_kdn_bby_loyalty,
  CASE WHEN bewart_det_id = 100241 THEN CAST(menge AS BIGNUMERIC) ELSE NULL END AS vk_menge_kdp_bby_loyalty,
  CASE WHEN bewart_det_id = 100130 THEN CAST(menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_bonrabatt_bby_non_loyalty,
  CASE WHEN bewart_det_id = 100131 THEN CAST(menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_bonrabatt_bby_loyalty,
  CASE WHEN bewart_det_id = 100130 THEN CAST(menge AS BIGNUMERIC) ELSE 0 END + CASE WHEN bewart_det_id = 100131 THEN CAST(menge AS BIGNUMERIC) ELSE 0 END AS vk_menge_bonrabatt_bby,
  bonusbasis AS bonusbasis,
  bonusbasis_konz AS bonusbasis_konz,
  ek_mep_vor_fwu AS ek_mep_vor_fwu,
  ek_mep_vor_fwu_konz AS ek_mep_vor_fwu_konz,
  ek_kal_basis AS ek_kal_basis,
  diff_ek_kal_basis_konz AS diff_ek_kal_basis_konz,
  pv_aktion AS pv_aktion,
  pv_aktion_konz AS pv_aktion_konz,
  pv_aktion_bby AS pv_aktion_bby,
  pv_aktion_bby_konz AS pv_aktion_bby_konz,
  pv_aktion_kdn_bby AS pv_aktion_kdn_bby,
  pv_aktion_kdn_bby_konz AS pv_aktion_kdn_bby_konz,
  pv_aktion_kdp_bby AS pv_aktion_kdp_bby,
  pv_aktion_kdp_bby_konz AS pv_aktion_kdp_bby_konz,
  pv_bby AS pv_bby,
  pv_bby_konz AS pv_bby_konz,
  pv_kdn_bby AS pv_kdn_bby,
  pv_kdn_bby_konz AS pv_kdn_bby_konz,
  pv_kdp_bby AS pv_kdp_bby,
  pv_kdp_bby_konz AS pv_kdp_bby_konz,
  pv_bonrabatt_bby AS pv_bonrabatt_bby,
  pv_bonrabatt_bby_konz AS pv_bonrabatt_bby_konz,
  umrechnungskurs_hist AS umrechnungskurs_hist
FROM kfl_production_dbp_data.artbew_mo_sum_2 AS v01
WHERE
  mandant_id <> 1
  AND (
    mandant_id <> 5 OR art_id <> 206731500
  )
  AND (
    mandant_id <> 2 OR art_id <> 208124500
  )
  AND (
    mandant_id <> 3 OR art_id <> 208113690
  )
  AND (
    mandant_id <> 6 OR art_id <> 208131570
  )
  AND (
    NOT mandant_id IN (4, 7) OR art_id <> 208114740
  )
  AND (
    mandant_id <> 8 OR art_id <> 208131640
  );
