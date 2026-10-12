CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_handling_unit_det_2 (mandant_id, system_id, nb_id,
handling_unit_pos_id, wup_id, handling_unit_id, hu_typ_id, anz_pack_hilfsmittel, de_egalisiert_fg, verp_menge_einh_id,
art_id, lagerort_id, lief_beleg_id, lief_beleg_pos_id, menge_handling_kolli, kj_lief_beleg) AS SELECT mandant_id,
 system_id,
 nb_id,
 handling_unit_pos_id,
 wup_id,
 handling_unit_id,
 hu_typ_id,
 anz_pack_hilfsmittel,
 de_egalisiert_fg,
 verp_menge_einh_id,
 art_id,
 lagerort_id,
 lief_beleg_id,
 lief_beleg_pos_id,
 menge_handling_kolli,
 kj_lief_beleg
FROM kfl_production_dbp_view.v_handling_unit_det_2
WHERE kj_lief_beleg = -1
 OR kj_lief_beleg >= EXTRACT(YEAR FROM CURRENT_TIMESTAMP()) - 2;