CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_EJR_LP_ORG_WH_2 AS
      /*	
      #DescStart#	
      #$Revision: 9093 $, $LastChangedBy: aarnold $	
      #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
      #DescEnd#	
      */	
      SELECT	
      ow.client_id
      ,wh.src_wh_id AS wh_id	
      ,ow.country_cd	
      ,ow.dat_opening	
      ,ow.costcenter_cd	
      ,ow.company
      ,ow.order_buying_list_cd
      ,ow.vat_region_nr	
      ,ow.region_cd	
      ,ow.stock_plain	
      ,ow.sponsion
      ,ow.global_location_nr	
      ,ow.wh_desc	
      ,ow.distribute_wh_fg
      ,ow.int_fg	
      ,ow.hq_fg	
      ,ow.prop_wh_fg	
      ,ow.sales_wh_fg
      ,ow.supp_wh_fg	
      ,ow.wawi_data_fg
      ,ow.ovis_data_fg	
     FROM p_lew_core_ac.v_wawi_org_wh_act_2 AS ow	
      INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh	
      ON wh.client_id = ow.client_id	
      AND wh.loc_sid_wh =  ow.wh_loc_sid	
      AND wh.dwh_actual_fg = 1	
	
      WHERE ow.language_id = 7	
;