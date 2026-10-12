CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_USER_SPR_ZU_1 AS
--2023 staeblern Umstellung auf Session Variable 
SELECT DISTINCT  
v01.user_id, v01.spr_id
FROM  dbp_msi_v_view.v_user_spr_zu_1 v01
WHERE  v01.user_id = getvariable('USERID');