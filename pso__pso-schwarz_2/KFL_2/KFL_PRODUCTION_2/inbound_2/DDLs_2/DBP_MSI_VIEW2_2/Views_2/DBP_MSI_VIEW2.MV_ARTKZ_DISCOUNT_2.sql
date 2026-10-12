CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTKZ_DISCOUNT_2
(
discount_id,
discount_bez,
mandant_id,
spr_id
)
AS
   SELECT
  discount_id,
   discount_bez,
   mandant_id,
   spr_id
   FROM dbp_view.v_artkz_discount_2
   WHERE mandant_id = 1;