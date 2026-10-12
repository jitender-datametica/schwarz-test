CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_wupcal_ereignis_zu_2 (dat, wup_id, nb_id, ereignis_id, offen,
ereignistyp_id, mandant_id) AS SELECT dat,
 wup_id,
 nb_id,
 ereignis_id,
 offen,
 ereignistyp_id,
 mandant_id
FROM kfl_production_dbp_view.v_wupcal_ereignis_zu_2 AS V01;