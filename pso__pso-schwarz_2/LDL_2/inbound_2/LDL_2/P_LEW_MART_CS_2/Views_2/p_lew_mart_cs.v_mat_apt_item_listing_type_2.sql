/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_mat_apt_item_listing_type_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_apt_item_listing_type_2
(
  client_id
, country_iso_cd
, itemlistingtype_cd
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
, src_id
)
AS
   SELECT
   a.client_id,
   a.src_country_lidl_cd AS country_iso_cd,
   a.buying_list_type_id AS itemlistingtype_cd,
   a.dwh_updated,
   a.dwh_created,
   a.dwh_load_id,
   a.load_id,
   a.src_id
   FROM p_lew_mart_cs.v_gen_item_hist_2 a

   WHERE a.itemstatus_cd > 3
    AND a.itemstatus_cd < 10
    AND a.buying_list_type_id IS NOT NULL
    AND a.buying_list_type_id > 0

   GROUP BY 1,2,3,4,5,6,7,8
   QUALIFY ROW_NUMBER () OVER (PARTITION BY a.client_id, a.buying_list_type_id ORDER BY a.dwh_load_id DESC NULLS LAST) = 1;


