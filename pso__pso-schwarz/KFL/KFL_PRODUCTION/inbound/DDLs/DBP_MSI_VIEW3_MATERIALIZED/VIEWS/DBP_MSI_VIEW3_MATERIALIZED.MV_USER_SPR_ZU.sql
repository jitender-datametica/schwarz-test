create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU(
	USER_ID,
	SPR_ID
) as
SELECT DISTINCT  
v01.user_id, v01.spr_id
FROM  dbp_msi_v_view.v_user_spr_zu v01
WHERE  v01.user_id = getvariable('USERID');