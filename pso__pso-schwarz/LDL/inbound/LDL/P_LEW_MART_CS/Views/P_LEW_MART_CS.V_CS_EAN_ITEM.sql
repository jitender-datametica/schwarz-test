/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_EAN_ITEM
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_CS_EAN_ITEM
(
client_id
, ean_code
, orig_item_nr
, case_size
, country_iso_cd
, valid_from
, valid_until
, src_id
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
)
AS
   SELECT
   ean.client_id               AS client_id,
   ean.ean_code              AS ean_code,
   i.orig_item_nr            AS orig_item_nr,
   i.case_size               AS case_size,
   ean.src_country_lidl_cd   AS country_iso_cd,
   ean.valid_from            AS valid_from,
   CASE WHEN ean.valid_until = TO_DATE('31.12.9999', 'dd.mm.yyyy')
   THEN ean.valid_until - 1
   ELSE ean.valid_until
 END                       AS valid_until,
   ean.src_id,
   ean.dwh_updated,
   ean.dwh_created,
   ean.dwh_load_id,
   ean.load_id
   FROM (SELECT
   client_id,
   item_sid,
   valid_from,
   valid_until,
   ean_code,
   src_country_lidl_cd,
   src_id,
   dwh_updated,
   dwh_created,
   dwh_load_id,
   load_id
   FROM p_lew_mart_cs.v_gen_ean e
   GROUP BY 1,2,3,4,5,6,7,8,9,10,11
   ) ean
   INNER JOIN p_lew_mart_cs.v_gen_item_asis i
   ON ean.client_id = i.client_id
   AND ean.item_sid = i.item_sid

   WHERE CURRENT_DATE BETWEEN ean.valid_from AND ean.valid_until
   AND  i.orig_item_nr > 0
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12;