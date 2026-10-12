CREATE OR REPLACE VIEW P_LEW_CORE_AC.v_ref_orig_discount_type_1
     (
    orig_discount_type_sid 
   , orig_discount_type_descr 
   , dwh_load_id
   , dwh_created
   , dwh_updated
)
AS 
SELECT
     
    orig_discount_type_sid 
   , orig_discount_type_descr 
   , dwh_load_id
   , dwh_created
   , dwh_updated
FROM P_LEW_CORE.t_ref_orig_discount_type_1
  
 ;