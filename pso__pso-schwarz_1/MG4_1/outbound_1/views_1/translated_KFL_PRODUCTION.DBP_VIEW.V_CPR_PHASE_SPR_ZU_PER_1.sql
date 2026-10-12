CREATE OR REPLACE VIEW kfl_production_dbp_view.v_cpr_phase_spr_zu_per_1 (projekt_phase_id, dat_von, spr_id, dat_bis,
cpr_phase_bez, cpr_phase_langtext, td_update, td_insert) AS SELECT projekt_phase_id,
 dat_von,
 spr_id,
 dat_bis,
 cpr_phase_bez,
 cpr_phase_langtext,
 td_update,
 td_insert
FROM kfl_production_dbp_data.cpr_phase_spr_zu_per_1;