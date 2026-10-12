/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.v_agg_store_day_pick_deliv
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


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_store_day_pick_deliv (client_id
OPTIONS(description='Identification of a country'), loc_sid_store_move_to OPTIONS(description='SID for the store'),
wh_loc_sid OPTIONS(description='SID for warehouse'), wh_id OPTIONS(description='warehouse ID'), aspect_id
OPTIONS(description='1 - BGES, 2 - VGES'), crossdocking_fg
OPTIONS(description='1 - warehouse picks cases for the stores belonging to other warehouses, 0 - warehouse picks cases for its own stores'),
dat_formdate OPTIONS(description='calendar date'), cy_month OPTIONS(description='calendar month'), cy_week
OPTIONS(description='calendar week'), picking_main_area_nr_pp OPTIONS(description='main picking area number'),
picking_main_area_desc_pp OPTIONS(description='maini picking area description'), picking_area_nr_pp
OPTIONS(description='picking area number'), picking_area_desc_pp OPTIONS(description='picking area description'),
curr_tot_id OPTIONS(description='currency id'), currency_iso_cd OPTIONS(description='currency identification code'),
qty_ord_case OPTIONS(description='Zuteilung'), qty_del_case OPTIONS(description='picked cases without Zuteilung'),
foreign_store_case OPTIONS(description='Amount of picked cases when crossdocking'), order_cnt
OPTIONS(description='amount of order position')) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_store_day_pick_deliv;