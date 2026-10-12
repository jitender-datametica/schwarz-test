CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STORE_HALFHOUR_SALES_CNT_1 COMMENT = 'Daynamische View für Anzahl Bons und Umsatz EJR mit halbstundlicher Granularität'
(
  client_id            COMMENT 'MIS Client ID'
, move_to_store_id     COMMENT 'S-Key der Location_1, hier der Filiale'
, currency_iso_cd      COMMENT 'Lokale Währung (LW)'
, dat_formdate         COMMENT 'Bezugsdatum'
, day_of_week          COMMENT 'Tag_1 der Woche_1'
, time_hour_id         COMMENT 'Stunde ID: 01 - 24'
, time_halfhour_id     COMMENT 'Halbstunde ID: 0000 - 2330'
, aspect_id            COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft) - Immer 2'
, anzahlbons           COMMENT 'Anzahl der Bons'
, val_retail_net_ejr   COMMENT 'Umsatz EJR'
)
AS
/*
#----------------------------------------------------------------------------
# Description:
# This view provides aggregated Bon Totals and Umsatz with the granularity of client/store/currency/day/hour/halfhour/aspect.
#
# The aspect_id is fixed to 2 (BGES)
#----------------------------------------------------------------------------
# History:
#  1.0     27.04.2022      Michael Morris             Initial Versiuon
#
#----------------------------------------------------------------------------
*/
SELECT DISTINCT rh.client_id
       , osm.move_to_store_id
       , rh.currency_iso_cd
       , cal.dat_calendar                             AS dat_formdate
       , cal.day_of_week
       , CAST(HOUR(rh.time_receipt_ejr) AS INTEGER)   AS time_hour_id
       , CAST(rh.time_halfhour_id AS INTEGER)         AS time_halfhour_id
       , osm.aspect_id                                AS aspect_id
       , COUNT(rh.receipt_for_count_id) OVER (PARTITION BY rh.client_id, rh.store_id, rh.currency_iso_cd, cal.dat_calendar, HOUR(rh.time_receipt_ejr), rh.time_halfhour_id) AS anzahlbons
       , SUM(rh.val_retail_net_ejr)     OVER (PARTITION BY rh.client_id, rh.store_id, rh.currency_iso_cd, cal.dat_calendar, HOUR(rh.time_receipt_ejr), rh.time_halfhour_id) AS val_retail_net_ejr

  FROM P_LEW_MART_MSI_AC.v_cal_calendarday_1         AS cal

 INNER JOIN P_LEW_MART_MSI_AC.v_ejr_receiptheader_1  AS rh
    ON cal.dat_calendar = rh.dat_formdate

 INNER JOIN P_LEW_MART_MSI_AC.v_org_store_merge_1    AS osm
    ON rh.client_id              = osm.client_id
   AND rh.store_id               = osm.store_id
   AND osm.dashboard_relevant_fg = 1
   AND osm.aspect_id             = 2

 WHERE rh.receipt_for_count_id IS NOT NULL
;