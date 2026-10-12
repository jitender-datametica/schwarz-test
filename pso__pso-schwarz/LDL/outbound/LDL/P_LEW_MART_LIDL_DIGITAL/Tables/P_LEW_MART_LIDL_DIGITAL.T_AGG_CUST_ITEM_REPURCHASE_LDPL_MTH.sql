/*
 * History:
 * 
 * 1.0 2025-02-14 Pawel Wieczorek         AP0235777 Initial versions
 *
 */


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lidl_digital.t_agg_cust_item_repurchase_ldpl_mth (
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Identifier for client'),
geo_area_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Identifier for geographical country'),
lidlplus_cust_fg STRING NOT NULL OPTIONS(description='Lidl Plus Customer Flag'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Store ID'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filialnummer nach letztem Filialumzug'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse ID'),
item_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Item surrogate ID (uniquely across all countries/clients)'),
customer_sid INTEGER NOT NULL OPTIONS(description='Customer identifier'),
mth_rf_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='ids of recency-frequency segments from rfm model'),
mth_m_segment_sid BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='ids of monetary segments from rfm model'),
cy_month BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Calendar Year+Month in form YYYYMM'),
cy_month_prev_1m BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='The calendar month 1 month ago as a number in the form YYYYMM. Eg. 201901.    [Month Identifier]'),
cy_month_prev_1y BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='The calendar month 1 year ago as a number in the form YYYYMM. Eg. 201802.    [Month Identifier]'),
repurchase_1m_fg STRING NOT NULL
OPTIONS(description='Repurchase flag case when Y the there was repurchase within 1 month'),
repurchase_3m_fg STRING NOT NULL
OPTIONS(description='Repurchase flag case when Y the there was repurchase within 3 months'),
repurchase_12m_fg STRING NOT NULL
OPTIONS(description='Repurchase flag case when Y the there was repurchase within 12 months'),
load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Row create time'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Row update time'),
PRIMARY KEY (client_id, geo_area_sid, customer_sid, cy_month, item_sid, loc_sid) NOT ENFORCED
) OPTIONS(description='Lidlplus : Customer repurchase rate');