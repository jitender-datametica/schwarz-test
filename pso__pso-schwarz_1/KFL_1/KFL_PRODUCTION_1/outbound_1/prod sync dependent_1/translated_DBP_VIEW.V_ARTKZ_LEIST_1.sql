CREATE OR REPLACE VIEW kfl_production_dbp_view.v_artkz_leist_1 (leist_id, mandant_id, spr_id, leist_bez, td_update,
td_insert) AS SELECT leist_id,
 mandant_id,
 spr_id,
 leist_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.artkz_leist_1;