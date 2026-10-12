CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_l_crossdocking (mandant_id, crossdocking_id) AS SELECT mandant_id
 ,
 crossdocking_id
FROM kfl_production_dbp_data.l_crossdocking
WHERE mandant_id = 1;