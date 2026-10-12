CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_gewerk_2 AS SELECT gewerk_id
FROM kfl_production_dbp_view.v_l_gewerk_2
UNION DISTINCT
SELECT - 1 AS dm__operand0
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;