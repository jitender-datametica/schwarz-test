CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_SUP_SUPPLIER_NEGOT_CNTRY_REF
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, supplier_id
, negot_cntry_cd
 )
AS
SELECT
client_id,
supplier_id,
negot_cntry_cd
FROM p_lew_mart_msi.v_sup_supplier_negot_cntry_ref;


