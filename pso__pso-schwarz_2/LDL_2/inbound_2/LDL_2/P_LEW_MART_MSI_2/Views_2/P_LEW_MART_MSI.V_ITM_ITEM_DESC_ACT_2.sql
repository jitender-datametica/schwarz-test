CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_ITEM_DESC_ACT_2	
/*
#DescStart#	
#$Revision: 6930 $, $LastChangedBy: mueding $	
#SubjectAreas#: Artikelstamm, SAP, WAWI	
#DescEnd#	
*/	
(	
   client_id	
  ,item_id	
  ,item_desc	
  ,orig_item_nr	
  ,language_id	
)	
AS	
   SELECT	
      client_id,	
   item_id,	
   item_desc,	
   orig_item_nr,	
   language_id	
   FROM p_lew_mart_msi.t_itm_item_desc_act_2	
;