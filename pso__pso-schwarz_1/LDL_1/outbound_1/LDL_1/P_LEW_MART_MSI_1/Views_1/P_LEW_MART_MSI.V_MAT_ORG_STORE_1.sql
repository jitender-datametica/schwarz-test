CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_org_store_1 AS -- Abschrift <> 0 vorhanden

-- CROSS JOIN zur Filial / Warehouse Zuordnung um das zugehörige Warehouse zu ermitteln
 SELECT B_ST.loc_sid_store AS
 store_id,
 B_ST.client_id,
 B_ST.country_pol_cd AS country_cd,
 B_ST.opening_dt AS dat_opening,
 B_ST.real_opening_dt AS dat_real_opening,
 B_ST.closing_dt AS dat_closing,
 W_ST.dat_valid_from,
 W_ST.licence_nr,
 W_ST.object_nr,
 W_ST.pst_lang_cd,
 W_ST.mde_print_cd,
 W_ST.region_cd,
 W_ST.closed_fg,
 W_ST.mde_lang_cd,
 W_ST.ord_unit_valid_store_cd,
 B_ST.test_store_fg,
 W_ST.transfer_fg,
 COALESCE(B_ST.loc_name2, B_ST.loc_name) AS store_desc,
 B_ST.src_orig_store_nr AS orig_store_nr,
 S2WLK.src_wh_id AS wh_id,
 W_ST.cnt_open_days,
 W_ST.qty_min_dflt,
 W_ST.dat_calc_start_py,
 W_ST.dat_calc_end_py,
 W_ST.dat_calc_start_ppy,
 W_ST.dat_opening_ovis,
 W_ST.dat_closing_ovis,
 W_ST.objectstatus_id,
  CASE
  WHEN sfo.client_id IS NOT NULL AND IFNULL(sfo.sfo_total_rtl_rl_val_asis, 0) <> 0
  THEN 1 -- Umsatz <> 0 vorhanden

  WHEN sales.client_id IS NOT NULL AND (IFNULL(sales.val_retail, 0) <> 0 OR IFNULL(sales.val_rtl_ejr, 0) <> 0)
  THEN 1
  ELSE 0
  END AS mis_store_active_fg
FROM ldl_p_lew_bil_ac.v_store_1 AS B_ST
 LEFT JOIN ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS S2WLK ON B_ST.client_id = S2WLK.client_id AND B_ST.loc_sid_store
    = S2WLK.loc_sid_store -- CROSS JOIN zur WaWI Filialen um nicht SAP Felder mit Inhalten aus der WaWi zu befülllen

 LEFT JOIN ldl_p_lew_core_ac.v_wawi_org_store_act_1 AS W_ST ON B_ST.client_id = W_ST.client_id AND B_ST.loc_sid_store =
   W_ST.st_loc_sid
   -- Bestimmung des Kennzeichen MIS_STORE_ACTIVE_FG anhand der Abschriften_1 und Umsätze der letzten 36 Monate

 LEFT JOIN (SELECT SFO.client_id,
   SFO.loc_sid_store,
   SUM(SFO.sfo_total_rtl_rl_val_asis) AS sfo_total_rtl_rl_val_asis
  FROM ldl_p_lew_bil_ac.v_agg_store_day_sfo_1 AS SFO
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL ON SFO.booking_dat = CAL.cal_dt
  WHERE CAL.cy_month_seq BETWEEN - 36 AND 0
  GROUP BY SFO.client_id,
   SFO.loc_sid_store) AS sfo ON B_ST.client_id = sfo.client_id AND B_ST.loc_sid_store = sfo.loc_sid_store
 LEFT JOIN (SELECT SALES.client_id,
   SALES.loc_sid_store,
   SUM(SALES.val_retail) AS val_retail,
   SUM(SALES.val_rtl_ejr) AS val_rtl_ejr
  FROM ldl_p_lew_bil_ac.v_agg_sales_store_day_1 AS SALES_1
   INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday_1 AS CAL0 ON SALES.dat_formdate = CAL0.cal_dt
  WHERE CAL0.cy_month_seq BETWEEN - 36 AND 0
  GROUP BY SALES.client_id,
   SALES.loc_sid_store) AS sales_1 ON B_ST.client_id = sales.client_id AND B_ST.loc_sid_store = sales.loc_sid_store
WHERE B_ST.dwh_actual_fg = 1
 AND B_ST.test_store_fg = 0
 AND B_ST.pseudo_store_fg = 0;