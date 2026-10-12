CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_wawi_inv_wh_ejr_txj_ww AS
-- the value has to be exchanged by using the standard CROSS JOIN to the currency view
 SELECT inv1.client_id,
 WH.src_wh_id,
 inv1.inv_id,
 DATE_ADD(inv2.dat_formdate, INTERVAL 1 DAY) AS inv_start_date,
 inv1.dat_formdate AS inv_end_date,
 SUM(AGG.sales_gross_val) AS val_retail,
 SUM(AGG.sales_net_val) AS val_retail_net
FROM (SELECT client_id,
   wh_loc_sid,
   inv_id,
   dat_formdate,
   RANK() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_loc_sid AS STRING) ORDER BY dat_formdate IS NULL,
      dat_formdate) AS sort
  FROM ldl_p_lew_core_ac.v_wawi_inv_item_wh
  WHERE inv_type = 'F'
  GROUP BY client_id,
   wh_loc_sid,
   inv_id,
   dat_formdate) AS inv1
 LEFT JOIN (SELECT client_id,
   wh_loc_sid,
   inv_id,
   dat_formdate,
   RANK() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_loc_sid AS STRING) ORDER BY dat_formdate IS NULL,
      dat_formdate) AS sort
  FROM ldl_p_lew_core_ac.v_wawi_inv_item_wh
  WHERE inv_type = 'F'
  GROUP BY client_id,
   wh_loc_sid,
   inv_id,
   dat_formdate) AS inv2 ON inv1.client_id = inv2.client_id AND inv1.wh_loc_sid = inv2.wh_loc_sid AND inv1.sort = inv2.sort
     + 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_org_store_skey_act AS S ON inv1.client_id = S.client_id AND inv1.wh_loc_sid = S.wh_loc_sid
   
 INNER JOIN ldl_p_lew_bil_ac.v_agg_pos_txj_wawi_store_day AS AGG ON inv1.client_id = AGG.client_id AND S.st_loc_sid =
    AGG.loc_sid AND AGG.dwh_cal_dt BETWEEN DATE_ADD(inv2.dat_formdate, INTERVAL 1 DAY) AND inv1.dat_formdate
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON inv1.wh_loc_sid = WH.loc_sid_wh AND inv1.client_id = WH.client_id AND
     WH.dwh_actual_fg = 1 AND WH.active_fg = 1 AND WH.bges_active_fg = 1
GROUP BY inv1.client_id,
 WH.src_wh_id,
 inv1.inv_id,
 inv_start_date,
 inv_end_date;