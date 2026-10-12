CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_DISPLAY_1
(
display_id
,display_bez
,mandant_id
,spr_id
)
AS
   SELECT
   display_id, CASE WHEN display_id=0 THEN 'kein Displayartikel' ELSE display_bez END, mandant_id, spr_id
   FROM dbp_view.v_artkz_display_1
   WHERE mandant_id = 1
   AND spr_id = 22;