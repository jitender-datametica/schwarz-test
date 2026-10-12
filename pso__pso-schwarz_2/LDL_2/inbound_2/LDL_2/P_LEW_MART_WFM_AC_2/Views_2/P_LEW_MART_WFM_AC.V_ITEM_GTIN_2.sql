CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_ITEM_GTIN_2
/*
#DescStart#
#$Revision: 8167 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , orig_item_nr
    , item_ean
)
AS
SELECT
client_id,
orig_item_nr,
item_ean
FROM p_lew_mart_wfm.v_item_gtin_2
;



