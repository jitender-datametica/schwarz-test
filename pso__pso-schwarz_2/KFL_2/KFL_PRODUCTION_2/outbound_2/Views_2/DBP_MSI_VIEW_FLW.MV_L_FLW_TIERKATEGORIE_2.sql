CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_tierkategorie_2 AS SELECT mandant_id,
 werk_id,
 tierkategorie_id
FROM kfl_production_dbp_view.v_flw_l_tierkategorie_2 AS V01
WHERE mandant_id IN (1, 2);