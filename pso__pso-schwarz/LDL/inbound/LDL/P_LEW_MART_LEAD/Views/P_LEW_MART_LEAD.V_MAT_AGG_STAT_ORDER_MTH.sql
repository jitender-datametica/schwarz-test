CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MAT_AGG_STAT_ORDER_MTH
(
 client_id
,cy_month
,py_month
,currency_iso_cd
,curr_tot_id

,order_cnt_stationary_mth         -- Kunden
,order_lin_cnt_stationary_mth        --Abverkauf_Umsatz
,turnover_net_val_stationary_mth    --Umsatz_EJR   
,plan_turnover_net_val_stationary_mth        --Umsatz_Plan     

,order_cnt_stationary_pym         -- Kunden
,order_lin_cnt_stationary_pym        --Abverkauf_Umsatz
,turnover_net_val_stationary_pym    --Umsatz_EJR              
)
AS
   SELECT
   work1.client_id,
   work1.cy_month,
   work2.cy_month AS py_month,
   work1.currency_iso_cd,
   work1.curr_tot_id,
   work1.order_cnt_stationary   AS order_cnt_stationary_mth      -- Kunden
   ,
   work1.order_lin_cnt_stationary    AS order_lin_cnt_stationary_mth    --Abverkauf_Umsatz
   ,
   work1.turnover_net_val_stationary    AS turnover_net_val_stationary_mth --Umsatz_EJR   
   ,
   work1.plan_turnover_net_val_stationary AS plan_turnover_net_val_stationary_mth    --Umsatz_Plan
   ,
   work2.order_cnt_stationary AS order_cnt_stationary_pym        -- Kunden
   ,
   work2.order_lin_cnt_stationary    AS order_lin_cnt_stationary_pym    --Abverkauf_Umsatz
   ,
   work2.turnover_net_val_stationary AS turnover_net_val_stationary_pym    --Umsatz_EJR   

   FROM p_lew_mart_lead_ac.v_agg_stat_order_mth_work work1
   LEFT OUTER JOIN p_lew_mart_lead_ac.v_agg_stat_order_mth_work work2
   ON work1.client_id = work2.client_id
   AND work1.cy_month -100 = work2.cy_month
   AND work1.currency_iso_cd  = work2.currency_iso_cd
   AND work1.curr_tot_id = work2.curr_tot_id;