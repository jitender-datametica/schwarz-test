CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_ESB_2
(
esb_id,
esb_bez,
mandant_id,
spr_id
)
AS
   SELECT
  esb_id,
   (CASE WHEN esb_bez='system generated'
   THEN 'kein Esbartikel'
   ELSE esb_bez END) AS esb_bez,
   mandant_id,
   spr_id
   FROM dbp_view.v_artkz_esb_2
   WHERE mandant_id = 1;