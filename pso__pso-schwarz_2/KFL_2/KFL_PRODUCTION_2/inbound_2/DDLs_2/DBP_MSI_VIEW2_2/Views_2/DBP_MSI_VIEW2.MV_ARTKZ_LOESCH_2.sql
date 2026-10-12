CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_LOESCH_2
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
   THEN 'ZEK_2 Status_2 aktiv'
   ELSE loesch_bez
   END, mandant_id, spr_id

   FROM dbp_view.v_artkz_loesch_2
   WHERE loesch_id NOT IN ('ZB','ZL','ZR','ZV','01','01','02')
   AND mandant_id = 1;