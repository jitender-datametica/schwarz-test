/* #DescStart#
#$Revision: 6699 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_ean (client_id, item_id, ean, ean_item_desc, language_id) AS SELECT *
 
FROM ldl_p_lew_mart_msi.v_itm_ean;