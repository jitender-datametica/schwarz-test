CREATE OR REPLACE VIEW P_LEW_CORE_AC.v_ref_coupon_promotion_type_2
     (
   coupon_promo_type_sid
   , coupon_promo_type_descr
   , dwh_load_id
   , dwh_created
   , dwh_updated

)
AS 
SELECT
     
   coupon_promo_type_sid
   , coupon_promo_type_descr
   , dwh_load_id
   , dwh_created
   , dwh_updated


FROM P_LEW_CORE.t_ref_coupon_promotion_type_2
;
