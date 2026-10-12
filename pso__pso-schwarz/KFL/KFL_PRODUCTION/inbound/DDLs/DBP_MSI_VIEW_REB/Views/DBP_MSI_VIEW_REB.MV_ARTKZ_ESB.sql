CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_ESB
(
esb_id
,esb_bez
,mandant_id
,spr_id
)
AS
   SELECT
   esb_id, (CASE WHEN esb_bez='system generated' THEN 'kein Esbartikel' ELSE esb_bez END) AS esb_bez, mandant_id, spr_id

   FROM dbp_view.v_artkz_esb
   WHERE mandant_id = 1
   and spr_id = 22;