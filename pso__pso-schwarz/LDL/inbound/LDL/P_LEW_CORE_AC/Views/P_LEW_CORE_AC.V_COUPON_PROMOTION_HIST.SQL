CREATE OR REPLACE VIEW P_LEW_CORE_AC.v_coupon_promotion_hist
     (
   client_id
   , coupon_promo_sid
   , coupon_promo_type_sid
   , coupon_sid
   , src_coupon_promo_nr
   , src_coupon_promo_viz_nr
   , coupon_promo_benefit_txt
   , coupon_promo_start_dt
   , coupon_promo_end_dt
   , scratch_redemtion_day_qty
   , deleted_fg
   , dwh_valid_from
   , dwh_valid_to
   , dwh_load_id
   , dwh_created
   , dwh_updated

)
AS 
SELECT
     
   client_id
   , coupon_promo_sid
   , coupon_promo_type_sid
   , coupon_sid
   , src_coupon_promo_nr
   , src_coupon_promo_viz_nr
   , coupon_promo_benefit_txt
   , coupon_promo_start_dt
   , coupon_promo_end_dt
   , scratch_redemtion_day_qty
   , deleted_fg
   , dwh_valid_from
   , dwh_valid_to
   , dwh_load_id
   , dwh_created
   , dwh_updated

FROM P_LEW_CORE.t_coupon_promotion_hist
;