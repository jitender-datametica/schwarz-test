/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_cs_itemfamily
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Guenes, Oguzhan              Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_cs_itemfamily
(
client_id
, item_familygroup_id
, itemfamily_cd
, language_iso_cd
, country_iso_cd
, valid_from
, valid_until
, desc_long
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
, src_id
)
AS
SELECT
    i.client_id                       AS client_id
    , i.item_familygroup_id           AS item_familygroup_id
    , i.itemfamily_cd
    , i.language_iso_cd
    , i.src_country_lidl_cd           AS country_iso_cd
    , i.dat_rec_start                 AS valid_from
    , i.dat_rec_end                   AS valid_until
    , CASE WHEN i.src_id = 2
        THEN LTRIM(SUBSTRING(i.desc_long,POSITION(i.desc_long, ' ' )))
        ELSE i.desc_long
      END                             AS desc_long
    , i.dwh_updated
    , i.dwh_created
    , i.dwh_load_id
    , i.load_id
    , i.src_id
FROM P_LEW_MART_CS.v_gen_item_family i
WHERE CURRENT_DATE BETWEEN i.dat_rec_start AND i.dat_rec_end;