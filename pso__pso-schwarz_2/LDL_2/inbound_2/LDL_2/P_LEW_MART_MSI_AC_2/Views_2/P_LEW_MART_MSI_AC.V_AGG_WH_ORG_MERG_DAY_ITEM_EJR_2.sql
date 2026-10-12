CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AGG_WH_ORG_MERG_DAY_ITEM_EJR_2
/*
#DescStart#
#$Revision: 10032 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , wh_id
    , aspect_id
    , item_id
    , dat_formdate
    , discount_id
    , foodaction_fg
    , qty_discount_pos_ejr
    , qty_discount_hq_ejr
    , cnt_retail_ejr
    , cnt_return_ejr
    , qty_piece_ejr
    , qty_weight_ejr
    , qty_piece_weight_ejr
    , qty_return_ejr
    , val_discount_gross_ejr
    , val_discount_net_ejr
    , val_discount_base_gross_ejr
    , val_discount_base_net_ejr
    , val_rtl_gross_ejr
    , val_return_gross_ejr
    , val_rtl_net_ejr
    , val_return_net_ejr
    , qty_return_piece_weight_ejr
    , qty_return_defect_ejr
    , qty_return_saleable_ejr
    , qty_return_pc_wt_defect_ejr
    , qty_return_pc_wt_saleable_ejr
)
AS
SELECT
client_id,
wh_id,
aspect_id,
item_id,
dat_formdate,
discount_id,
foodaction_fg,
qty_discount_pos_ejr,
qty_discount_hq_ejr,
cnt_retail_ejr,
cnt_return_ejr,
qty_piece_ejr,
qty_weight_ejr,
qty_piece_weight_ejr,
qty_return_ejr,
val_discount_gross_ejr,
val_discount_net_ejr,
val_discount_base_gross_ejr,
val_discount_base_net_ejr,
val_rtl_gross_ejr,
val_return_gross_ejr,
val_rtl_net_ejr,
val_return_net_ejr,
qty_return_piece_weight_ejr,
qty_return_defect_ejr,
qty_return_saleable_ejr,
qty_return_pc_wt_defect_ejr,
qty_return_pc_wt_saleable_ejr
FROM p_lew_mart_msi.v_agg_wh_org_merg_day_item_ejr_2
;


