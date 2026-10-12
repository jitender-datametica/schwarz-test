CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_client_store_rcpt_item_ldpl_day (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), geo_area_sid OPTIONS(description='Ceographical identifier for client'),
dwh_cal_dt OPTIONS(description='Data date'), cy_month OPTIONS(description='Calendar Year+Month in form YYYYMM'),
cy_month_prev_1m
OPTIONS(description='The calendar month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y
OPTIONS(description='The calendar month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar year. Week 1 is the first week in the calendar year containing at least 4 days.    [Week Identifier]'),
cy_week_prev_1w
OPTIONS(description='The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'),
cy_week_prev_1y
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'),
busyear_qtr OPTIONS(description='Business year quarter identifier'), wk_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), wk_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), wk_st_segment_sid
OPTIONS(description='ids of strategic segments from rfm model'), wk_fr_segment_sid
OPTIONS(description='ids of frequency segments from rfm model'), wk_re_segment_sid
OPTIONS(description='ids of recency segments from rfm model'), wk_mo_segment_sid
OPTIONS(description='ids of new monetary segments from rfm model'), mth_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), mth_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), mth_st_segment_sid
OPTIONS(description='ids of strategic segments from rfm model'), mth_fr_segment_sid
OPTIONS(description='ids of frequency segments from rfm model'), mth_re_segment_sid
OPTIONS(description='ids of recency segments from rfm model'), mth_mo_segment_sid
OPTIONS(description='ids of new monetary segments from rfm model'), busyear_qtr_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), busyear_qtr_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), loc_sid OPTIONS(description='Store ID'),
move_to_store_id OPTIONS(description='Store ID after last store relocation'), wh_id OPTIONS(description='Warehouse ID'),
item_sid OPTIONS(description='Item surrogate ID (uniquely across all countries/clients)'), lidlplus_cust_fg
OPTIONS(description='Lidplus customer flag'), ean_barcode OPTIONS(description='EAN Barcode'), customer_sid
OPTIONS(description='Surrogate Key CUSTOMER'), gender_cd OPTIONS(description='The code for the gender'), age_range_cd
OPTIONS(description='The code for the age range.'), household_type_id
OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
receipt_id OPTIONS(description='Identifier for receipt'), register_id OPTIONS(description='Identifier of a cashier'),
receipt_cnt_uniq OPTIONS(description='Unique Receipt combination used for count distinct in Microstrategy '), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row insert time'), dwh_updated
OPTIONS(description='Row update time')) AS SELECT F.aspect_id,
 F.client_id,
 F.geo_area_sid,
 F.dwh_cal_dt,
 F.cy_month,
 F.cy_month_prev_1m,
 F.cy_month_prev_1y,
 F.cy_week,
 F.cy_week_prev_1w,
 F.cy_week_prev_1y,
 F.busyear_qtr,
 F.wk_rf_segment_sid,
 F.wk_m_segment_sid,
 F.wk_st_segment_sid,
 F.wk_fr_segment_sid,
 F.wk_re_segment_sid,
 F.wk_mo_segment_sid,
 F.mth_rf_segment_sid,
 F.mth_m_segment_sid,
 F.mth_st_segment_sid,
 F.mth_fr_segment_sid,
 F.mth_re_segment_sid,
 F.mth_mo_segment_sid,
 F.busyear_qtr_rf_segment_sid,
 F.busyear_qtr_m_segment_sid,
 F.loc_sid,
 S.move_to_store_id,
 S.wh_id,
 F.item_sid,
 F.lidlplus_cust_fg,
 F.ean_barcode,
 F.customer_sid,
 COLLATE(COALESCE(D.gender_cd, 'N/A'), '') AS gender_cd,
 COLLATE(COALESCE(D.age_range_cd, 'N/A'), '') AS age_range_cd,
 COALESCE(D.household_type_id, 0) AS household_type_id,
 COALESCE(D.child_age_range_group_id, 0) AS child_age_range_group_id,
 F.receipt_id,
 F.register_id,
 F.receipt_cnt_uniq,
 F.load_id,
 F.dwh_created,
 F.dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_client_store_rcpt_item_ldpl_day AS F
 INNER JOIN ldl_p_lew_mart_lidl_digital.v_moved_store_ldpl AS S ON F.client_id = S.client_id AND F.loc_sid = S.store_id
 LEFT JOIN ldl_p_lew_mart_lidl_digital.t_cust_demogr AS D ON F.customer_sid = D.customer_sid
WHERE F.lidlplus_cust_fg = 'Y'
UNION ALL
SELECT F.aspect_id,
 F.client_id,
 F.geo_area_sid,
 F.dwh_cal_dt,
 F.cy_month,
 F.cy_month_prev_1m,
 F.cy_month_prev_1y,
 F.cy_week,
 F.cy_week_prev_1w,
 F.cy_week_prev_1y,
 F.busyear_qtr,
 F.wk_rf_segment_sid,
 F.wk_m_segment_sid,
 F.wk_st_segment_sid,
 F.wk_fr_segment_sid,
 F.wk_re_segment_sid,
 F.wk_mo_segment_sid,
 F.mth_rf_segment_sid,
 F.mth_m_segment_sid,
 F.mth_st_segment_sid,
 F.mth_fr_segment_sid,
 F.mth_re_segment_sid,
 F.mth_mo_segment_sid,
 F.busyear_qtr_rf_segment_sid,
 F.busyear_qtr_m_segment_sid,
 F.loc_sid,
 S.move_to_store_id,
 S.wh_id,
 F.item_sid,
 F.lidlplus_cust_fg,
 F.ean_barcode,
 F.customer_sid,
 COLLATE('N/A', '') AS gender_cd,
 COLLATE('N/A', '') AS age_range_cd,
 0 AS household_type_id,
 0 AS child_age_range_group_id,
 F.receipt_id,
 F.register_id,
 F.receipt_cnt_uniq,
 F.load_id,
 F.dwh_created,
 F.dwh_updated
FROM ldl_p_lew_mart_lidl_digital.t_agg_client_store_rcpt_item_ldpl_day AS F
 INNER JOIN ldl_p_lew_mart_lidl_digital.v_moved_store_ldpl AS S ON F.client_id = S.client_id AND F.loc_sid = S.store_id
WHERE F.lidlplus_cust_fg = 'N';