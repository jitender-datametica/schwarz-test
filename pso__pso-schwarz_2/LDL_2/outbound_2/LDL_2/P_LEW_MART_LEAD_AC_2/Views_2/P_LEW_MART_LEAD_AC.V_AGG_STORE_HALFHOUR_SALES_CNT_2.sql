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
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_store_halfhour_sales_cnt_2 (client_id
OPTIONS(description='MIS Client ID'), move_to_store_id OPTIONS(description='S-Key der Location_2, hier der Filiale'),
currency_iso_cd OPTIONS(description='Lokale Währung (LW)'), dat_formdate OPTIONS(description='Bezugsdatum'), day_of_week
OPTIONS(description='Tag_2 der Woche_2'), time_hour_id OPTIONS(description='Stunde ID: 01 - 24'), time_halfhour_id
OPTIONS(description='Halbstunde ID: 0000 - 2330'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft) - Immer 2'), anzahlbons
OPTIONS(description='Anzahl der Bons'), val_retail_net_ejr OPTIONS(description='Umsatz EJR'))
OPTIONS(DESCRIPTION = `DAYNAMISCHE VIEW FÜR ANZAHL BONS UND UMSATZ EJR MIT HALBSTUNDLICHER GRANULARITÄT`) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_store_halfhour_sales_cnt_2;