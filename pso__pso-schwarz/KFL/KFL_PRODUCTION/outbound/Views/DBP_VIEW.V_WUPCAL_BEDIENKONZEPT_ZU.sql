CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wupcal_bedienkonzept_zu AS SELECT wup_id,
 mandant_id,
 nb_id,
 dat,
 bedienkonzept_id,
 anz_kunde
FROM kfl_production_dbp_data.wupcal_bedienkonzept_zu;