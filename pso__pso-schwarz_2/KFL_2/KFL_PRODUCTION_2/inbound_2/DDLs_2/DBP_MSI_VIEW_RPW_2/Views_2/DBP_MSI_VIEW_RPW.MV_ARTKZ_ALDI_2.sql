CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ARTKZ_ALDI_2
(
  aldi_id
  ,aldi_bez
  ,mandant_id
  ,spr_id
  ,system_id
)
AS
   SELECT
     aldi_id,
   aldi_bez,
   mandant_id,
   spr_id,
   7
   FROM dbp_view.v_artkz_aldi_2
   WHERE mandant_id = 1
 ;