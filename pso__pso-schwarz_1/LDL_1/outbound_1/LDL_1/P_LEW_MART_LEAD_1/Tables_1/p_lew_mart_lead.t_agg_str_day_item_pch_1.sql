/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_agg_str_day_item_pch.
#----------------------------------------------------------------------------
# History:
#  1.0  DD.MM.YYYY    <Unknown>                   Initial, lift and shift from Teradata
#  1.1  18.09.2024    Bachmann, Torsten           Add clustering key
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_str_day_item_pch_1 (
client_id INTEGER NOT NULL,
loc_sid_store INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
pcwo_reason_id INTEGER NOT NULL,
sfotype_id INTEGER NOT NULL,
pch_bnl_switch_fg INTEGER NOT NULL,
dwh_cal_dt DATE NOT NULL,
val_price_change NUMERIC(19,5),
dwh_updated DATETIME NOT NULL
) CLUSTER BY client_id, dwh_cal_dt;