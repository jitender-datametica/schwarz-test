CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_user_mandant_zu (mandant_id, user_id) AS SELECT
 mandant_id,
 LOWER(user_id) AS user_id
FROM kfl_production_dbp_msi_v_view.v_user_mandant_zu;