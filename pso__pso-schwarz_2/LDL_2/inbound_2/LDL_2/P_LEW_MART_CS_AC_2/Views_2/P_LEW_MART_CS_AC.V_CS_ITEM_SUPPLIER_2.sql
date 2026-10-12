/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_ITEM_SUPPLIER_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_ITEM_SUPPLIER_2
/*
#DescStart#
#$Revision: 13547 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , src_supplier_id
    , orig_supplier_nr
    , sup_name
    , wh_id
    , item_id
    , orig_item_nr
    , case_size
    , country_iso_cd
    , valid_from
    , valid_until
    , man_valid_from
    , man_valid_until
    , last_refresh
)
AS
SELECT
client_id,
src_supplier_id,
orig_supplier_nr,
sup_name,
wh_id,
item_id,
orig_item_nr,
case_size,
country_iso_cd,
valid_from,
valid_until,
man_valid_from,
man_valid_until,
last_refresh
FROM p_lew_mart_cs.v_cs_item_supplier_2
;