/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for V_AGG_STORE_HOUR_SALES_CNT_BGES
#-------------------------------------------------------------------------------
# Description:  This view provides aggregated Bon Totals and Umsatz with 
#               the granularity of client/store/day/hour.
#               The aspect_id is fixed to 1 (BGES)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-02-16 K Lukaszewska      Initial Version
#  1.1	2023-03-07 M Rek				 Performance oriented re-design
#  1.2  2023-04-03 Prasanna Ranjan	 Re-Desing to access table
#-------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_store_hour_sales_cnt_bges (client_id
OPTIONS(description='MIS Client ID'), move_to_store_id OPTIONS(description='S-Key Location, here - der Filiale'),
dat_formdate OPTIONS(description='Reference date'), time_hour_id OPTIONS(description='Stunde ID: 01 - 24'),
last_12_cy_week_fg OPTIONS(description='Flag indicating if in last 12 weeks'), cnt_customer_asis
OPTIONS(description='Number of receipts'))
OPTIONS(DESCRIPTION = `DYNAMIC VIEW FOR NUMBER OF RECEIPTS AND UMSATZ EJR WITH HALF-HOURLY GRANULARITY`) AS SELECT
DISTINCT client_id,
 move_to_store_id,
 dat_formdate,
 time_hour_id,
 last_12_cy_week_fg,
 cnt_customer_asis
FROM ldl_p_lew_mart_lead.t_agg_store_hour_sales_cnt_bges;