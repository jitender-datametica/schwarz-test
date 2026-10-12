CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_ITEMSALE_DAY_DELTA
/*
#DescStart#
#$Revision: 10039 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , store
    , item
    , receiptdate
    , sum_qty_weight
    , sum_qty_piece
    , sum_turnover_net
    , timelastsold
    , discount_value_net
    , discount_pieces
    , discount_turnover_net
    , discount_weight_piece
    , discount_pieces_txj
    , load_id
)
AS
SELECT
client_id,
store,
item,
receiptdate,
sum_qty_weight,
sum_qty_piece,
sum_turnover_net,
timelastsold,
discount_value_net,
discount_pieces,
discount_turnover_net,
discount_weight_piece,
discount_pieces_txj,
load_id
FROM p_lew_mart_wfm.v_itemsale_day_delta
;


