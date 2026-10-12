DROP TABLE IF EXISTS ldl_p_lew_mart_lead.t_agg_wh_day_pch_1;
CREATE OR REPLACE TABLE ldl_p_lew_mart_lead.t_agg_wh_day_pch_1 (
client_id INTEGER NOT NULL OPTIONS(description='The unique identifier for the Lidl country.'),
loc_sid_wh INTEGER OPTIONS(description='surrogate Key for Warehouse.'),
wh_id INTEGER NOT NULL OPTIONS(description='Warehouse.'),
aspect_id INTEGER NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
pcwo_reason_id INTEGER OPTIONS(description='Unique ID for PV >100 local reasons.'),
sfotype_id INTEGER OPTIONS(description='document type.'),
currency_iso_cd STRING(3) OPTIONS(description='Currency .'),
pch_bnl_switch_fg INTEGER OPTIONS(description='1=calculated with new method.'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Logical Date of Row.'),
val_price_change NUMERIC(29,5) OPTIONS(description='Calculated Aggregation.')
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Combined Solution for Report JIRA-LEAD03-6673.');