CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_store_day_item_price_change_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
loc_sid_store BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store identifier'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Record date'),
orig_item_nr INTEGER OPTIONS(description='Item_2 number'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item_2 identifier'),
pcwo_reason_id BIGNUMERIC(38,0) OPTIONS(description='pcwo_reason_id'),
pcwo_reason_desc STRING(50) COLLATE 'und:ci' OPTIONS(description='pcwo_reason_desc'),
pch_day_pricegroup_fg BIGNUMERIC OPTIONS(description='PV Tag_2 Preisschienen'),
discount_value_promodesigner BIGNUMERIC(38,11) OPTIONS(description='Promowert vom PromoDesigner, local currency'),
discount_value_lidlplus BIGNUMERIC(38,11) OPTIONS(description='Promowert vom LidlPlus, local currency'),
pch_baseline_fg BIGNUMERIC
OPTIONS(description='Flag fuer Berechnung der Baseline (Tage mit signifikanter PV werden fuer Baselines dann ausgeschlossen)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH load identifier'),
dwh_created TIMESTAMP NOT NULL OPTIONS(description='Timestamp record created'),
dwh_updated TIMESTAMP NOT NULL OPTIONS(description='Timestamp record created'),
PRIMARY KEY (client_id, loc_sid_store, dwh_cal_dt, item_sid) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Price change (PV) days found on store-day-item_2 level, based on logic delivered by business');