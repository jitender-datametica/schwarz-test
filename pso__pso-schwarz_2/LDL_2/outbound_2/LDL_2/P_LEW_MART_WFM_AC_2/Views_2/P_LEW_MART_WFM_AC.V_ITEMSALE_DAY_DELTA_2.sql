/* #DescStart#
#$Revision: 10039 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_itemsale_day_delta_2 (client_id, store, item_2, receiptdate, sum_qty_weight,
sum_qty_piece, sum_turnover_net, timelastsold, discount_value_net, discount_pieces, discount_turnover_net,
discount_weight_piece, discount_pieces_txj, load_id) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_itemsale_day_delta_2;