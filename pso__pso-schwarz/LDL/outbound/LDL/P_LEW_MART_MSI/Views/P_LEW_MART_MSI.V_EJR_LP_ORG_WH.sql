/* #DescStart#	
      #$Revision: 9093 $, $LastChangedBy: aarnold $	
      #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
      #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_lp_org_wh AS SELECT OW.client_id,
 WH.src_wh_id AS wh_id,
 OW.country_cd,
 OW.dat_opening,
 OW.costcenter_cd,
 OW.company,
 OW.order_buying_list_cd,
 OW.vat_region_nr,
 OW.region_cd,
 OW.stock_plain,
 OW.sponsion,
 OW.global_location_nr,
 OW.wh_desc,
 OW.distribute_wh_fg,
 OW.int_fg,
 OW.hq_fg,
 OW.prop_wh_fg,
 OW.sales_wh_fg,
 OW.supp_wh_fg,
 OW.wawi_data_fg,
 OW.ovis_data_fg
FROM ldl_p_lew_core_ac.v_wawi_org_wh_act AS OW
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON OW.client_id = WH.client_id AND OW.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
WHERE OW.language_id = 7;