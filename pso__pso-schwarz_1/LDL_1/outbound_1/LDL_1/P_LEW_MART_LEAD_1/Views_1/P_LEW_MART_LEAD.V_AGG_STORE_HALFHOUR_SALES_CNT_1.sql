/* #----------------------------------------------------------------------------
# Description:
# This view provides aggregated Bon Totals and Umsatz with the granularity of client/store/currency/day/hour/halfhour/aspect.
#
# The aspect_id is fixed to 2 (BGES)
#----------------------------------------------------------------------------
# History:
#  1.0     27.04.2022      Michael Morris             Initial Versiuon
#
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_store_halfhour_sales_cnt_1 (client_id
OPTIONS(description='MIS Client ID'), move_to_store_id OPTIONS(description='S-Key der Location_1, hier der Filiale'),
currency_iso_cd OPTIONS(description='Lokale Währung (LW)'), dat_formdate OPTIONS(description='Bezugsdatum'), day_of_week
OPTIONS(description='Tag_1 der Woche_1'), time_hour_id OPTIONS(description='Stunde ID: 01 - 24'), time_halfhour_id
OPTIONS(description='Halbstunde ID: 0000 - 2330'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft) - Immer 2'), anzahlbons
OPTIONS(description='Anzahl der Bons'), val_retail_net_ejr OPTIONS(description='Umsatz EJR'))
OPTIONS(DESCRIPTION = `DAYNAMISCHE VIEW FÜR ANZAHL BONS UND UMSATZ EJR MIT HALBSTUNDLICHER GRANULARITÄT`) AS SELECT
DISTINCT RH.client_id,
 OSM.move_to_store_id,
 RH.currency_iso_cd,
 CAL.dat_calendar AS dat_formdate,
 CAL.day_of_week,
 CAST(EXTRACT(HOUR FROM RH.time_receipt_ejr) AS BIGNUMERIC) AS time_hour_id,
 CAST(RH.time_halfhour_id AS BIGNUMERIC) AS time_halfhour_id,
 OSM.aspect_id,
 COUNT(RH.receipt_for_count_id) OVER (PARTITION BY CAST(RH.client_id AS STRING), CAST(RH.store_id AS STRING), RH.currency_iso_cd
    , CAL.dat_calendar, EXTRACT(HOUR FROM RH.time_receipt_ejr), RH.time_halfhour_id RANGE BETWEEN UNBOUNDED PRECEDING
  AND UNBOUNDED FOLLOWING) AS anzahlbons,
 SUM(RH.val_retail_net_ejr) OVER (PARTITION BY CAST(RH.client_id AS STRING), CAST(RH.store_id AS STRING), RH.currency_iso_cd
    , CAL.dat_calendar, EXTRACT(HOUR FROM RH.time_receipt_ejr), RH.time_halfhour_id RANGE BETWEEN UNBOUNDED PRECEDING
  AND UNBOUNDED FOLLOWING) AS val_retail_net_ejr
FROM ldl_p_lew_mart_msi_ac.v_cal_calendarday_1 AS CAL
 INNER JOIN ldl_p_lew_mart_msi_ac.v_ejr_receiptheader_1 AS RH ON CAL.dat_calendar = RH.dat_formdate
 INNER JOIN ldl_p_lew_mart_msi_ac.v_org_store_merge_1 AS OSM ON RH.client_id = OSM.client_id AND RH.store_id = OSM.store_id
      AND OSM.dashboard_relevant_fg = 1 AND OSM.aspect_id = 2
WHERE RH.receipt_for_count_id IS NOT NULL;