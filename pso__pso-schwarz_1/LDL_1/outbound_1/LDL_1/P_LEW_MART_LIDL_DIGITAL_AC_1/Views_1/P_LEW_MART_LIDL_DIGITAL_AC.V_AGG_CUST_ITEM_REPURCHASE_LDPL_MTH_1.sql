/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- -----------------------------------
# 1.0 2025-02-14 Pawel Wieczorek         AP0235777 Initial versions
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_agg_cust_item_repurchase_ldpl_mth_1 (aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), client_id
OPTIONS(description='Identifier for client'), geo_area_sid OPTIONS(description='Identifier for geographical country_1'),
lidlplus_cust_fg OPTIONS(description='Lidl Plus Customer Flag'), loc_sid OPTIONS(description='Store ID'),
move_to_store_id OPTIONS(description='Filialnummer nach letztem Filialumzug'), wh_id OPTIONS(description='Warehouse ID'),
item_sid OPTIONS(description='Item_1 surrogate ID (uniquely across all countries/clients)'), customer_sid
OPTIONS(description='Customer identifier'), mth_rf_segment_sid
OPTIONS(description='ids of recency-frequency segments from rfm model'), mth_m_segment_sid
OPTIONS(description='ids of monetary segments from rfm model'), gender_cd OPTIONS(description='The code for the gender'),
age_range_cd OPTIONS(description='The code for the age range.'), household_type_id
OPTIONS(description='ID of the household type in which the customer lives.'), child_age_range_group_id
OPTIONS(description='Group of one or more age ranges in which the child is categorized depending on the age.'), cy_month
OPTIONS(description='Calendar_1 Year+Month in form YYYYMM'), cy_month_prev_1m
OPTIONS(description='The calendar_1 month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y
OPTIONS(description='The calendar_1 month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
repurchase_1m_fg OPTIONS(description='Repurchase flag case when Y the there was repurchase within 1 month'),
repurchase_3m_fg OPTIONS(description='Repurchase flag case when Y the there was repurchase within 3 months'),
repurchase_12m_fg OPTIONS(description='Repurchase flag case when Y the there was repurchase within 12 months'), load_id
OPTIONS(description='Load identifier'), dwh_created OPTIONS(description='Row create time'), dwh_updated
OPTIONS(description='Row update time')) OPTIONS(DESCRIPTION = `LIDLPLUS : CUSTOMER REPURCHASE RATE`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_agg_cust_item_repurchase_ldpl_mth_1 AS T;