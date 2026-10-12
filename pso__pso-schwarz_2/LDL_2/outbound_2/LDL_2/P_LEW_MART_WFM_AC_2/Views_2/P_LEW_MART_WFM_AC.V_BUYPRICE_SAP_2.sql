/* #DescStart#
#$Revision: 7397 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm_ac.v_buyprice_sap_2 (land_2, whid, orig_item_nr, supplier_nr, valid_from,
valid_until, buyprice, buyprice_orig, currency_iso) AS SELECT *
FROM ldl_p_lew_mart_wfm.v_buyprice_sap_2;