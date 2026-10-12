/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_EAN_ITEM_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_EAN_ITEM_1
/*
#DescStart#
#$Revision: 14699 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , ean_code
    , orig_item_nr
    , case_size
    , country_iso_cd
    , valid_from
    , valid_until
    , src_id
    , dwh_updated
    , dwh_created
    , dwh_load_id
    , load_id
)
AS
SELECT
client_id,
ean_code,
orig_item_nr,
case_size,
country_iso_cd,
valid_from,
valid_until,
src_id,
dwh_updated,
dwh_created,
dwh_load_id,
load_id
FROM p_lew_mart_cs.v_cs_ean_item_1
;


