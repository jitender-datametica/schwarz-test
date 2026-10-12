create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ARTKZ_LOESCH_1(
	LOESCH_ID,
	LOESCH_BEZ,
	MANDANT_ID,
	SPR_ID
) as
   SELECT
   loesch_id, CASE WHEN loesch_bez='system generated' THEN 'ZEK_1 Status_1 aktiv' ELSE loesch_bez END, mandant_id, spr_id

   FROM dbp_view.v_artkz_loesch_1

   WHERE loesch_id NOT IN ('ZB','ZL','ZR','ZV','01','01','02')
   AND mandant_id = 1
   and spr_id = 22;