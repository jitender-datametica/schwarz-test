CREATE OR REPLACE VIEW kfl_production_dbp_v_process.v_load_teilprojekt_thema AS SELECT teilprojekt_thema_id,
 teilprojekt_id,
 teilprojekt_thema_name,
 dat_beginn,
 dat_ende,
 prio_kz
FROM kfl_production_dbp_process.load_teilprojekt_thema;