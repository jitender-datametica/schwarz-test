create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_IN_AUFTRAGSART_SPR_ZU_2(
	MANDANT_ID,
	SYSTEM_ID,
	AUFTRAGSART_ID,
	SPR_ID,
	AUFTRAGSART_BEZ
) as
-- 20230717 staeblern Umstellung auf Session Variable
SELECT

   v01.mandant_id,
   v01.system_id,
   v01.auftragsart_id,
   v01.spr_id,
   v01.auftragsart_bez
FROM
   dbp_view.v_in_auftragsart_spr_zu_2 v01
   JOIN DBP_MSI_VIEW3_MATERIALIZED.MV_USER_SPR_ZU_2 v02 
   ON v01.spr_id = v02.spr_id;