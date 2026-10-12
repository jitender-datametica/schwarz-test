CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_SUPPLIER_ITEM_2 as
   /*	
   #DescStart#	
   #$Revision: 6244 $, $LastChangedBy: hwieber $	
   #SubjectAreas#: Lieferanten	
   #DescEnd#	
   */	
   SELECT	
   client_id,	
   item_sid AS item_id,	
   sup_sid AS supplier_id,	
   Max(dat_formdate) AS dat_formdate	
  FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving_2	
  WHERE receipttype_id = 1	
  GROUP BY	
      client_id,	
      item_sid,	
      sup_sid;