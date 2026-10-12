CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_MUTTER_1
(
mutter_art_id
,mutter_art_bez
,mandant_id
,spr_id
)
AS
   SELECT
  0, '0', 1, 22

   FROM dbp_view.v_tag_1
   --WHERE mandant_id = 1
   LIMIT 1;