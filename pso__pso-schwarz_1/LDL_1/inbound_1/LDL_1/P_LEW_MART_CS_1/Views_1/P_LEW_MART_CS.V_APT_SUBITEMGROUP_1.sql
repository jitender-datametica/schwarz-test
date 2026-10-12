/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_apt_subitemgroup_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_apt_subitemgroup_1
(
  client_id
, country_iso_cd
, dwh_valid_from
, dwh_valid_to
, subitemgroup_cd
, mainitemgroup_cd
, int_itemgroup_cd
, cs_updated
, cs_created
, cs_load_id
)
AS
   SELECT
   client_id,
   country_iso_cd,
   dwh_valid_from,
   dwh_valid_to,
   subitemgroup_cd,
   mainitemgroup_cd,
   int_itemgroup_cd,
   cs_updated,
   cs_created,
   cs_load_id
   FROM p_lew_mart_cs.t_apt_subitemgroup_1
   ;


