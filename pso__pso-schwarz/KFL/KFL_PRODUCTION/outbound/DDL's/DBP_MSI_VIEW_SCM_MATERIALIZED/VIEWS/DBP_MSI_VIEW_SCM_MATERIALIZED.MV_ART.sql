CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_art (art_id, int_art_id, mandant_id, mwst_id,
land_id, region_id, kl_art_id, kl_art_id_lang, dat_von, dat_bis, loesch_id, bio_fg, wg_art_fg, lead_id, leist_id,
discount_id, verpart_id, esb_id, aldi_id, zek_id, gewart_id, eigenmarke_id, mutter_wb_id, display_id, artikeltyp_id,
saison_id, best_menge_einh_id, loeschvorm_fg, mhd_zeitraum, basismenge_einh_id, artikelart_id, faktor_nettoinhalt,
verhandler_id, posten_kz_sap, lager_prozent, ipn_id, zek_vat_id, iwt_id) AS SELECT art_id,
 int_art_id,
 mandant_id,
 mwst_id,
 land_id,
 region_id,
  CASE
  WHEN kl_art_id = 0
  THEN art_id
  ELSE kl_art_id
  END AS kl_art_id,
 TRIM(CAST(kl_art_id AS STRING FORMAT '00000000')) AS kl_art_id_lang,
 dat_von,
 dat_bis,
 loesch_id,
 bio_fg,
 wg_art_fg,
 lead_id,
  CASE
  WHEN leist_id = ' '
  THEN 'keine'
  ELSE leist_id
  END AS leist_id,
 discount_id,
 verpart_id,
 esb_id,
 aldi_id,
 zek_id,
 gewart_id,
 eigenmarke_id,
 mutter_wb_id,
 display_id,
 artikeltyp_id,
 saison_id,
 best_menge_einh_id,
 loeschvorm_fg,
 mhd_zeitraum,
 basismenge_einh_id,
 artikelart_id,
 faktor_nettoinhalt,
 verhandler_id,
 posten_kz_sap,
  CAST(lager_prozent AS NUMERIC) / 100 AS lager_prozent,
 ipn_id,
 zek_vat_id,
 iwt_id
FROM kfl_production_dbp_view.v_art AS V01;