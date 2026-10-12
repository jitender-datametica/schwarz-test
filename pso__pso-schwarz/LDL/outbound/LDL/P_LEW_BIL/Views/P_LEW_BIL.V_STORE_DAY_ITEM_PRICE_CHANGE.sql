CREATE OR REPLACE VIEW ldl_p_lew_bil.v_store_day_item_price_change (client_id OPTIONS(description='Client identifier'),
loc_sid_store OPTIONS(description='Store identifier'), dwh_cal_dt OPTIONS(description='Record date'), cy_day_seq
OPTIONS(description='Day sequence number'), day_of_week OPTIONS(description='Day of week'), cy_month
OPTIONS(description='Calendar month'), orig_item_nr OPTIONS(description='Item number'), item_sid
OPTIONS(description='Item identifier'), pcwo_reason_id OPTIONS(description='pcwo_reason_id'), pcwo_reason_desc
OPTIONS(description='pcwo_reason_desc'), pch_day_pricegroup_fg OPTIONS(description='PV Tag Preisschienen'),
discount_value_promodesigner OPTIONS(description='Promowert vom PromoDesigner, local currency'), discount_value_lidlplus
OPTIONS(description='Promowert vom LidlPlus, local currency'), pch_baseline_fg
OPTIONS(description='Flag fuer Berechnung der Baseline (Tage mit signifikanter PV werden fuer Baselines dann ausgeschlossen)'))
AS SELECT PCH.client_id,
 PCH.loc_sid_store,
 PCH.dwh_cal_dt,
 CAL.cy_day_seq,
 CAL.day_of_week,
 CAL.cy_month,
 PCH.orig_item_nr,
 PCH.item_sid,
 PCH.pcwo_reason_id,
 PCH.pcwo_reason_desc,
 PCH.pch_day_pricegroup_fg,
 PCH.discount_value_promodesigner,
 PCH.discount_value_lidlplus,
 PCH.pch_baseline_fg
FROM ldl_p_lew_bil.t_store_day_item_price_change AS PCH
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON PCH.dwh_cal_dt = CAL.cal_dt;