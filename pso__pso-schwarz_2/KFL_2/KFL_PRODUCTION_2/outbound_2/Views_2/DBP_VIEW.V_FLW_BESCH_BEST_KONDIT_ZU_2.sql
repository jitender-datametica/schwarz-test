CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_besch_best_kondit_zu_2 AS SELECT mandant_id,
 best_beleg_id,
 best_beleg_pos_id,
 beleg_kondition_id,
 beleg_konditionsart_id,
 system_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_besch_best_kondit_zu_2;