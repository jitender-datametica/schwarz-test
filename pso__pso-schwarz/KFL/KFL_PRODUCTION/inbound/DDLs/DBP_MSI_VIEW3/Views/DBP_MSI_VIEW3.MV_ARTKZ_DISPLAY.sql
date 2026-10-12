CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ARTKZ_DISPLAY
( display_id,display_bez,mandant_id,spr_id )
AS
   SELECT
  display_id,
   case when display_id=0 then 'kein Displayartikel' else display_bez end,
   mandant_id,
   spr_id
   from dbp_view.v_artkz_display;