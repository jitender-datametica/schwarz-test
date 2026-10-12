/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_QV_AGG_WH_DAY_PRF_PRCLC
#----------------------------------------------------------------------------
# History:
#  1.0  2021-08-12    Tris Bayliff          Initial
#                                           20210812_2909_Stuckleistung_DDLQV2
#                                           https://jira.schwarz/browse/REP2-10132
#  1.1  2021-08-12    Tris Bayliff          Change count customer aggregation
#                                           20210820_2917_Stuckleistung_DDLQV3
#                                           https://jira.schwarz/browse/REP2-10170
#  1.2  2021-09-01    Tris Bayliff          Split revenue columns in to WGI and Store as they differ.
#                                           20210831_2923_Stuckleistung_DDLQV4
#                                           https://jira.schwarz/browse/REP2-10259
#  2.0  2021-09-17    Tris Bayliff          Copy to SnowFlake
#                                           20210827_2920_QV_Cal_Fixes
#                                           https://jira.schwarz/browse/REP2-10238
#  2.1  2022-06-01    Jaroslaw Syrokosz     Add SALES_PIECES_EXTRAPOL, B-0011292A-AP0134217
#  2.2  2022-08-10    Jaroslaw Syrokosz     New Foodaction column for Net sales value
#                                           B-0011300A-AP0141916
#  2.3  2022-11-15    Marcin Malec          AP0143580, Stueckleistung ph 2, Adding sales_pieces_total, sales_pieces_fa_total, sales_pieces_total_adj, sales_pieces_total_pep _cy / _py
#  2.4  2023-02-15    Marcin Malec          AP0162769, Stueckleistung ph 2, adjust sales_pieces_total for WGI level
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_QV_AGG_WH_DAY_PRF_PRCLC
(
  client_id
, country_group_id
, gl_region_id
, wh_id
, aspect_id
, currency_iso_cd
, curr_tot_id
, dat_formdate
, sales_pieces_cy
, sales_pieces_total_cy
, sales_pieces_total_pep_cy
, sales_pieces_fa_cy
, sales_pieces_fa_total_cy
, sales_pieces_adj_cy
, sales_pieces_total_adj_cy
, val_rtl_net_cy
, val_rtl_net_fa_cy
, cnt_customer_cy
, work_time_total_hr_cy
, sales_pieces_extrapol_cy
, sales_pieces_py
, sales_pieces_total_py
, sales_pieces_total_pep_py
, sales_pieces_fa_py
, sales_pieces_fa_total_py
, sales_pieces_adj_py
, sales_pieces_total_adj_py
, val_rtl_net_py
, val_rtl_net_fa_py
, cnt_customer_py
, work_time_total_hr_py
, sales_pieces_extrapol_py
)
AS
SELECT
  client_id
, country_group_id
, gl_region_id
, wh_id
, aspect_id
, currency_iso_cd
, curr_tot_id
, dat_formdate
, SUM(sales_pieces_cy)           AS sales_pieces_cy
, SUM(sales_pieces_total_cy)     AS sales_pieces_total_cy
, MAX(sales_pieces_total_pep_cy) AS sales_pieces_total_pep_cy
, SUM(sales_pieces_fa_cy)        AS sales_pieces_fa_cy
, SUM(sales_pieces_fa_total_cy)  AS sales_pieces_fa_total_cy
, SUM(sales_pieces_adj_cy)       AS sales_pieces_adj_cy
, SUM(sales_pieces_total_adj_cy) AS sales_pieces_total_adj_cy
, MAX(val_rtl_net_cy)            AS val_rtl_net_cy
, MAX(val_rtl_net_fa_cy)         AS val_rtl_net_fa_cy
, MAX(cnt_customer_cy)           AS cnt_customer_cy
, MAX(work_time_total_hr_cy)     AS work_time_total_hr_cy
, MAX(sales_pieces_extrapol_cy)  AS sales_pieces_extrapol_cy
, SUM(sales_pieces_py)           AS sales_pieces_py
, SUM(sales_pieces_total_py)     AS sales_pieces_total_py
, MAX(sales_pieces_total_pep_py) AS sales_pieces_total_pep_py
, SUM(sales_pieces_fa_py)        AS sales_pieces_fa_py
, SUM(sales_pieces_fa_total_py)  AS sales_pieces_fa_total_py
, SUM(sales_pieces_adj_py)       AS sales_pieces_adj_py
, SUM(sales_pieces_total_adj_py) AS sales_pieces_total_adj_py
, MAX(val_rtl_net_py)            AS val_rtl_net_py
, MAX(val_rtl_net_fa_py)         AS val_rtl_net_fa_py
, MAX(cnt_customer_py)           AS cnt_customer_py
, MAX(work_time_total_hr_py)     AS work_time_total_hr_py
, MAX(sales_pieces_extrapol_py)  AS sales_pieces_extrapol_py
FROM P_LEW_MART_LEAD.V_QV_AGG_WH_DAY_PRF_WGI
GROUP BY
  client_id
, country_group_id
, gl_region_id
, wh_id
, aspect_id
, currency_iso_cd
, curr_tot_id
, dat_formdate
;
