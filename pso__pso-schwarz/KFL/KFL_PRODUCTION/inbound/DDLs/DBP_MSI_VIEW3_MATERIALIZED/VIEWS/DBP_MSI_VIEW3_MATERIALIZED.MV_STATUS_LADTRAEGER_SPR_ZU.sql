create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_STATUS_LADTRAEGER_SPR_ZU(
	MANDANT_ID,
	STATUS_LADTRAEGER,
	STATUS_LADTRAEGER_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.status_ladtraeger,
   v01.status_ladtraeger_bez
FROM
   dbp_view.v_status_ladtraeger_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;