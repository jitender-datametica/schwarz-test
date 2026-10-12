CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_ARTKZ_DISCOUNT_2
       (
         discount_id
         ,discount_bez
         ,mandant_id
         ,spr_id
         ,system_id
       )
       AS
          SELECT
            discount_id,
          discount_bez,
          mandant_id,
          spr_id,
          7 AS system_id
          FROM dbp_view.v_artkz_discount_2
          WHERE mandant_id = 1
 ;