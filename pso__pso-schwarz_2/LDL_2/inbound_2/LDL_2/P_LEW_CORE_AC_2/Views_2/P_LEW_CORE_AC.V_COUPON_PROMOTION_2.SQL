CREATE OR REPLACE VIEW P_LEW_CORE_AC.v_coupon_promotion_2
     (
   client_id
   , coupon_promo_sid
   , src_coupon_promo_nr
   , dwh_load_id
   , dwh_created
   , dwh_updated

)
AS 
SELECT
     
   client_id
   , coupon_promo_sid
   , src_coupon_promo_nr
   , dwh_load_id
   , dwh_created
   , dwh_updated

FROM P_LEW_CORE.t_coupon_promotion_2
;