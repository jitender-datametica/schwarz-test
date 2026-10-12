CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_qs.mv_sst_quellsysteme (teilprojekt_id, teilprojekt_name,
teilprojekt_thema_id, teilprojekt_thema_name, system_id, system_bez, kl_system_bez, kl_system_id, mandant_id,
system_rolle, system_gruppe, prio, env, cfg, scr_name, job_name, aktiv_flag, proc_type, proc_name, script) AS SELECT
DISTINCT V05.teilprojekt_id,
 V05.teilprojekt_name,
 V02.teilprojekt_thema_id,
 V02.teilprojekt_thema_name,
 V04.system_id,
 V04.system_bez,
 V04.kl_system_bez,
 V04.kl_system_id,
 V04.mandant_id,
 V04.system_rolle,
 V04.system_gruppe,
 V01.prio,
 V01.env,
 V01.cfg,
 V01.scr_name,
 V01.job_name,
 V01.aktiv_flag,
 V01.proc_type,
 V01.proc_name,
 V01.script
FROM kfl_production_dbp_msi_view_qs.mv_be_monitoring AS V01
 LEFT JOIN kfl_production_dbp_v_process.v_load_teilprojekt_thema AS V02 ON V01.teilprojekt_thema_id = V02.teilprojekt_thema_id
  
 LEFT JOIN kfl_production_dbp_v_process.v_load_tp_thema_system_zu AS V03 ON V01.teilprojekt_thema_id = V03.teilprojekt_thema_id
  
 LEFT JOIN kfl_production_dbp_view.v_l_system AS V04 ON V03.system_id = V04.system_id
 LEFT JOIN kfl_production_dbp_v_process.v_load_teilprojekt AS V05 ON V02.teilprojekt_id = V05.teilprojekt_id
WHERE V01.proc_type IN ('mld', 'fld', 'fxp')
 AND V05.teilprojekt_id IS NOT NULL;