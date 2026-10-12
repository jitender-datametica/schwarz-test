CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_EJR_LP_THRESHOLD_CUM_INPUT_2
(
      client_id
    , dat_rec_start
    , dat_rec_end
    , void_qty_trans_past_3mth
    , void_qty_trans_random_1w
    , susp_qty_trans_past_3mth
    , susp_qty_trans_random_1w
    , return_qty_trans_past_3mth
    , return_freq_same_item_in_1w
    , ret_threshold_qty_week_in_3m
    , return_s2_qty_trans_past_3m
    , return_qty_trans_random_1w
    , deposit_qty_trans_past_3mth
    , deposit_ean_qty_trans_past_3m
    , deposit_noitm_qty_trans_past_3m
    , deposit_noitm_days_qty_past_3m
    , deposit_1itm_qty_trans_past_3m
    , deposit_1itm_qty_trans_rand_1w
    , deposit_amt_qty_trans_past_3m
    , deposit_amt_qty_trans_rand_1w
    , price_ssq_qty_trans_past_3m
    , price_ssq_qty_trans_randm_1w
    , susp_qty_trans_past_3mth_mc
    , susp_qty_trans_random_1w_mc
    , deposit_qty_total_past_3mth
    , price_series_qty_past_3m
    , ret_qty_store_same_rec_past_3m
    , ret_qty_not_authorised_past_3m
    , return_freq_same_checker
	  , plus_days
    , requesting_user
    , timestamp_request
    , approval_user
    , approval_fg
    , timestamp_approval
)
AS
   SELECT
       client_id
   ,dat_rec_start
   ,dat_rec_end
   ,void_qty_trans_past_3mth
   ,void_qty_trans_random_1w
   ,susp_qty_trans_past_3mth
   ,susp_qty_trans_random_1w
   ,return_qty_trans_past_3mth
   ,return_freq_same_item_in_1w
   ,ret_threshold_qty_week_in_3m
   ,return_s2_qty_trans_past_3m
   ,return_qty_trans_random_1w
   ,deposit_qty_trans_past_3mth
   ,deposit_ean_qty_trans_past_3m
   ,deposit_noitm_qty_trans_past_3m
   ,deposit_noitm_days_qty_past_3m
   ,deposit_1itm_qty_trans_past_3m
   ,deposit_1itm_qty_trans_rand_1w
   ,deposit_amt_qty_trans_past_3m
   ,deposit_amt_qty_trans_rand_1w
   ,price_ssq_qty_trans_past_3m
   ,price_ssq_qty_trans_randm_1w
   ,susp_qty_trans_past_3mth_mc
   ,susp_qty_trans_random_1w_mc
   ,deposit_qty_total_past_3mth
   ,price_series_qty_past_3m
   ,ret_qty_store_same_rec_past_3m
   ,ret_qty_not_authorised_past_3m
   ,return_freq_same_checker
   ,plus_days
   ,requesting_user
   ,timestamp_request
   ,approval_user
   ,approval_fg
   ,timestamp_approval
  FROM p_lew_mart_msi.v_ejr_lp_threshold_cum_input_2
;