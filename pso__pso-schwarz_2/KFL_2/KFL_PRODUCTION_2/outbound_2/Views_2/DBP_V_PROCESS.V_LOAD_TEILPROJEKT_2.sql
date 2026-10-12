CREATE OR REPLACE VIEW kfl_production_dbp_v_process.v_load_teilprojekt_2 AS SELECT teilprojekt_id,
 teilprojekt_name,
 dat_beginn,
 dat_ende
FROM kfl_production_dbp_process.load_teilprojekt_2;