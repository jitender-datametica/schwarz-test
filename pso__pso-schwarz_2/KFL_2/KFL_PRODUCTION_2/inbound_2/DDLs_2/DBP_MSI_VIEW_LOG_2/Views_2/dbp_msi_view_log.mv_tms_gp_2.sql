CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TMS_GP_2(
MANDANT_ID,
SYSTEM_ID,
TMS_GP_ID,
TMS_GP_TYP_CD,
TMS_GP_LFD_NR,
tms_gp_name_chg_fg,
TMS_GP_NAME,
TMS_GP_ALTNV_NAME,
TMS_GP_STRASSE,
TMS_GP_ORT_NAME,
TMS_GP_PLZ,
TMS_LAND_CD,
SPERR_FG,
SAMMELBELEG_ID,
TMS_STANDORTTYP_ID
) AS
--AP0230823,SPEC0266004, dknop, initial
--nwag2310, inherit TMS GP_2 NAME from "real" record
SELECT 
t1.mandant_id
,t1.system_id
,t1.tms_gp_id
,t1.tms_gp_typ_cd
,t1.tms_gp_lfd_nr
,CASE WHEN t1.tms_gp_name = '' AND t2.tms_gp_name IS NOT NULL THEN 1 ELSE 0 END AS tms_gp_name_chg_fg 
,CASE WHEN tms_gp_name_chg_fg = 1 THEN t2.tms_gp_name ELSE t1.tms_gp_name  END AS tms_gp_name
,t1.tms_gp_altnv_name
,t1.tms_gp_strasse
,t1.tms_gp_ort_name
,t1.tms_gp_plz
,t1.tms_land_cd
,t1.sperr_fg
,t1.sammelbeleg_id
,t1.tms_standorttyp_id

FROM dbp_view.v_tms_gp_2 t1_2
--because of error during WANKO Upgrade we have records with typ CD <> 0,1 and empty name
LEFT JOIN (SELECT MANDANT_ID, SYSTEM_ID, tms_gp_id, MAX(tms_gp_name) AS tms_gp_name FROM dbp_view.v_tms_gp_2 WHERE tms_gp_name <> '' GROUP BY MANDANT_ID, SYSTEM_ID, tms_gp_id) t2
ON t1.mandant_id = t2.mandant_id
AND t1.system_id = t2.system_id
AND t1.tms_gp_id = t2.tms_gp_id 
;