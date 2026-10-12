CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_STORE_STOCK_1
/*
#DescStart#
#$Revision: 9175 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , wh_id
    , orig_store_nr
    , orig_item_nr
    , dat_formdate
    , qty_stc_calc
    , dat_formdate_14
    , qty_stc_calc_14
    , min_dat_formdate_14
)
AS
SELECT
client_id,
wh_id,
orig_store_nr,
orig_item_nr,
dat_formdate,
qty_stc_calc,
dat_formdate_14,
qty_stc_calc_14,
min_dat_formdate_14
FROM p_lew_mart_wfm.v_store_stock_1
;

