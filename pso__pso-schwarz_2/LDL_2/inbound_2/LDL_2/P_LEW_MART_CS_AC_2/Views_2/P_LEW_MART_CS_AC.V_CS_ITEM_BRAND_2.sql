/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_ITEM_BRAND_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_ITEM_BRAND_2
/*
#DescStart#
#$Revision: 13547 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , wh_id
    , orig_item_nr
    , item_id
    , case_size
    , supplier_id
    , orig_supplier_nr
    , brand_name
    , country_iso_cd
    , valid_from
    , valid_until
    , dwh_updated
    , dwh_created
    , dwh_load_id
    , load_id
    , src_id
    , last_refresh
)
AS
SELECT
    client_id
    , wh_id
    , orig_item_nr
    , item_id
    , case_size
    , supplier_id
    , orig_supplier_nr
    , brand_name
    , country_iso_cd
    , valid_from
    , valid_until
    , dwh_updated
    , dwh_created
    , dwh_load_id
    , load_id
    , src_id
    , last_refresh
FROM p_lew_mart_cs.v_cs_item_brand_2
;