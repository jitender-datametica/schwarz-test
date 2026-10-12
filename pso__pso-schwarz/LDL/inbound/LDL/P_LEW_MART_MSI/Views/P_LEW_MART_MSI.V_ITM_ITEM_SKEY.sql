CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_ITEM_SKEY as
      /* 	
      #DescStart# 	
      #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
      #SubjectAreas#: Artikelstamm 	
      #DescEnd# 	
      */	
	
      SELECT	
      client_id,	
      item_sid AS item_id,	
      orig_item_nr,	
      case_size,	
      reused_nr	
	
       FROM p_lew_core_ac.v_wawi_itm_item_skey_act	
;