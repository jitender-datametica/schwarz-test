CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_LOESCH
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
   THEN 'ZEK Status aktiv'
   ELSE loesch_bez
   END, mandant_id, spr_id

   FROM dbp_view.v_artkz_loesch
   WHERE loesch_id NOT IN ('ZB','ZL','ZR','ZV','01','01','02')
   AND mandant_id = 1;