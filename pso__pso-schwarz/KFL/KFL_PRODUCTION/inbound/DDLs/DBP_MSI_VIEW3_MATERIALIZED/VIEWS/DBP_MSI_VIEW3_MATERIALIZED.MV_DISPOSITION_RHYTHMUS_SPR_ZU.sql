create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_DISPOSITION_RHYTHMUS_SPR_ZU(
	SYSTEM_ID,
	MANDANT_ID,
	DISPOSITION_RHYTHMUS_ID,
	SPR_ID,
	DISPOSITION_RHYTHMUS_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.system_id,
   v01.mandant_id,
   v01.disposition_rhythmus_id,
   v01.spr_id,
   v01.disposition_rhythmus_bez
FROM
   dbp_view.v_disposition_rhythmus_spr_zu v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU v02
   ON v01.spr_id = v02.spr_id;