/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_CS_ITEM_ACTIONGROUP_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_CS_ITEM_ACTIONGROUP_1
/*
#DescStart#
#$Revision: 14693 $, $LastChangedBy: gkunz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , country_iso_cd
    , item_actiongroup_id
    , item_sub_actiongroup_id
    , orig_item_nr
    , case_size
    , valid_from
    , valid_until
    , last_refresh
)
AS
SELECT
client_id,
country_iso_cd,
item_actiongroup_id,
item_sub_actiongroup_id,
orig_item_nr,
case_size,
valid_from,
valid_until,
last_refresh
FROM p_lew_mart_cs.v_cs_item_actiongroup_1
;