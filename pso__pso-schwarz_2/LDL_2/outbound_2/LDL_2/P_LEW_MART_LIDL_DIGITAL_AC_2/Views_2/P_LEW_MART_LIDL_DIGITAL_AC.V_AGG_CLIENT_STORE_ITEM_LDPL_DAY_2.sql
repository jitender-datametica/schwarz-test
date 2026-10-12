CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_client_store_item_ldpl_day_2 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), geo_area_sid OPTIONS(description='Ceographical identifier for client'),
dwh_cal_dt OPTIONS(description='Data date'), cy_month OPTIONS(description='Calendar_2 Year+Month in form YYYYMM'),
cy_month_prev_1m
OPTIONS(description='The calendar_2 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y
OPTIONS(description='The calendar_2 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
cy_week
OPTIONS(description='The week (containing the day) as a number in the form YYYYWW. YYYY is the year of the week and WW is the number of the week within the calendar_2 year. Week 1 is the first week in the calendar_2 year containing at least 4 days.    [Week Identifier]'),
cy_week_prev_1w
OPTIONS(description='The week 1 week (= 7 days) ago as a number in the form YYYYWW. Eg. 202052.    [Week Identifier]'),
cy_week_prev_1y
OPTIONS(description='The week 1 year (= 364 days = 52 weeks) ago as a number in the form YYYYWW. Eg. 202001.    [Week Identifier]'),
busyear_qtr OPTIONS(description='Business year quarter identifier'), wk_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), wk_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), wk_st_segment_sid
OPTIONS(description='ids of new strategy segments from rfm model'), wk_fr_segment_sid
OPTIONS(description='ids of new frequency segments from rfm model'), wk_re_segment_sid
OPTIONS(description='ids of new recency segments from rfm model'), wk_mo_segment_sid
OPTIONS(description='ids of new monetary segments from rfm model'), mth_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), mth_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), mth_st_segment_sid
OPTIONS(description='ids of new strategy segments from rfm model'), mth_fr_segment_sid
OPTIONS(description='ids of new frequency segments from rfm model'), mth_re_segment_sid
OPTIONS(description='ids of new recency segments from rfm model'), mth_mo_segment_sid
OPTIONS(description='ids of new monetary segments from rfm model'), busyear_qtr_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), busyear_qtr_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), loc_sid OPTIONS(description='Store ID'),
move_to_store_id OPTIONS(description='Store ID after last store relocation'), wh_id OPTIONS(description='Warehouse ID'),
item_sid OPTIONS(description='Item_2 surrogate ID (uniquely across all countries/clients)'), lidlplus_cust_fg
OPTIONS(description='Lidplus customer flag'), lidlplus_discount_fg OPTIONS(description='Lidplus discount flag'),
price_change_fg OPTIONS(description='Price change flag'), pcwo_source_id
OPTIONS(description='Price change or writeoff source, 0 - receiptheader, 1 - discount, 2 - price change, 3 - writeoff'),
pcwo_reason_id
OPTIONS(description='Unique ID of the write-off or Price change reason. Country_2-specific write-off reasons have ID>100.'),
coupon_reason_nr OPTIONS(description='Identifier of the booking reason in SCRM'), ean_barcode
OPTIONS(description='Ean_2 Barcode'), gender_cd OPTIONS(description='The code for the gender'), age_range_cd
OPTIONS(description='The code for the age range.'), household_type_id
OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'),
currency_iso_cd OPTIONS(description='ISO code for the currency of the client.'), curr_tot_id
OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'), customer_sid
OPTIONS(description='Customer identifier'), total_net_val OPTIONS(description='Total net value'), discount_val
OPTIONS(description='Discount value'), writeoff_val OPTIONS(description='Writeoff net value'), sales_piece_weight_qty
OPTIONS(description='Unit_2 Sold - Sales_2 (in units/kg)'), load_id OPTIONS(description='Load identifier'), dwh_created
OPTIONS(description='Row insert time'), dwh_updated OPTIONS(description='Row update time')) AS SELECT aspect_id,
 client_id,
 geo_area_sid,
 dwh_cal_dt,
 cy_month,
 cy_month_prev_1m,
 cy_month_prev_1y,
 cy_week,
 cy_week_prev_1w,
 cy_week_prev_1y,
 busyear_qtr,
 wk_rf_segment_sid,
 wk_m_segment_sid,
 wk_st_segment_sid,
 wk_fr_segment_sid,
 wk_re_segment_sid,
 wk_mo_segment_sid,
 mth_rf_segment_sid,
 mth_m_segment_sid,
 mth_st_segment_sid,
 mth_fr_segment_sid,
 mth_re_segment_sid,
 mth_mo_segment_sid,
 busyear_qtr_rf_segment_sid,
 busyear_qtr_m_segment_sid,
 loc_sid,
 move_to_store_id,
 wh_id,
 item_sid,
 lidlplus_cust_fg,
 lidlplus_discount_fg,
  CASE
  WHEN pcwo_source_id IN (1, 2)
  THEN 'Y'
  ELSE 'N'
  END AS price_change_fg,
 pcwo_source_id,
 pcwo_reason_id,
 coupon_reason_nr,
 ean_barcode,
 gender_cd,
 age_range_cd,
 household_type_id,
 child_age_range_group_id,
 currency_iso_cd,
 curr_tot_id,
 customer_sid,
 total_net_val,
 discount_val,
 writeoff_val,
 sales_piece_weight_qty,
 load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_mart_lidl_digital.v_agg_client_store_item_ldpl_day_2 AS F;