CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_besch_best (best_beleg_id, bestellart_id, dat_aenderung,
dat_best_beleg, einkaufsorganisation_id, gp_id, loesch_fg, mandant_id, nachbest_fg, kunde_id, wup_id, nb_id,
anz_pos_aktiv, empfaenger_wup_id) AS SELECT best_beleg_id,
 bestellart_id,
 dat_aenderung,
 dat_best_beleg,
 einkaufsorganisation_id,
 gp_id,
 loesch_fg,
 mandant_id,
 nachbest_fg,
 ROUND(CAST(SUBSTR(kunde_id, 7, 4) AS BIGNUMERIC), 0) AS kunde_id,
 wup_id,
 nb_id,
 anz_pos_aktiv,
 empfaenger_wup_id
FROM kfl_production_dbp_view.v_besch_best
WHERE einkaufsorganisation_id <> 5000
 AND loesch_fg = 0;