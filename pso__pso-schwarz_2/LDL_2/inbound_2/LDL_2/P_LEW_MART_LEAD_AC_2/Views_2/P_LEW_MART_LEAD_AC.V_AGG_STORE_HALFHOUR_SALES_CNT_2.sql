CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STORE_HALFHOUR_SALES_CNT_2 COMMENT = 'Daynamische View für Anzahl Bons und Umsatz EJR mit halbstundlicher Granularität'
(
  client_id            COMMENT 'MIS Client ID'
, move_to_store_id     COMMENT 'S-Key der Location_2, hier der Filiale'
, currency_iso_cd      COMMENT 'Lokale Währung (LW)'
, dat_formdate         COMMENT 'Bezugsdatum'
, day_of_week          COMMENT 'Tag_2 der Woche_2'
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
SELECT   client_id
       , move_to_store_id
       , currency_iso_cd
       , dat_formdate
       , day_of_week
       , time_hour_id
       , time_halfhour_id
       , aspect_id
       , anzahlbons
       , val_retail_net_ejr
  FROM P_LEW_MART_LEAD.v_agg_store_halfhour_sales_cnt_2
;