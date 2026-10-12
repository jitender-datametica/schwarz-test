CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ereignis_1 AS SELECT ereignis_id,
 ereignistyp_id,
 mandant_id,
 default_offen,
 sap_ereignis_id
FROM kfl_production_dbp_data.ereignis_1;