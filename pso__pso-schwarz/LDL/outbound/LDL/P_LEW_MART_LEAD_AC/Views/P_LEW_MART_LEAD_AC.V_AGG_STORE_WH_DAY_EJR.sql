/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for V_AGG_STORE_WH_DAY_EJR
#-------------------------------------------------------------------------------
# Description:  This view provides aggregated Umsatz, Umsatz for Food and 
#				NonFood and Bon Totals for current and previous year.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-02-16 Mateusz Rek     	Initial file
#  1.1  2023-02-16 K Lukaszewska   	Comments and edition
#  1.2  2023-04-03 Prasanna Ranjan	Re-Desing to access table
#-------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_store_wh_day_ejr (client_id
OPTIONS(description='Client ID e.g AT=1'), currency_iso_cd OPTIONS(description='Country ISO Code = WAWI Country '),
wh_id OPTIONS(description='Warehouse ID'), move_to_store_id OPTIONS(description='Unique key Region surrogate key'),
cy_week OPTIONS(description='Number of week, YYYYWW'), previous_year_fg
OPTIONS(description='Flag indicating if current year 0 or previous year 1'), last_12_cy_week_fg
OPTIONS(description='Flag indicating if in last 12 weeks'), val_return_net_ejr_asis OPTIONS(description='Returns value'),
val_rtl_net_ejr_asis OPTIONS(description='Umsatz EJR'), val_return_net_ejr_asis_nf
OPTIONS(description='Returns value for NonFood'), val_rtl_net_ejr_asis_nf OPTIONS(description='Umsatz EJR for NonFood'),
val_return_net_ejr_asis_fa OPTIONS(description='Returns value for Food Aktion'), val_rtl_net_ejr_asis_fa
OPTIONS(description='Umsatz EJR for Food Aktion'), dwh_created_ts
OPTIONS(description='Timestamp when record was created'), dwh_updated_ts
OPTIONS(description='Technical field timestamp when record was updated'), load_id
OPTIONS(description='Technical Field ELT / ABInitio Process ID')) AS SELECT client_id,
 currency_iso_cd,
 wh_id,
 move_to_store_id,
 cy_week,
 previous_year_fg,
 last_12_cy_week_fg,
 val_return_net_ejr_asis,
 val_rtl_net_ejr_asis,
 val_return_net_ejr_asis_nf,
 val_rtl_net_ejr_asis_nf,
 val_return_net_ejr_asis_fa,
 val_rtl_net_ejr_asis_fa,
 dwh_created_ts,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_lead.t_agg_store_wh_day_ejr;