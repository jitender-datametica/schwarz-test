/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_ITEM_ITEMFAMILY_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_ITEM_ITEMFAMILY_2
/*
#DescStart#
#$Revision: 13547 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , orig_item_nr
    , case_size
    , item_familygroup_id
    , itemfamily_cd
    , language_iso_cd
    , country_iso_cd
    , valid_from
    , valid_until
    , last_refresh
)
AS
SELECT
client_id,
orig_item_nr,
case_size,
item_familygroup_id,
itemfamily_cd,
language_iso_cd,
country_iso_cd,
valid_from,
valid_until,
last_refresh
FROM p_lew_mart_cs.v_cs_item_itemfamily_2
;