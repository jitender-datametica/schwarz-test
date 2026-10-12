CREATE OR REPLACE VIEW p_lew_bil_ac.v_agg_store_day_item_sfo_2
/*
#DescStart#
#$Revision: 13836 $, $LastChangedBy: tbachmann $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , loc_sid_store
    , src_orig_store_nr
    , booking_dat
    , cy_week
    , cy_month
    , item_sid
    , sfotype_id
    , pcwo_reason_id
    , sfo_total_qty
    , sfo_wrtoff_zero_qty
    , sfo_total_rtl_rl_val
    , sfo_total_rtl_rl_net_val
    , sfo_wrtoff_zero_rtl_rl_val
    , sfo_wrtoff_zero_rtl_rl_net_val
    , val_pr_diff_sfo
    , val_pr_diff_net_sfo
    , sfo_total_wh_val
    , sfo_total_wh_net_val
    , sfo_total_store_val
    , sfo_total_store_net_val
    , foodaction_fg
    , src_fg
    , foodaction_fg_asis
    , loc_sid_wh_aspect1_asis
    , loc_sid_wh_aspect2_asis
    , loc_sid_wh_asis
    , sub_item_grp_sid_asis
    , dwh_updated
)
AS
SELECT
client_id,
loc_sid_store,
src_orig_store_nr,
booking_dat,
cy_week,
cy_month,
item_sid,
sfotype_id,
pcwo_reason_id,
sfo_total_qty,
sfo_wrtoff_zero_qty,
sfo_total_rtl_rl_val,
sfo_total_rtl_rl_net_val,
sfo_wrtoff_zero_rtl_rl_val,
sfo_wrtoff_zero_rtl_rl_net_val,
val_pr_diff_sfo,
val_pr_diff_net_sfo,
sfo_total_wh_val,
sfo_total_wh_net_val,
sfo_total_store_val,
sfo_total_store_net_val,
foodaction_fg,
src_fg,
foodaction_fg_asis,
loc_sid_wh_aspect1_asis,
loc_sid_wh_aspect2_asis,
loc_sid_wh_asis,
sub_item_grp_sid_asis,
dwh_updated
FROM p_lew_bil.v_agg_store_day_item_sfo_2
;

