CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_l_kz AS SELECT mandant_id,
 0 AS kz_id
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id <> 1
UNION ALL
SELECT mandant_id,
 1 AS kz_id
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id <> 1;