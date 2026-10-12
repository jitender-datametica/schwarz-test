/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_item_familygroupdesc
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_item_familygroupdesc
(
    client_id
  , country_iso_cd
  , item_familygroup_id
  , dat_rec_start
  , dat_rec_end
  , language_iso_cd
  , itemfamily_descr
  , dwh_updated
  , dwh_created
  , dwh_load_id
  , load_id
  , src_id
)
AS
   SELECT
   a.client_id,
   a.src_country_lidl_cd  AS country_iso_cd,
   a.item_familygroup_id,
   a.dat_rec_start,
   a.dat_rec_end,
   a.language_iso_cd,
   a.desc_long           AS itemfamily_descr,
   a.dwh_updated,
   a.dwh_created,
   a.dwh_load_id,
   a.load_id,
   a.src_id
   FROM p_lew_mart_cs.v_gen_item_family a
   ;


