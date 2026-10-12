/* #DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_sup_supplier_negot_cntry_ref_1 (client_id, supplier_id, negot_cntry_cd) AS
SELECT *
FROM ldl_p_lew_mart_msi.v_sup_supplier_negot_cntry_ref_1;