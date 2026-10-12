CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_art_2 (art_id, mandant_id, mwst_id, land_id, region_id
, kl_art_id, dat_von, dat_bis, loesch_id, bio_fg, wg_art_fg, posten_id, lead_id, leist_id, discount_id, verpart_id,
esb_id, aldi_id, zek_id, gewart_id, eigenmarke_id, mutter_wb_id, display_id, best_menge_einh_id, loeschvorm_fg,
mhd_zeitraum, basismenge_einh_id, artikelart_id, faktor_nettoinhalt, lager_prozent, ipn_id) AS SELECT art_id,
 mandant_id,
 mwst_id,
 land_id,
 region_id,
 kl_art_id,
 dat_von,
 dat_bis,
 loesch_id,
 bio_fg,
 wg_art_fg,
  CASE
  WHEN posten_id = 'PN'
  THEN posten_id
  ELSE ' '
  END AS posten_id,
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
 best_menge_einh_id,
 loeschvorm_fg,
 mhd_zeitraum,
 basismenge_einh_id,
 artikelart_id,
 faktor_nettoinhalt,
 lager_prozent,
 COALESCE(ipn_id, 0) AS ipn_id
FROM kfl_production_dbp_view.v_art_2 AS V01;