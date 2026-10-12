create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU(
	USER_ID,
	WRG_TYP_ID
) as
-- 20221014 richternic: Ueber Variable statt ueber die AKT_MSI_USER zu joinen. 
--                      In MSI im Pre-Statment wird die Variable user_id gesetzt
-- 20240529 nwag: workaround to use AKT_MSI_USER as a fallback
SELECT
   DISTINCT v01.user_id,
   v01.wrg_typ_id
FROM
   DBP_MSI_VIEW_SCM_MATERIALIZED.USER_PRJ_WRG_TYP_ZU v01
LEFT JOIN
   DBP_MSI_DATA.AKT_MSI_USER v02 ON session_id=current_session()
WHERE
   v01.user_id = CASE WHEN getvariable('USERID') IS NULL THEN v02.user_id ELSE getvariable('USERID') END;