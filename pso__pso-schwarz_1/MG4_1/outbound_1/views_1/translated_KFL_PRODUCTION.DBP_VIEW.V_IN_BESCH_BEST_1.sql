CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_besch_best_1 (mandant_id, best_beleg_id, bestellart_id, bestell_typ_id
, in_lief_id, artikelart_id, abweichung_fg, system_id, einkaufsorganisation_id, dat_best_beleg, einkaeufer_grp_id,
buchungskreis_id, wrg_id, umrechnungskurs, memory_fg, dat_von_rb, dat_aenderung, preisanpassung_fg, td_update, td_insert
) AS SELECT mandant_id,
 best_beleg_id,
 bestellart_id,
 bestell_typ_id,
 in_lief_id,
 artikelart_id,
 abweichung_fg,
 system_id,
 einkaufsorganisation_id,
 dat_best_beleg,
 einkaeufer_grp_id,
 buchungskreis_id,
 wrg_id,
 umrechnungskurs,
 memory_fg,
 dat_von_rb,
 dat_aenderung,
 preisanpassung_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_besch_best_1;