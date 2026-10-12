/* #DescStart#
#$Revision: 8167 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_item_gtin_1 (client_id, orig_item_nr, item_ean) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_item_gtin_1;