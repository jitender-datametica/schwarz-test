CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_ITEM_VAT_ASWAS_2 as
	
      /*	
      #DescStart#	
      #$Revision: 6244 $, $LastChangedBy: hwieber $	
      #SubjectAreas#: Artikelstamm	
      #DescEnd#	
      */	
	
      SELECT	
         client_id,	
      item_sid AS item_id,	
      dat_calendar AS dat_valid,	
      vat_id,	
      vat_value AS pct_vat	
      FROM p_lew_bil_ac.v_item_vat_2;