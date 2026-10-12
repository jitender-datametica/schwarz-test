CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_belegart_1 (system_id, mandant_id, belegart_id, td_update, td_insert)
AS SELECT system_id,
 mandant_id,
 belegart_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_belegart_1;