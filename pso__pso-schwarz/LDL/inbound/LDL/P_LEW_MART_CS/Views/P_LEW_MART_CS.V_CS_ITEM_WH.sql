/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_WH
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  23.09.2021    Ross, Ulrich                 Add group by while changing v_mat_gen_item_asis for ItemStatus_cd
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_CS_ITEM_WH
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
   i.client_id                       AS client_id
   , iwh.wh_id
   , i.orig_item_nr
   , i.case_size
   , i.src_country_lidl_cd           AS country_iso_cd
   , iwh.dwh_valid_from
   , iwh.dwh_valid_to
   , iwh.item_status_id
   , iwh.dwh_updated
   , iwh.dwh_created
   , iwh.dwh_load_id
   FROM p_lew_mart_cs.v_gen_item_wh iwh
   INNER JOIN p_lew_mart_cs.v_gen_item_asis i
   ON i.client_id = iwh.client_id
   AND i.item_sid = iwh.item_sid
   GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;