CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_besch_best_1 (mandant_id, best_beleg_id, gp_id, dat_best_beleg,
bestellart_id, best_beleg_status_id, loesch_fg, nachbest_fg, einkaufsorganisation_id, dat_aenderung, kunde_id, wup_id,
nb_id, system_id, kj, submi_id, ref_beleg_id_intern) AS SELECT mandant_id,
 best_beleg_id,
 gp_id,
 dat_best_beleg,
 bestellart_id,
 best_beleg_status_id,
 loesch_fg,
 nachbest_fg,
 einkaufsorganisation_id,
 dat_aenderung,
 kunde_id,
 wup_id,
 nb_id,
 7 AS system_id,
 EXTRACT(YEAR FROM dat_best_beleg) AS kj,
 submi_id,
 ref_beleg_id_intern
FROM kfl_production_dbp_view.v_besch_best_1
WHERE mandant_id = 1
 AND einkaufsorganisation_id <> 5000;