CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_ereignistyp_1 (mandant_id, ereignistyp_id) AS SELECT V01.mandant_id
 ,
 V02.ereignistyp_id
FROM kfl_production_dbp_view.v_mandant_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_ereignistyp_1 AS V02 ON TRUE
UNION DISTINCT
SELECT mandant_id,
 - 1
FROM kfl_production_dbp_view.v_mandant_1;