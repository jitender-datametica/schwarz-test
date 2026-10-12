/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_QV_AGG_WH_DAY_PRF_WGI
#----------------------------------------------------------------------------
# History:
#  1.0  2021-08-12    Tris Bayliff          Initial
#                                           20210812_2909_Stuckleistung_DDLQV2
#                                           https://jira.schwarz/browse/REP2-10132
#  1.1  2021-09-01    Tris Bayliff          Split revenue columns in to WGI and Store as they differ.
#                                           20210831_2923_Stuckleistung_DDLQV4
#                                           https://jira.schwarz/browse/REP2-10259
#  2.0  2021-09-22    Tris Bayliff          Copy to SnowFlake
#                                           20210831_2923_Stuckleistung_DDLQV4
#                                           https://jira.schwarz/browse/REP2-10259
#  2.1  2022-08-10    Jaroslaw Syrokosz     New Foodaction column for Net sales value
#                                           B-0011300A-AP0141916
#  2.2  2022-11-15    Marcin Malec          AP0143580, Stueckleistung ph 2, Adding sales_pieces_total, sales_pieces_fa_total, sales_pieces_total_adj, sales_pieces_total_pep _cy / _py
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_qv_agg_wh_day_prf_wgi (client_id, country_group_id, gl_region_id, wh_id
, aspect_id, currency_iso_cd, curr_tot_id, dat_formdate, itemgroup_int_id, sales_pieces_cy, sales_pieces_total_cy,
sales_pieces_total_pep_cy, sales_pieces_fa_cy, sales_pieces_fa_total_cy, sales_pieces_adj_cy, sales_pieces_total_adj_cy
, val_rtl_net_wgi_uwg_cy, val_rtl_net_wgi_uwg_fa_cy, val_rtl_net_cy, val_rtl_net_fa_cy, cnt_customer_cy,
work_time_total_hr_cy, sales_pieces_extrapol_cy, sales_pieces_py, sales_pieces_total_py, sales_pieces_total_pep_py,
sales_pieces_fa_py, sales_pieces_fa_total_py, sales_pieces_adj_py, sales_pieces_total_adj_py, val_rtl_net_wgi_uwg_py,
val_rtl_net_wgi_uwg_fa_py, val_rtl_net_py, val_rtl_net_fa_py, cnt_customer_py, work_time_total_hr_py,
sales_pieces_extrapol_py, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_qv_agg_wh_day_prf_wgi;