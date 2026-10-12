/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_ITEM_DESCR_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_ITEM_DESCR_1
/*
#DescStart#
#$Revision: 14672 $, $LastChangedBy: uross $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , item_id
    , orig_item_nr
    , case_size
    , item_descr_type_id
    , valid_from
    , valid_until
    , item_descr
    , country_iso_cd
    , language_iso_cd
    , dwh_updated
    , dwh_created
    , dwh_load_id
)
AS
SELECT
client_id,
item_id,
orig_item_nr,
case_size,
item_descr_type_id,
valid_from,
valid_until,
item_descr,
country_iso_cd,
language_iso_cd,
dwh_updated,
dwh_created,
dwh_load_id
FROM p_lew_mart_cs.v_cs_item_descr_1
;