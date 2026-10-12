/* #DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_inv_wh (client_id, wh_id, inv_id, inv_start_date, inv_end_date) AS SELECT
 *
FROM ldl_p_lew_mart_msi.v_inv_wh;