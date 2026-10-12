/* #DescStart#
#$Revision: 9859 $, $LastChangedBy: mildorfj $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_buyprice (country_iso_cd, wh_id, item, supplier_nr, valid_from,
valid_until, buyprice, buyprice_orig, currency_iso) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_buyprice;