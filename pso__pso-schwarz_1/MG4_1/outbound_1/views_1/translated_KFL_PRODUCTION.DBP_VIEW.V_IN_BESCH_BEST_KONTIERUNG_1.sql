CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_besch_best_kontierung_1 (best_beleg_id, best_beleg_pos_id, mandant_id
, kontierung_pos_id, psp_id, geschaeftsbereich_id, td_update, td_insert) AS SELECT best_beleg_id,
 best_beleg_pos_id,
 mandant_id,
 kontierung_pos_id,
 psp_id,
 geschaeftsbereich_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_besch_best_kontierung_1;