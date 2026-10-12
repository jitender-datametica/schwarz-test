CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_LOESCH_1
(
loesch_id
,loesch_bez
,mandant_id
,spr_id
)
AS
   SELECT
  loesch_id, CASE
   WHEN loesch_bez='system generated'
   THEN 'ZEK_1 Status_1 aktiv'
   ELSE loesch_bez
   END, mandant_id, spr_id

   FROM dbp_view.v_artkz_loesch_1
   WHERE loesch_id NOT IN ('ZB','ZL','ZR','ZV','01','01','02')
   AND mandant_id = 1;