CREATE OR REPLACE VIEW DBP_MSI_VIEW_QS.MV_SST_QUELLSYSTEME_1
(
teilprojekt_id
, teilprojekt_name
, teilprojekt_thema_id
, teilprojekt_thema_name
, system_id
, system_bez
, kl_system_bez
, kl_system_id
, mandant_id
, system_rolle
, system_gruppe
, prio
, env
, cfg
, scr_name
, job_name
, aktiv_flag
, proc_type
, proc_name
, script
)
AS
SELECT DISTINCT
v05.teilprojekt_id,
v05.teilprojekt_name,
v02.teilprojekt_thema_id,
v02.teilprojekt_thema_name,
v04.system_id,
system_bez,
kl_system_bez,
kl_system_id,
mandant_id,
system_rolle,
system_gruppe,
prio,
env,
cfg,
scr_name,
job_name,
aktiv_flag,
proc_type,
proc_name,
script
FROM dbp_msi_view_qs.mv_be_monitoring_1 v01

LEFT JOIN dbp_v_process.v_load_teilprojekt_thema_1 v02
ON  v02.teilprojekt_thema_id = v01.teilprojekt_thema_id

LEFT JOIN dbp_v_process.v_load_tp_thema_system_zu_1  v03
ON v03.teilprojekt_thema_id = v01.teilprojekt_thema_id

LEFT JOIN dbp_view.v_l_system_1 v04
ON v03.system_id = v04.system_id

LEFT JOIN dbp_v_process.v_load_teilprojekt_1 v05
ON v05.teilprojekt_id = v02.teilprojekt_id

WHERE v01.proc_type IN ('mld','fld','fxp')
AND  v05.teilprojekt_id IS NOT NULL;