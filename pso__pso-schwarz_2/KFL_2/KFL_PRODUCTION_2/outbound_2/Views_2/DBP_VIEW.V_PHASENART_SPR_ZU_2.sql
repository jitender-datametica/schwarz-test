CREATE OR REPLACE VIEW kfl_production_dbp_view.v_phasenart_spr_zu_2 AS SELECT phasenart_id,
 spr_id,
 cpr_phase_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.phasenart_spr_zu_2;