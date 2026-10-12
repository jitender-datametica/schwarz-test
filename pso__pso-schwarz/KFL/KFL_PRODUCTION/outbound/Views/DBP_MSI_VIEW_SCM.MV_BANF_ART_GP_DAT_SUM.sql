CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_banf_art_gp_dat_sum (mandant_id, art_id, gp_id, wup_id, nb_id
, dat_lief_soll, in_aktion_fg, dat_kalk, vk_brutto, banf_menge_kolli, forecast_menge_kolli, menge_best_kolli,
banf_menge_kg, forecast_menge_kg, menge_best_kg) AS SELECT V01.mandant_id,
 V01.art_id,
 V01.gp_id,
 V05.aktuell_wup_id AS wup_id,
 V01.nb_id,
 V01.dat_lief_soll,
 V01.in_aktion_fg,
 V01.dat_kalk,
 V01.vk_brutto,
 V01.banf_menge_kolli,
 V01.forecast_menge_kolli,
 V01.menge_best_kolli,
 V01.banf_menge_kg,
 V01.forecast_menge_kg,
 V01.menge_best_kg
FROM kfl_production_dbp_view.v_banf_art_gp_dat_sum AS V01
 INNER JOIN kfl_production_dbp_view.v_wup AS V05 ON V01.mandant_id = V05.mandant_id AND V01.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0);