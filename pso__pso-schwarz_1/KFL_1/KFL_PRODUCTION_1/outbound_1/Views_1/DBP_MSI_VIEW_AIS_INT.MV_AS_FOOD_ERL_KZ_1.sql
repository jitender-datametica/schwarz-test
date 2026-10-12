CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_as_food_erl_kz_1 (erl_kz) AS SELECT DISTINCT erl_kz
FROM kfl_production_dbp_view.v_as_food_1 AS V01
WHERE mandant_id <> 1;