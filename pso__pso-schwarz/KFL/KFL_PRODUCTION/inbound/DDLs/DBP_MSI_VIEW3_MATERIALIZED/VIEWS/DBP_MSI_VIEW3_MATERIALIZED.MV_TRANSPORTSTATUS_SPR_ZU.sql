create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TRANSPORTSTATUS_SPR_ZU(
	MANDANT_ID,
	TRANSPORTSTATUS_ID,
	SPR_ID,
	TRANSPORTSTATUS_BEZ
) as 
-- 13.12.2018, aszu1204, AP0027269, neue View
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.mandant_id,
   v01.transportstatus_id,
   v01.spr_id,
   v01.transportstatus_bez
FROM
   dbp_view.v_transportstatus_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02 
   ON v01.spr_id = v02.spr_id;