CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ORG_STORE_1
AS
SELECT
b_st.loc_sid_store AS store_id,
b_st.client_id AS client_id,
b_st.country_pol_cd AS country_cd,
b_st.opening_dt AS dat_opening,
b_st.real_opening_dt AS dat_real_opening,
b_st.closing_dt AS dat_closing,
w_st.dat_valid_from AS dat_valid_from,
w_st.licence_nr AS licence_nr,
w_st.object_nr AS object_nr,
w_st.pst_lang_cd AS pst_lang_cd,
w_st.mde_print_cd AS mde_print_cd,
w_st.region_cd AS region_cd,
w_st.closed_fg AS closed_fg,
w_st.mde_lang_cd AS mde_lang_cd,
w_st.ord_unit_valid_store_cd AS ord_unit_valid_store_cd,
b_st.test_store_fg AS test_store_fg,
w_st.transfer_fg AS transfer_fg,
Coalesce(b_st.loc_name2,b_st.loc_name) AS store_desc,
b_st.src_orig_store_nr AS orig_store_nr,
s2wlk.src_wh_id AS wh_id,
w_st.cnt_open_days AS cnt_open_days,
w_st.qty_min_dflt AS qty_min_dflt,
w_st.dat_calc_start_py AS dat_calc_start_py,
w_st.dat_calc_end_py AS dat_calc_end_py,
w_st.dat_calc_start_ppy AS dat_calc_start_ppy,
w_st.dat_opening_ovis AS dat_opening_ovis,
w_st.dat_closing_ovis AS dat_closing_ovis,
w_st.objectstatus_id AS objectstatus_id,
CASE
       -- Abschrift <> 0 vorhanden
       WHEN sfo.client_id IS NOT NULL AND ZeroIfNull(sfo_total_rtl_rl_val_asis) <> 0
           THEN 1
       -- Umsatz <> 0 vorhanden
       WHEN sales.client_id IS NOT NULL AND (ZeroIfNull(sales.val_retail) <> 0 OR ZeroIfNull(sales.val_rtl_ejr) <> 0)
           THEN 1
       ELSE 0
   END AS mis_store_active_fg
FROM p_lew_bil_ac.v_store_1 AS b_st
-- Join zur Filial / Warehouse Zuordnung um das zugehörige Warehouse zu ermitteln
LEFT OUTER JOIN p_lew_bil_ac.v_store_to_warehouse_lastknown_1 AS s2wlk
ON b_st.client_id = s2wlk.client_id
AND b_st.loc_sid_store = s2wlk.loc_sid_store
-- Join zur WaWI Filialen um nicht SAP Felder mit Inhalten aus der WaWi zu befülllen
LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_act_1 AS w_st
ON b_st.client_id = w_st.client_id
AND b_st.loc_sid_store = w_st.st_loc_sid
-- Bestimmung des Kennzeichen MIS_STORE_ACTIVE_FG anhand der Abschriften_1 und Umsätze der letzten 36 Monate
LEFT OUTER JOIN (SELECT
sfo.client_id,
sfo.loc_sid_store,
Sum(sfo.sfo_total_rtl_rl_val_asis) AS sfo_total_rtl_rl_val_asis
FROM p_lew_bil_ac.v_agg_store_day_sfo_1 AS sfo
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS cal
ON sfo.booking_dat = cal.cal_dt
WHERE cal.cy_month_seq BETWEEN -36 AND 0
GROUP BY sfo.client_id
, sfo.loc_sid_store
) AS sfo
ON b_st.client_id = sfo.client_id
AND b_st.loc_sid_store = sfo.loc_sid_store
LEFT OUTER JOIN (SELECT
sales.client_id,
sales.loc_sid_store,
Sum(sales.val_retail) AS val_retail,
Sum(sales.val_rtl_ejr) AS val_rtl_ejr
FROM p_lew_bil_ac.v_agg_sales_store_day_1 AS sales_1
INNER JOIN p_lew_core_ac.v_cal_calendarday_1 AS cal
ON sales.dat_formdate = cal.cal_dt
WHERE cal.cy_month_seq BETWEEN -36 AND 0
GROUP BY sales.client_id
, sales.loc_sid_store
) AS sales_1
ON b_st.client_id = sales.client_id
AND b_st.loc_sid_store = sales.loc_sid_store
WHERE b_st.dwh_actual_fg = 1
AND b_st.test_store_fg = 0
AND b_st.pseudo_store_fg = 0
;



