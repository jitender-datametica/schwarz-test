CREATE TABLE P_LEW_CORE.t_ref_coupon_promotion_type 
     (
   coupon_promo_type_sid INTEGER                        NOT NULL,
   coupon_promo_type_descr VARCHAR(100)                   NOT NULL,
   dwh_load_id          INTEGER                        NOT NULL,
   dwh_created          TIMESTAMP(6)                   NOT NULL,
   dwh_updated          TIMESTAMP(6)                   NOT NULL,
 CONSTRAINT PK_T_REF_COUPON_PROMOTION_TYPE PRIMARY KEY (coupon_promo_type_sid));
