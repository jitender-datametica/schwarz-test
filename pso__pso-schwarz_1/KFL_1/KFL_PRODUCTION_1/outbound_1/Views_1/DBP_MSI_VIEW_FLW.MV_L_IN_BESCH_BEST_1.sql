CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_besch_best_1 (mandant_id, best_beleg_id, in_lief_id,
bestellart_id, bestell_typ_id, artikelart_id, abweichung_fg, einkaufsorganisation_id) AS SELECT mandant_id,
 best_beleg_id,
 flw_lief_id AS in_lief_id,
 bestellart_id,
 bestell_typ_id,
 artikelart_id,
 abweichung_fg,
 einkaufsorganisation_id
FROM kfl_production_dbp_view.v_flw_besch_best_1 AS V01
WHERE einkaufsorganisation_id IN (5000, 5013, 5014);