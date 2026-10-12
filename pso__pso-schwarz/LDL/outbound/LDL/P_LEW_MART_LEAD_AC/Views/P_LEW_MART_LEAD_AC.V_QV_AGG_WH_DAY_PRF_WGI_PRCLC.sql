/*
#----------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.v_qv_agg_wh_day_prf_wgi_prclc
#----------------------------------------------------------------------------
# History:
#  1.0  2021-07-25    Tris Bayliff          Initial
#                                           20210723_2895_Stuckleistung_DDLQV
#                                           https://jira.schwarz/browse/REP2-9956
#  1.1  2021-07-28    Tris Bayliff          Remove descriptive columns
#  1.2  2021-07-31    Tris Bayliff          Add current year / previous year columns
#  1.3  2021-08-12    Tris Bayliff          Add adjusted sales pieces columns
#                                           20210812_2909_Stückleistung_DDLQV2
#                                           https://jira.schwarz/browse/REP2-10132
#  2.0  2021-09-16    Tris Bayliff          Copy to SnowFlake
#                                           20210831_2923_Stuckleistung_DDLQV4
#                                           https://jira.schwarz/browse/REP2-10259
#  2.1  2022-08-10    Jaroslaw Syrokosz     New Foodaction column for Net sales value
#                                           B-0011300A-AP0141916
#  2.2  2022-11-15    Marcin Malec          AP0143580, Stueckleistung ph 2, Adding sales_pieces_total, sales_pieces_fa_total, sales_pieces_total_adj, sales_pieces_extrapol, sales_pieces_total_pep _cy / _py
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_qv_agg_wh_day_prf_wgi_prclc (client_id, country_group_id, gl_region_id,
wh_id, aspect_id, currency_iso_cd, curr_tot_id, dat_formdate, itemgroup_int_id, sales_pieces_cy, sales_pieces_total_cy,
sales_pieces_total_pep_cy, sales_pieces_fa_cy, sales_pieces_fa_total_cy, sales_pieces_adj_cy, sales_pieces_total_adj_cy
, val_rtl_net_wgi_uwg_cy, val_rtl_net_wgi_uwg_fa_cy, cnt_customer_cy, sales_pieces_extrapol_cy, sales_pieces_py,
sales_pieces_total_py, sales_pieces_total_pep_py, sales_pieces_fa_py, sales_pieces_fa_total_py, sales_pieces_adj_py,
sales_pieces_total_adj_py, val_rtl_net_wgi_uwg_py, val_rtl_net_wgi_uwg_fa_py, cnt_customer_py, sales_pieces_extrapol_py
) AS SELECT *
FROM ldl_p_lew_mart_lead.v_qv_agg_wh_day_prf_wgi_prclc;