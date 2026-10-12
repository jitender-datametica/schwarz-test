/* #DescStart#
#$Revision: 10039 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_return_day_delta_1 (client_id, store, item_1, receiptdate, sum_qty_weight,
sum_qty_piece, sum_turnover_net, load_id) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_return_day_delta_1;