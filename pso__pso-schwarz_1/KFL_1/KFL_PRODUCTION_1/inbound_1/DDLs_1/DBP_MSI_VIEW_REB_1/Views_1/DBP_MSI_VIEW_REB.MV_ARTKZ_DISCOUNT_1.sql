CREATE OR REPLACE VIEW DBP_MSI_VIEW_REB.MV_ARTKZ_DISCOUNT_1
(
discount_id
,discount_bez
,mandant_id
,spr_id
)
AS
   SELECT
   discount_id, discount_bez, mandant_id, spr_id

   FROM dbp_view.v_artkz_discount_1
   WHERE mandant_id = 1
   AND spr_id = 22;