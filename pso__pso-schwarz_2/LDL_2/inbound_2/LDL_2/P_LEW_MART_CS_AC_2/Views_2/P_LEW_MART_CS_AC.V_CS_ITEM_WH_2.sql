/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_ITEM_WH_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_ITEM_WH_2
/*
#DescStart#
#$Revision: 14699 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , wh_id
    , orig_item_nr
    , case_size
    , country_iso_cd
    , dwh_valid_from
    , dwh_valid_to
    , item_status_id
    , dwh_updated
    , dwh_created
    , dwh_load_id
)
AS
SELECT
client_id,
wh_id,
orig_item_nr,
case_size,
country_iso_cd,
dwh_valid_from,
dwh_valid_to,
item_status_id,
dwh_updated,
dwh_created,
dwh_load_id
FROM p_lew_mart_cs.v_cs_item_wh_2
;