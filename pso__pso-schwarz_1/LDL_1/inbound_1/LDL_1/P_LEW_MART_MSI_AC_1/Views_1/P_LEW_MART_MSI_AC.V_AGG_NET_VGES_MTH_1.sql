CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AGG_NET_VGES_MTH_1 COMMENT = 'View contains the base data for the Report Nettoleistung 1104004.312. Data is provided by store and calendar_1 month.'
(
  client_id                     COMMENT 'Landeskennzeichen'
, wh_desc                       COMMENT 'Gesellschaftsbezeichnung'
, aspect_id                     COMMENT 'Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'
, account_manager_id            COMMENT 'Vertriebsleiter-Nr.'
, wh_id                         COMMENT 'Gesellschaftsnummer'
, account_manager_name          COMMENT 'Vertriebsleiter-Name'
, sales_manager_id              COMMENT 'Bezirksleiter-Nr.'
, wh_id_exp                     COMMENT 'Gesellschafts-Nr.-exp'
, sales_manager_name            COMMENT 'Bezirksleiter-Name'
, move_to_store_id              COMMENT 'Filial-Nr. nach letztem Filialumzug'
, move_store_desc               COMMENT 'Filialname nach letztem Filialumzug'
, orig_store_nr                 COMMENT 'Original Filial-Nr.'
, currency_iso_cd               COMMENT 'Iso-Code Währung'
, currency_desc                 COMMENT 'Bezeichnung der Währung'
, curr_tot_id                   COMMENT 'Fixe Werte für EUR=0, GBP=40 sonst Client_Id'
, cy_month                      COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, cy_month_name                 COMMENT 'Monatsname des Geschäftsjahres'
, val_retail_cum                COMMENT 'Umsatz aufgelaufen im Geschäftsjahr (gross value)'
, val_retail_net_cum            COMMENT 'Umsatz aufgelaufen im Geschäftsjahr (net value)'
, val_retail                    COMMENT 'Umsatz (gross value)'
, val_retail_net                COMMENT 'Umsatz (net value)'
, wt_hrs_net_py_cum             COMMENT 'Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr, Vorjahr'
, mt_hrs_py_cum                 COMMENT 'Schulungsstunden aufgelaufen im Geschäftsjahr, voriges Geschäftsjahr'
, net_hrs_store_plan            COMMENT 'effektive Arbeitsstunden geplant'
, val_retail_wt_hrs_net         COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (gross value)'
, val_rtl_net_wt_hrs_net        COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (net value)'
, mt_hrs_cum                    COMMENT 'Schulungsstunden aufgelaufen im Geschäftsjahr'
, mt_hrs_py                     COMMENT 'Schulungsstunden, Vorjahr'
, net_hrs_store_plan_cum        COMMENT 'effektive Arbeitsstunden geplant aufgelaufen im Geschäftsjahr'
, val_retail_plan_cum           COMMENT 'Umsatz aufgelaufen im Geschäftsjahr geplant (gross value)'
, val_retail_plan_net_cum       COMMENT 'Umsatz aufgelaufen im Geschäftsjahr geplant (net value)'
, wt_hrs_net                    COMMENT 'Arbeitsstunden effektiv'
, mt_hrs                        COMMENT 'Schulungsstunden'
, val_retail_wt_hrs_net_py_cum  COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value), Vorjahr'
, val_rtl_net_wt_hrs_net_py_cum COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value), Vorjahr'
, wt_hrs_net_py                 COMMENT 'Arbeitsstunden effektiv, Vorjahr'
, val_retail_wt_hrs_net_py      COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (gross value), Vorjahr'
, val_rtl_net_wt_hrs_net_py     COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden (net value), Vorjahr'
, wt_hrs_net_cum                COMMENT 'Arbeitsstunden effektiv aufgelaufen im Geschäftsjahr'
, val_retail_plan               COMMENT 'Umsatz geplant (gross value)'
, val_retail_plan_net           COMMENT 'Umsatz geplant (net value)'
, val_retail_wt_hrs_net_cum     COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (gross value)'
, val_rtl_net_wt_hrs_net_cum    COMMENT 'Umsatz an Tagen mit effektiven Arbeitsstunden aufgelaufen im Geschäftsjahr (net value)'
, sales_pieces_plan             COMMENT 'Abverkaufwert Plan'
, sales_pieces_plan_cum         COMMENT 'Abverkaufwert Plan akkumuliert'
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
SELECT   client_id
       , wh_desc
       , aspect_id
       , account_manager_id
       , wh_id
       , account_manager_name
       , sales_manager_id
       , wh_id_exp
       , sales_manager_name
       , move_to_store_id
       , move_store_desc
       , orig_store_nr
       , currency_iso_cd
       , currency_desc
       , curr_tot_id
       , cy_month
       , cy_month_name
       , val_retail_cum
       , val_retail_net_cum
       , val_retail
       , val_retail_net
       , wt_hrs_net_py_cum
       , mt_hrs_py_cum
       , net_hrs_store_plan
       , val_retail_wt_hrs_net
       , val_rtl_net_wt_hrs_net
       , mt_hrs_cum
       , mt_hrs_py
       , net_hrs_store_plan_cum
       , val_retail_plan_cum
       , val_retail_plan_net_cum
       , wt_hrs_net
       , mt_hrs
       , val_retail_wt_hrs_net_py_cum
       , val_rtl_net_wt_hrs_net_py_cum
       , wt_hrs_net_py
       , val_retail_wt_hrs_net_py
       , val_rtl_net_wt_hrs_net_py
       , wt_hrs_net_cum
       , val_retail_plan
       , val_retail_plan_net
       , val_retail_wt_hrs_net_cum
       , val_rtl_net_wt_hrs_net_cum
       , sales_pieces_plan
       , sales_pieces_plan_cum

  FROM P_LEW_MART_MSI.v_agg_net_vges_mth_1
;