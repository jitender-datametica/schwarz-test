CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_wupcal_ereignis_zu_1 (wup_id, mandant_id, nb_id, dat,
ereignistyp_id, ereignis_id, offen) AS SELECT wup_id,
 mandant_id,
 nb_id,
 dat,
 ereignistyp_id,
 ereignis_id,
 offen
FROM kfl_production_dbp_view.v_wupcal_ereignis_zu_1
WHERE mandant_id = 1;