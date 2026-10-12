CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_info_gp_2 (mandant_id, gp_id, gp_name, zek_id) AS SELECT mandant_id
 ,
 gp_id,
 gp_name,
 zek_id
FROM kfl_production_dbp_view.v_gp_2 AS V01
WHERE mandant_id = 1
 AND gp_id > 999999;