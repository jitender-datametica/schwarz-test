/*
 * History:
 * 
 * 1.0 2022-01-31 Marcin Kikola         #276052 Initial versions
 * 
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital.v_agg_rcpt_hdr_rev_ldpl_wk_2 (currency_iso_cd
OPTIONS(description='ISO code for the currency of the client'), curr_tot_id
OPTIONS(description='Fixe Werte fur EUR=0 GBP=40 sonst Client_Id'), client_id
OPTIONS(description='Identifier for client'), wh_id OPTIONS(description='Warehouse ID'), move_to_store_id
OPTIONS(description='Filialnummer nach letztem Filialumzug'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), cy_week
OPTIONS(description='Week number'), tot_net_val OPTIONS(description='Total net value : Current week'), lp_net_val
OPTIONS(description='LidlPlus net value : Current week'), wh_tot_net_val
OPTIONS(description='Total net value at wh_id level : Current week'), wh_lp_net_val
OPTIONS(description='LidlPlus net value at wh_id level: Current week'), client_tot_net_val
OPTIONS(description='Total net value at client_id level : Current week'), client_lp_net_val
OPTIONS(description='LidlPlus net value at client_id level: Current week'))
OPTIONS(DESCRIPTION = `LIDLPLUS : VIEW WITH AGGREGATIONS AT WH_ID AND CLIENT_ID USED FOR STORE REPORT IN FE`) AS SELECT
 A.currency_iso_cd,
 A.curr_tot_id,
 A.client_id,
 S.wh_id,
 A.move_to_store_id,
 A.aspect_id,
 A.cy_week,
 SUM(A.cw_tot_net_val) AS tot_net_val,
 SUM(CASE
   WHEN A.lidlplus_cust_fg = 'Y'
   THEN A.cw_tot_net_val
   ELSE 0
   END) AS lp_net_val,
 SUM(SUM(A.cw_tot_net_val)) OVER (PARTITION BY CAST(A.client_id AS STRING), S.wh_id, CAST(A.curr_tot_id AS STRING), CAST(A.cy_week AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_tot_net_val,
 SUM(SUM(CASE
    WHEN A.lidlplus_cust_fg = 'Y'
    THEN A.cw_tot_net_val
    ELSE 0
    END)) OVER (PARTITION BY CAST(A.client_id AS STRING), S.wh_id, CAST(A.curr_tot_id AS STRING), CAST(A.cy_week AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS wh_lp_net_val,
 SUM(SUM(A.cw_tot_net_val)) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.curr_tot_id AS STRING), CAST(A.cy_week AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_tot_net_val,
 SUM(SUM(CASE
    WHEN A.lidlplus_cust_fg = 'Y'
    THEN A.cw_tot_net_val
    ELSE 0
    END)) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.curr_tot_id AS STRING), CAST(A.cy_week AS STRING)
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS client_lp_net_val
FROM ldl_p_lew_mart_lidl_digital.t_agg_rcpt_hdr_ldpl_wk_2 AS A
 INNER JOIN ldl_p_lew_mart_lidl_digital.v_org_store_merge_2 AS S ON A.client_id = S.client_id AND A.move_to_store_id = S.move_to_store_id
     AND A.aspect_id = S.aspect_id
WHERE S.move_fg = 0
 AND S.orig_store_nr <> S.wh_id
GROUP BY A.currency_iso_cd,
 A.curr_tot_id,
 A.client_id,
 S.wh_id,
 A.move_to_store_id,
 A.aspect_id,
 A.cy_week;