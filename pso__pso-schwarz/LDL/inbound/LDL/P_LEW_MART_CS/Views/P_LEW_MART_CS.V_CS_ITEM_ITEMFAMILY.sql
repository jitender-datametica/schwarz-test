/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_ITEMFAMILY
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_CS_ITEM_ITEMFAMILY
(
    client_id
    , orig_item_nr
    , case_size
    , item_familygroup_id
    , itemfamily_cd
    , language_iso_cd
    , country_iso_cd
    , valid_from
    , valid_until
    , dwh_updated
    , dwh_created
    , dwh_load_id
    , load_id
    , src_id
    , last_refresh
)
AS
SELECT
    i.client_id              AS client_id
    , i.orig_item_nr
    , i.case_size
    , i.item_familygroup_id
    , i_fam.itemfamily_cd
    , i_fam.language_iso_cd
    , i.src_country_lidl_cd  AS country_iso_cd
    , i.valid_from
    , i.valid_until
    , i.dwh_updated             AS dwh_updated
    , i.dwh_created             AS dwh_created
    , i.dwh_load_id             AS dwh_load_id
    , CAST(-1 AS INTEGER)       AS load_id
    , 2                         AS src_id
    , CURRENT_TIMESTAMP      AS last_refresh
FROM P_LEW_MART_CS.v_gen_item_asis AS i
INNER JOIN (SELECT
                client_id
                , item_familygroup_id
                , itemfamily_cd
                , language_iso_cd
            FROM P_LEW_MART_CS.v_gen_item_family
            WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end
            GROUP BY 1,2,3,4
            ) AS i_fam
ON i.client_id = i_fam.client_id
AND i.item_familygroup_id = i_fam.item_familygroup_id
WHERE i.orig_item_nr > 0
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
;