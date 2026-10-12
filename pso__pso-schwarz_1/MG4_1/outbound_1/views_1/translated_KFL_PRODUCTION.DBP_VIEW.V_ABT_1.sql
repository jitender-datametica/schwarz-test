CREATE OR REPLACE VIEW kfl_production_dbp_view.v_abt_1 (abt_id, arthiertyp_id, mandant_id, td_update, td_insert) AS SELECT
 abt_id,
 arthiertyp_id,
 mandant_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.abt_1;