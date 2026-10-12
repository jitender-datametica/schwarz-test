CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_gewerk AS SELECT gewerk_id
FROM kfl_production_dbp_view.v_l_gewerk
UNION DISTINCT
SELECT - 1 AS dm__operand0
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;