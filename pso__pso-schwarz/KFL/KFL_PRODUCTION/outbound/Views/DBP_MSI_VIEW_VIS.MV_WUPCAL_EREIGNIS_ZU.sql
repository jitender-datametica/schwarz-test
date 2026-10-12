CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wupcal_ereignis_zu (dat, wup_id, nb_id, mandant_id,
ereignistyp_id, ereignis_id, offen) AS SELECT dat,
 wup_id,
 nb_id,
 mandant_id,
 ereignistyp_id,
 ereignis_id,
 offen
FROM kfl_production_dbp_view.v_wupcal_ereignis_zu AS V01;