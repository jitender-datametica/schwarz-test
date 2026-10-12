/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_apt_item_familygroupdesc_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_apt_item_familygroupdesc_2
(
    client_id
  , country_iso_cd
  , item_familygroup_id
  , dat_rec_start
  , dat_rec_end
  , language_iso_cd
  , itemfamily_descr
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
   SELECT
   a.client_id,
   a.country_iso_cd,
   a.item_familygroup_id,
   a.dat_rec_start,
   a.dat_rec_end,
   a.language_iso_cd,
   a.itemfamily_descr,
   a.cs_updated,
   a.cs_created,
   a.cs_load_id
   FROM p_lew_mart_cs.t_apt_item_familygroupdesc_2 a
   ;


