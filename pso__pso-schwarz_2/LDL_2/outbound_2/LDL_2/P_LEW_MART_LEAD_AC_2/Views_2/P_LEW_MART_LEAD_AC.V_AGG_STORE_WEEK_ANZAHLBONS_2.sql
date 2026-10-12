/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for V_AGG_STORE_WEEK_ANZAHLBONS_2
#-------------------------------------------------------------------------------
# Description:  This view provides aggregated Bon Totals and Umsatz with 
#				the granularity of client/store/week.
#               The aspect_id is fixed to 1 (BGES)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0	2023-03-07 M Rek			 Initial version
#  1.1  2023-04-03 Prasanna Ranjan	 Re_2-Desing to access table
#-------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_store_week_anzahlbons_2 (client_id
OPTIONS(description='MIS Client ID'), move_to_store_id OPTIONS(description='S-Key Location_2, here - der Filiale'),
cy_week OPTIONS(description='Number of week, YYYYWW'), previous_year_fg OPTIONS(description='Flag showing Week from PY'),
last_12_cy_week_fg OPTIONS(description='Flag indicating if in last 12 weeks'), cnt_customer_asis
OPTIONS(description='Number of sale receipts'))
OPTIONS(DESCRIPTION = `DYNAMIC VIEW FOR NUMBER OF RECEIPTS WITH WEEKLY GRANULARITY`) AS SELECT client_id,
 move_to_store_id,
 cy_week,
 previous_year_fg,
 last_12_cy_week_fg,
 cnt_customer_asis
FROM ldl_p_lew_mart_lead.t_agg_store_week_anzahlbons_2;