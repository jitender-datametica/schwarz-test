CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_oug_id_1 AS SELECT mandant_id,
 oug_id
FROM kfl_production_dbp_view.v_l_oug_id_1
WHERE mandant_id <> 1
UNION ALL
SELECT mandant_id,
 0 AS oug_id
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id <> 1;