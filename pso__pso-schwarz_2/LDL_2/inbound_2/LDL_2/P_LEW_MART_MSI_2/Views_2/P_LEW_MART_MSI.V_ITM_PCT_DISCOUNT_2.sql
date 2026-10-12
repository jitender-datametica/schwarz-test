CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_PCT_DISCOUNT_2 as
      /* 	
      #DescStart# 	
      #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
      #SubjectAreas#: Artikelstamm 	
      #DescEnd# 	
      */	
	
      SELECT	
      item.client_id,	
      item.pct_discount	
       FROM p_lew_core_ac.v_wawi_itm_item_2 AS item_2	
      GROUP BY item.client_id	
      ,item.pct_discount;