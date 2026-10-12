/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.v_apt_item_familygroup_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs_ac.v_apt_item_familygroup_2
(
    client_id
  , country_iso_cd
  , dat_rec_start
  , dat_rec_end
  , item_familygroup_id
  , subitemgroup_id
  , itemfamily_cd
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
   SELECT
   a.client_id,
   a.country_iso_cd,
   a.dat_rec_start,
   a.dat_rec_end,
   a.item_familygroup_id,
   a.subitemgroup_id,
   a.itemfamily_cd,
   a.cs_updated,
   a.cs_created,
   a.cs_load_id
   FROM p_lew_mart_cs.v_apt_item_familygroup_2 a
   ;


