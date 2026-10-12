CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_PROMOTION_DOMAIN_2 as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Aktionsverkauf 	
   #DescEnd# 	
   */	
   SELECT	
   orig_promotion_domain_nr,	
   orig_promotion_domain_sh_desc,	
   orig_promotion_domain_desc,	
   dat_rec_start,	
   dat_rec_end,	
   timestamp_load	
   FROM p_lew_core_ac.v_wawi_ref_promotion_domain_2	
;