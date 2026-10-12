/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.v_agg_store_day_pick_deliv_1
#----------------------------------------------------------------------------
# History:
#  1.0  13.08.2018    Rayanki,Aparna        Initial Version
#                                           20180810_1789_Perf_Chng_Pick_Deliv_Rep5
#                                           https://jira-lidl-public.pixsoftware.de/browse/LEAD05-2312
#                                           https://jira-lidl-public.pixsoftware.de/browse/IDMO-913
#  1.1  23.08.2018    Rayanki,Aparna        modified column comments to German
#                                           20180810_1789_Perf_Chng_Pick_Deliv_Rep5
#                                           https://jira-lidl-public.pixsoftware.de/browse/LEAD05-2312
#                                           https://jira-lidl-public.pixsoftware.de/browse/IDMO-913
#  1.2  19.05.2021    Rekovsky,Marvin       20210518_2839_Add_Kommbereich(REP1-14462): Add new columns picking_area_nr_pp and picking_area_desc_pp
#                                                                                      to display Kommissionierungsbereich
#  1.3  09.10.2025    Rahman,Md Fahmin      RP050: Add new column QTY_ORD_CASE for 'Ausgelieferte Kolli inklusive Zuteilungen' metric
#
#  1.4  12.11.2025    Gao, Pin              RP050: Add new calculation for Foreign_Store_Case and Crossdocking flag based on AP0252326
#
#  1.5  27.01.2026    Gao, Pin              Add currency and currency id to the view based on AP0300690
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_AGG_STORE_DAY_PICK_DELIV_1
(
    CLIENT_ID COMMENT 'Identification of a country_1',
    LOC_SID_STORE_MOVE_TO COMMENT 'SID for the store', 
    WH_LOC_SID COMMENT 'SID for warehouse',
    WH_ID COMMENT 'warehouse ID',
    ASPECT_ID COMMENT '1 - BGES, 2 - VGES',
    CROSSDOCKING_FG COMMENT '1 - warehouse picks cases for the stores belonging to other warehouses, 0 - warehouse picks cases for its own stores',
    DAT_FORMDATE COMMENT 'calendar_1 date',
    CY_MONTH COMMENT 'calendar_1 month',
    CY_WEEK COMMENT 'calendar_1 week',
    PICKING_MAIN_AREA_NR_PP COMMENT 'main picking area number',
    PICKING_MAIN_AREA_DESC_PP COMMENT 'maini picking area description',
    PICKING_AREA_NR_PP COMMENT 'picking area number',
    PICKING_AREA_DESC_PP COMMENT 'picking area description',
    CURR_TOT_ID COMMENT 'currency id',
    CURRENCY_ISO_CD COMMENT 'currency identification code',
    QTY_ORD_CASE COMMENT 'Zuteilung',
    QTY_DEL_CASE COMMENT 'picked cases without Zuteilung',
    FOREIGN_STORE_CASE COMMENT 'Amount of picked cases when crossdocking',
    ORDER_CNT COMMENT 'amount of order position'
)
AS
SELECT
    CLIENT_ID
  , LOC_SID_STORE_MOVE_TO
  , WH_LOC_SID
  , WH_ID
  , ASPECT_ID
  , CROSSDOCKING_FG
  , DAT_FORMDATE
  , CY_MONTH
  , CY_WEEK
  , PICKING_MAIN_AREA_NR_PP
  , PICKING_MAIN_AREA_DESC_PP
  , PICKING_AREA_NR_PP
  , PICKING_AREA_DESC_PP
  , CURR_TOT_ID
  , CURRENCY_ISO_CD
  , QTY_ORD_CASE
  , QTY_DEL_CASE
  , FOREIGN_STORE_CASE
  , ORDER_CNT
FROM
    P_LEW_MART_LEAD.V_AGG_STORE_DAY_PICK_DELIV_1
;