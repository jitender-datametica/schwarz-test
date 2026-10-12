create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2(
	USER_ID,
	SPR_ID
) as
SELECT DISTINCT  
v01.user_id, v01.spr_id
FROM  dbp_msi_v_view.v_user_spr_zu_2 v01
WHERE  v01.user_id = getvariable('USERID');