CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_MUTTER
(
mutter_art_id
,mutter_art_bez
,mandant_id
,spr_id
)
AS
   SELECT
  0, '0', 1, 22

   FROM dbp_view.v_tag
   --WHERE mandant_id = 1
   LIMIT 1;