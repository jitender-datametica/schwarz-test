CREATE TABLE P_LEW_CORE.t_ref_orig_discount_type_1 
     (
   orig_discount_type_sid INTEGER                        NOT NULL,
   orig_discount_type_descr VARCHAR(100)                   NOT NULL,
   dwh_load_id          INTEGER                        NOT NULL,
   dwh_created          TIMESTAMP(6)                   NOT NULL,
   dwh_updated          TIMESTAMP(6)                   NOT NULL,
  PRIMARY KEY (orig_discount_type_sid));