create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_FAKTURA_STATUS_SPR_ZU_1(
	SPR_ID,
	MANDANT_ID,
	FAKTURA_STATUS_ID,
	FAKTURA_STATUS_BEZ
) as 
-- 20230717 staeblern Umstellung auf Session Variable
SELECT
   v01.spr_id,
   v01.mandant_id,
   v01.faktura_status_id,
   v01.faktura_status_bez
FROM
   dbp_view.v_faktura_status_spr_zu_1 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_1 v02 
   ON v01.spr_id = v02.spr_id;