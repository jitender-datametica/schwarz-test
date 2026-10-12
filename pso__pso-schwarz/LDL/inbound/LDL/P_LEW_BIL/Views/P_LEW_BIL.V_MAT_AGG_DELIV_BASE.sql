CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_AGG_DELIV_BASE
AS
/*
DescStart
$Revision: 8040 $, $LastChangedBy: mlysik $
SubjectAreas: Anliefermenge
DescEnd
*/
SELECT
b.client_id,
b.item_sid,
b.dat_formdate,
b.loc_sid_store,
b.loc_sid_wh_asis,
b.deliverytype_id,
b.orig_store_nr,
b.cy_month,
b.sub_item_grp_sid_asis,
b.foodaction_fg,
b.qty_total_del,
b.val_rtl_rl_del,
b.val_rtl_rl_net_del,
b.qty_piece_del_agg,
b.val_piece_del,
b.val_piece_net_del,
b.val_pr_diff_del,
b.val_pr_diff_net_del,
b.src_fg,
all_aspect1.wh_loc_sid AS loc_sid_wh_aspect1_asis,
all_aspect2.wh_loc_sid AS loc_sid_wh_aspect2_asis,
CURRENT_TIMESTAMP(6) AS dwh_updated
FROM
(SELECT
a.client_id,
a.item_sid,
a.dat_formdate,
a.loc_sid_store,
MAX(a.loc_sid_wh) AS loc_sid_wh_asis,
a.deliverytype_id,
MAX(a.orig_store_nr) AS orig_store_nr,
MAX(a.cy_month) AS cy_month,
MAX(a.sub_item_grp_sid) AS sub_item_grp_sid_asis,
MAX(a.foodaction_fg) AS foodaction_fg,
SUM(a.qty_total_del) AS qty_total_del,
SUM(a.val_rtl_rl_del) AS val_rtl_rl_del,
SUM(a.val_rtl_rl_net_del) AS val_rtl_rl_net_del,
SUM(a.qty_piece_del_agg) AS qty_piece_del_agg,
SUM(a.val_piece_del) AS val_piece_del,
SUM(a.val_piece_net_del) AS val_piece_net_del,
SUM(a.val_pr_diff_del) AS val_pr_diff_del,
SUM(a.val_pr_diff_net_del) AS val_pr_diff_net_del,
MAX(src_fg) AS src_fg
FROM
(SELECT
client_id,
item_sid,
dat_formdate,
loc_sid_store,
loc_sid_wh,
deliverytype_id,
orig_store_nr,
cy_month,
sub_item_grp_sid,
foodaction_fg,
qty_total_del,
val_rtl_rl_del,
val_rtl_rl_net_del,
qty_piece_del_agg,
val_piece_del,
val_piece_net_del,
val_pr_diff_del,
val_pr_diff_net_del,
src_fg
FROM p_lew_bil.v_mat0_deliv_base_core

UNION ALL
SELECT
client_id,
item_sid,
dat_formdate,
loc_sid_store,
loc_sid_wh,
deliverytype_id,
orig_store_nr,
cy_month,
sub_item_grp_sid,
foodaction_fg,
qty_total_del,
val_rtl_rl_del,
val_rtl_rl_net_del,
qty_piece_del_agg,
val_piece_del,
val_piece_net_del,
val_pr_diff_del,
val_pr_diff_net_del,
src_fg
FROM p_lew_bil.v_mat0_wawi_mov_item_delivery

    UNION ALL
SELECT
client_id,
item_sid,
dat_formdate,
loc_sid_store,
loc_sid_wh,
deliverytype_id,
orig_store_nr,
cy_month,
sub_item_grp_sid,
foodaction_fg,
qty_total_del,
val_rtl_rl_del,
val_rtl_rl_net_del,
qty_piece_del,
val_piece_del,
val_piece_net_del,
val_pr_diff_del,
val_pr_diff_net_del,
src_fg
FROM p_lew_bil.v_mat0_wawi_mov_item_dir_delivery

    UNION ALL
SELECT
client_id,
item_sid,
dat_formdate,
loc_sid_store,
loc_sid_wh,
deliverytype_id,
orig_store_nr,
cy_month,
sub_item_grp_sid,
foodaction_fg,
qty_total_del,
val_rtl_rl_del,
val_rtl_rl_net_del,
qty_piece_del_agg,
val_piece_del,
val_piece_net_del,
val_pr_diff_del,
val_pr_diff_net_del,
src_fg
FROM p_lew_bil.v_mat0_wawi_mov_item_fv_delivery
  ) a
  GROUP BY 1,2,3,4,6
) b

LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_merge_act aspect1
ON  aspect1.client_id = b.client_id
AND aspect1.st_loc_sid = b.loc_sid_store
AND aspect1.aspect_id = 1

LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_all_store_merge_act AS all_aspect1
ON  aspect1.aspect_id = all_aspect1.aspect_id
AND aspect1.client_id = all_aspect1.client_id
AND aspect1.move_to_st_loc_sid = all_aspect1.move_to_st_loc_sid

LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_store_merge_act aspect2
ON  aspect2.client_id = b.client_id
AND aspect2.st_loc_sid = b.loc_sid_store
AND aspect2.aspect_id = 2

LEFT OUTER JOIN p_lew_core_ac.v_wawi_org_all_store_merge_act AS all_aspect2
ON  aspect2.aspect_id = all_aspect2.aspect_id
AND aspect2.client_id = all_aspect2.client_id
AND aspect2.move_to_st_loc_sid = all_aspect2.move_to_st_loc_sid
;




