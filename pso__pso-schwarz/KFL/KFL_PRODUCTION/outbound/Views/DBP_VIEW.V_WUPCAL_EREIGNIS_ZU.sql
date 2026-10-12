CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wupcal_ereignis_zu AS SELECT dat,
 wup_id,
 nb_id,
 mandant_id,
 ereignistyp_id,
 ereignis_id,
 offen,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wupcal_ereignis_zu;