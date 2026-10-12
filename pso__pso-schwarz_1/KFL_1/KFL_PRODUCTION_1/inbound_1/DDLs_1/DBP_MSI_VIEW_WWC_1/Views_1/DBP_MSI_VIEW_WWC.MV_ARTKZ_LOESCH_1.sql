CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_ARTKZ_LOESCH_1(
	LOESCH_ID,
	LOESCH_BEZ,
	MANDANT_ID,
	SPR_ID
) AS
   --08.01.2025, SPEC0285828, prescherad: Neuanlage
   SELECT
   loesch_id,
   CASE
   WHEN loesch_bez='system generated'
   THEN 'ZEK_1 Status_1 aktiv'
   ELSE loesch_bez
   END,
   mandant_id,
   spr_id

   FROM dbp_view.v_artkz_loesch_1
   WHERE loesch_id NOT IN ('ZB','ZL','ZR','ZV','01','01','02');