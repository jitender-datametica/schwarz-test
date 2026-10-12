CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_besch_best_2 AS SELECT mandant_id,
 best_beleg_id,
 bestellart_id,
 bestell_typ_id,
 flw_lief_id,
 artikelart_id,
 abweichung_fg,
 system_id,
 einkaufsorganisation_id,
 dat_best_beleg,
 umrechnungskurs,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_besch_best_2;