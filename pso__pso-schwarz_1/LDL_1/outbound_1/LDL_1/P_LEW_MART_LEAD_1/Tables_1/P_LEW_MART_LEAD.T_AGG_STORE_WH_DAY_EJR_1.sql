/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_STORE_WH_DAY_EJR_1
#-------------------------------------------------------------------------------
# Description:  This table provides aggregated Umsatz, Umsatz for Food and 
#				NonFood and Bon Totals for current and previous year.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-04-03 Prasanna Ranjan	 Initial Version
#-------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_store_wh_day_ejr_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g AT=1'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='Currency ISO Code = WAWI Country_1 '),
wh_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Warehouse ID'),
move_to_store_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_1 surrogate key'),
cy_week INTEGER DEFAULT 888853 NOT NULL OPTIONS(description='Number of week, YYYYWW'),
previous_year_fg BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Flag indicating if current year 0 or previous year 1'),
last_12_cy_week_fg BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Flag indicating if in last 12 weeks'),
val_return_net_ejr_asis BIGNUMERIC(38,5) OPTIONS(description='Returns value'),
val_rtl_net_ejr_asis BIGNUMERIC(38,5) OPTIONS(description='Umsatz EJR'),
val_return_net_ejr_asis_nf BIGNUMERIC(38,5) OPTIONS(description='Returns value for NonFood'),
val_rtl_net_ejr_asis_nf BIGNUMERIC(38,5) OPTIONS(description='Umsatz EJR for NonFood'),
val_return_net_ejr_asis_fa BIGNUMERIC(38,5) OPTIONS(description='Returns value for Food Aktion_1'),
val_rtl_net_ejr_asis_fa BIGNUMERIC(38,5) OPTIONS(description='Umsatz EJR for Food Aktion_1'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, currency_iso_cd, wh_id, move_to_store_id, cy_week, previous_year_fg) NOT ENFORCED
) CLUSTER BY client_id, cy_week
OPTIONS(description='Basis fact table on Store Week');