CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_BUYPRICE_SAP_1
/*
#DescStart#
#$Revision: 7397 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    Land_1
    , WHID
    , ORIG_ITEM_NR
    , Supplier_nr
    , valid_from
    , valid_until
    , Buyprice
    , Buyprice_orig
    , Currency_ISO
)
AS
SELECT
Land_1,
WHID,
ORIG_ITEM_NR,
Supplier_nr,
valid_from,
valid_until,
Buyprice,
Buyprice_orig,
Currency_ISO
FROM p_lew_mart_wfm.v_buyprice_sap_1
;


