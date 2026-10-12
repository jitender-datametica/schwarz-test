CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_CORRELATION_ORIG_ITEM_NR_1 as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Einkäufer_views 	
   #DescEnd# 	
   */	
   SELECT	
   orig_item_nr,	
   orig_item_desc,	
   mis_login,	
   buyer_fg,	
   buyer_short_desc	
   FROM p_lew_core_ac.v_wawi_ref_correlation_orig_item_nr_1 AS rcv	
;