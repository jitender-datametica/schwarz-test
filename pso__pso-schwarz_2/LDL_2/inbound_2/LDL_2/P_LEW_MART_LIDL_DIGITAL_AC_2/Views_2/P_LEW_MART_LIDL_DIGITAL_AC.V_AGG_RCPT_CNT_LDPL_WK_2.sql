CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_AGG_RCPT_CNT_LDPL_WK_2
(
   client_id
 , wh_id
 , move_to_store_id
 , aspect_id
 , cy_week
 , store_tot_rcpt
 , store_lp_rcpt
 , wh_tot_rcpt
 , wh_lp_rcpt
 , client_tot_rcpt
 , client_lp_rcpt
)
AS
SELECT
client_id,
wh_id,
move_to_store_id,
aspect_id,
cy_week,
store_tot_rcpt,
store_lp_rcpt,
wh_tot_rcpt,
wh_lp_rcpt,
client_tot_rcpt,
client_lp_rcpt
FROM p_lew_mart_lidl_digital.v_agg_rcpt_cnt_ldpl_wk_2;





