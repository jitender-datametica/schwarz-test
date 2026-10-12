/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_ACTIONGROUP
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_CS_ITEM_ACTIONGROUP
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
   i.client_id                       AS client_id,
   i.src_country_lidl_cd           AS country_iso_cd,
   i.item_actiongroup_id           AS item_actiongroup_id,
   i.item_sub_actiongroup_id       AS item_sub_actiongroup_id,
   i.orig_item_nr                  AS orig_item_nr,
   i.case_size                     AS case_size,
   i.valid_from                    AS valid_from,
   i.valid_until                   AS valid_until,
   CURRENT_TIMESTAMP               AS last_refresh
   FROM p_lew_mart_cs.v_gen_item_asis AS i

   WHERE i.item_actiongroup_id IS NOT NULL
   AND i.item_sub_actiongroup_id IS NOT NULL

   GROUP BY 1,2,3,4,5,6,7,8
;