CREATE OR REPLACE VIEW p_lew_bil.v_agg_deliv_base
AS
/*
#DescStart#
#$Revision: 13773 $, $LastChangedBy: tbachmann $
#SubjectAreas#: Access Layer
#DescEnd#
*/
SELECT
    v.client_id,
    v.item_sid,
    v.dat_formdate,
    v.loc_sid_store,
    v.loc_sid_wh_asis,
    v.loc_sid_wh_aspect1_asis,
    v.loc_sid_wh_aspect2_asis,
    v.deliverytype_id,
    v.orig_store_nr,
    v.cy_month,
    v.sub_item_grp_sid_asis,
    v.foodaction_fg,
    v.qty_total_del,
    v.val_rtl_rl_del,
    v.val_rtl_rl_net_del,
    v.qty_piece_del_agg,
    v.val_piece_del,
    v.val_piece_net_del,
    v.val_pr_diff_del,
    v.val_pr_diff_net_del,
    v.src_fg,
    v.dwh_updated
    FROM p_lew_bil.t_agg_deliv_base AS v
;
