CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_NET_VGES_PWEEK_1 COMMENT = 'View contains the base data for the Reports Nettoleistung 1104004.121 and 1104004.321. Data is provided by store and partial week.'
(
  currency_iso_cd               COMMENT 'Iso-Code Währung'
, client_id                     COMMENT 'Landeskennzeichen'
, currency_desc                 COMMENT 'Bezeichnung der Währung'
, wh_desc                       COMMENT 'Gesellschaftsbezeichnung'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, sales_manager_id              COMMENT 'Bezirksleiter-Nr.'
, wh_id                         COMMENT 'Gesellschaftsnummer'
, wh_id_exp                     COMMENT 'Gesellschafts-Nr.-exp'
, sales_manager_name            COMMENT 'Bezirksleiter-Name'
, account_manager_id            COMMENT 'Vertriebsleiter-Nr.'
, account_manager_name          COMMENT 'Vertriebsleiter-Name'
, move_to_store_id              COMMENT 'Filial-Nr. nach letztem Filialumzug'
, move_store_desc               COMMENT 'Filialname nach letztem Filialumzug'
, orig_store_nr                 COMMENT 'Original Filial-Nr.'
, cy_week                       COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, cy_partial_week               COMMENT 'Geschäftsjahr - Teilwoche Id - 1 = erster Teil / 2 = zweiter Teil der Woche_1'
, cy_partial_week_name          COMMENT 'Geschäftsjahr - Woche_1/Teilwoche - Name der Woche_1 - Format = JJJJ KW 99 plus "/1" für den ersten Teil oder "/2" für den zweiten Teil der Woche_1'
, country_desc                  COMMENT 'Filial-Land_1 Bezeichnung'
, curr_tot_id                   COMMENT 'Fixe Werte für EUR=0, GBP=40 sonst Client_Id'
, val_retail                    COMMENT 'Umsatz (gross value)'
, val_retail_net                COMMENT 'Umsatz (net value)'
, val_retail_cum                COMMENT 'Umsatz aufgelaufen im Geschäftsjahr (gross value)'
, val_retail_net_cum            COMMENT 'Umsatz aufgelaufen im Geschäftsjahr (net value)'
, val_retail_wt_hrs_net_py      COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (gross value), Vorjahr'
, val_rtl_net_wt_hrs_net_py     COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (net value), Vorjahr'
, val_retail_wt_hrs_net         COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (gross value)'
, val_rtl_net_wt_hrs_net        COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (net value)'
, mt_hrs_cum                    COMMENT 'Schulungsstunden aufgelaufen im Geschäftsjahr'
, wt_hrs_net                    COMMENT 'Arbeitsstunden effektiv'
, mt_hrs                        COMMENT 'Schulungsstunden'
, wt_hrs_net_py                 COMMENT 'Arbeitsstunden effektiv, Vorjahr'
, mt_hrs_py_cum                 COMMENT 'Schulungsstunden aufgelaufen im Geschäftsjahr, voriges Geschäftsjahr'
, wt_hrs_net_py_cum             COMMENT 'Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr, Vorjahr'
, wt_hrs_net_cum                COMMENT 'Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr'
, val_retail_wt_hrs_net_py_cum  COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value), Vorjahr'
, val_rtl_net_wt_hrs_net_py_cum COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value), Vorjahr'
, val_retail_wt_hrs_net_cum     COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value)'
, val_rtl_net_wt_hrs_net_cum    COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value)'
, mt_hrs_py                     COMMENT 'Schulungsstunden, Vorjahr'
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
#  1.0     20.07.2022      Michael Morris             sales_pieces_plan & sales_pieces_plan_cum added
#
#----------------------------------------------------------------------------
*/
SELECT   currency_iso_cd
       , client_id
       , currency_desc
       , wh_desc
       , aspect_id
       , sales_manager_id
       , wh_id
       , wh_id_exp
       , sales_manager_name
       , account_manager_id
       , account_manager_name
       , move_to_store_id
       , move_store_desc
       , orig_store_nr
       , cy_week
       , cy_partial_week
       , cy_partial_week_name
       , country_desc
       , curr_tot_id
       , val_retail
       , val_retail_net
       , val_retail_cum
       , val_retail_net_cum
       , val_retail_wt_hrs_net_py
       , val_rtl_net_wt_hrs_net_py
       , val_retail_wt_hrs_net
       , val_rtl_net_wt_hrs_net
       , mt_hrs_cum
       , wt_hrs_net
       , mt_hrs
       , wt_hrs_net_py
       , mt_hrs_py_cum
       , wt_hrs_net_py_cum
       , wt_hrs_net_cum
       , val_retail_wt_hrs_net_py_cum
       , val_rtl_net_wt_hrs_net_py_cum
       , val_retail_wt_hrs_net_cum
       , val_rtl_net_wt_hrs_net_cum
       , mt_hrs_py

  FROM P_LEW_MART_MSI.t_agg_net_int_pweek_1
;