/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_agg_wh_day_pch.
#----------------------------------------------------------------------------
# History:
#  1.0  19.02.2020    Bachmann, Torsten           Initial
#  1.1  06.10.2020    Bachmann, Torsten           Change UPI to NUPI
#                                                 REP3-7423, Patch-No 2607
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_wh_day_pch (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier for the Lidl country.'),
loc_sid_wh BIGNUMERIC(38,0) OPTIONS(description='surrogate Key for Warehouse.'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse.'),
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
pcwo_reason_id BIGNUMERIC(38,0) OPTIONS(description='Unique ID for PV >100 local reasons.'),
sfotype_id BIGNUMERIC(38,0) OPTIONS(description='document type.'),
currency_iso_cd STRING(3) OPTIONS(description='Currency .'),
pch_bnl_switch_fg BIGNUMERIC(38,0) OPTIONS(description='1=calculated with new method.'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='Logical Date of Row.'),
val_price_change NUMERIC(19,5) OPTIONS(description='Calculated Aggregation.')
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Combined Solution for Report JIRA-LEAD03-6673.');