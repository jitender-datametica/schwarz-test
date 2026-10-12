/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  22.09.2021    Ross, Ulrich                 Add group by while changing v_mat_gen_item_asis_1 for ItemStatus_cd because it was missing on CLOUD
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_CS_ITEM_1
   (
   client_id
   , orig_item_nr
   , case_size
   , orig_item_nr_int
   , country_iso_cd
   , is_plu_item
   , buying_list_type_id
   , plu_nr
   , unitsize
   , dwh_updated
   , dwh_created
   , dwh_load_id
   )
   AS
      SELECT
      i.client_id                     AS client_id
      , i.orig_item_nr
      , i.case_size
      , i.orig_item_nr_int
      , i.src_country_lidl_cd         AS country_iso_cd
      , CASE WHEN i.case_plu_fg > 0
               THEN 1
               ELSE 0
          END                           AS is_plu_item
      , i.buying_list_type_id
      , i.plu_nr
      , i.unitsize
      , i.dwh_updated
      , i.dwh_created
      , i.dwh_load_id
      FROM p_lew_mart_cs.v_gen_item_asis_1 i
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
;