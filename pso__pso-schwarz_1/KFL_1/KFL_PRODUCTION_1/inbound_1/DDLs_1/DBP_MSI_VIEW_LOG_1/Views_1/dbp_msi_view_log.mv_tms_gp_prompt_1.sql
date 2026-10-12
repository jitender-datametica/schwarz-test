CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_TMS_GP_PROMPT_1(
	TMS_GP_ID,
	TMS_GP_NAME_CHG_FG,
	TMS_GP_NAME
) AS
--AP0284464_SPEC0324632, dknop, initial

SELECT 
 t1.tms_gp_id
,CASE WHEN t1.tms_gp_name = '' AND t2.tms_gp_name IS NOT NULL THEN 1 ELSE 0 END AS tms_gp_name_chg_fg 
,CASE WHEN tms_gp_name_chg_fg = 1 THEN t2.tms_gp_name ELSE t1.tms_gp_name  END AS tms_gp_name


FROM dbp_view.v_tms_gp_1 t1_1
--because of error during WANKO Upgrade we have records with typ CD <> 0,1 and empty name
LEFT JOIN (SELECT MANDANT_ID, SYSTEM_ID, tms_gp_id, MAX(tms_gp_name) AS tms_gp_name FROM dbp_view.v_tms_gp_1 WHERE tms_gp_name <> '' GROUP BY MANDANT_ID, SYSTEM_ID, tms_gp_id) t2
ON t1.mandant_id = t2.mandant_id
AND t1.system_id = t2.system_id
AND t1.tms_gp_id = t2.tms_gp_id 
GROUP BY  t1.tms_gp_id, t2.tms_gp_name, t1.tms_gp_name
;