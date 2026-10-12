/* #DescStart#	
   #$Revision: 9114 $, $LastChangedBy: aarnold $	
   #SubjectAreas#: Preis und Verkaufsdaten (Kasse + Retail + Wawi)	
   #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_price_day AS SELECT PR.client_id,
 PR.item_id,
 WH.src_wh_id AS wh_id,
 PR.currency_iso_cd,
 PG.position_article_sales_rep,
 PG.article_sales_rep_desc,
 PR.price_retail,
   PR.price_retail * 100 / CASE
   WHEN 100 + REF.pct_vat = 0
   THEN NULL
   ELSE 100 + REF.pct_vat
   END AS price_retail_net,
 C.dat_calendar
FROM ldl_p_lew_mart_msi.v_itm_price AS PR
 INNER JOIN ldl_p_lew_mart_msi.v_cal_calendarday AS C ON C.dat_calendar BETWEEN PR.dat_rec_start AND PR.dat_rec_end AND
   C.dat_calendar < CURRENT_DATE
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_pricegrp AS PG ON PR.client_id = PG.client_id AND PR.pricegroup_id = PG.pricegroup_id
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_wh_act AS OWA ON PR.client_id = OWA.client_id AND OWA.language_id = 7
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON OWA.client_id = WH.client_id AND OWA.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_ref_wawi_vat_values AS REF ON PR.client_id = REF.client_id AND PR.vat_id = REF.vat_id
     AND C.dat_calendar BETWEEN REF.dat_rec_start AND REF.dat_rec_end
WHERE C.dat_calendar BETWEEN PG.dat_valid_from AND PG.dat_valid_until
 AND PG.position_article_sales_rep = 1;