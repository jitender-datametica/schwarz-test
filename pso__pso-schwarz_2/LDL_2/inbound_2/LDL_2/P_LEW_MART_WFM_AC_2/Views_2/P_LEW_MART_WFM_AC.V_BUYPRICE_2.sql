CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_BUYPRICE_2
/*
#DescStart#
#$Revision: 9859 $, $LastChangedBy: mildorfj $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    country_iso_cd
    , wh_id
    , item_2
    , supplier_nr
    , valid_from
    , valid_until
    , buyprice
    , buyprice_orig
    , currency_iso
)
AS
SELECT
country_iso_cd,
wh_id,
item_2,
supplier_nr,
valid_from,
valid_until,
buyprice,
buyprice_orig,
currency_iso
FROM p_lew_mart_wfm.v_buyprice_2
;





