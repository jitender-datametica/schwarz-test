/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_gen_item_family
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.2  23.09.2021    Ross, Ulrich                 change where in eLWIS part and v_client_migration_per in WAWI part added
#  1.3  23.09.2021    Ross, Ulrich                 change table v_sap_migration_client to v_client_migration_per in WAWI part added
#  1.4  28.09.2021    Ross, Ulrich                 Change where clause item_fam_grp_descr_long to item_fam_grp_descr to fix missing valus for US
#  1.5  14.12.2021    Ao, Lin                      Change Regex used to calculate item_family_cd for US articles
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_gen_item_family
(
      client_id
    , src_country_lidl_cd
    , item_familygroup_id
    , language_id
    , language_iso_cd
    , dat_rec_start
    , dat_rec_end
    , subitemgroup_id
    , itemfamily_cd
    , desc_short
    , desc_long
    , dwh_updated
    , dwh_created
    , dwh_load_id
    , load_id
    , src_id
)
AS
   SELECT
      dt_a.client_id
    , t.src_country_lidl_cd
    , dt_a.item_familygroup_id
    , dt_a.language_id
    , dt_a.language_iso_cd
    , dt_a.dat_rec_start
    , dt_a.dat_rec_end
    , dt_a.subitemgroup_id
    , dt_a.itemfamily_cd
    , dt_a.desc_short
    , dt_a.desc_long
    , dt_a.dwh_updated
    , dt_a.dwh_created
    , dt_a.dwh_load_id
    , dt_a.load_id
    , dt_a.src_id
   FROM (SELECT
      a.client_id
    , a.item_fam_grp_sid                  AS item_familygroup_id
    , COALESCE(c.language_id,-1)          AS language_id
    , COALESCE(c.language_iso_cd,'NA')    AS language_iso_cd
    , b.dwh_valid_from                    AS dat_rec_start
    , DATE'9999-12-31'                    AS dat_rec_end
    , CAST(b.sub_item_grp_cd AS INTEGER)  AS subitemgroup_id
    , CAST(
        CASE
          WHEN REGEXP_SUBSTR(COLLATE (a.item_fam_grp_descr,''),'^[0-9-]+\.[0-9-]+',1,1,'i') IS NOT NULL
          THEN REGEXP_REPLACE(COLLATE (a.item_fam_grp_descr,''),'^[0-9-]+\.([0-9-]+).*','\\1',1,1,'i')
          ELSE -1
        END
      AS INTEGER)                        AS itemfamily_cd
    , a.item_fam_grp_descr               AS desc_short
    , a.item_fam_grp_descr               AS desc_long
    , a.dwh_updated                      AS dwh_updated
    , a.dwh_created                      AS dwh_created
    , a.dwh_load_id                      AS dwh_load_id
    , CAST(-1 AS INTEGER)                AS load_id
    , 2                                  AS src_id
   FROM p_lew_core_ac.v_item_familygroup_descr a
   INNER JOIN p_lew_core_ac.v_item_familygroup_hist b
   ON b.client_id = a.client_id
   AND b.item_fam_grp_sid = a.item_fam_grp_sid
   AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_map_lang_spras c
   ON c.sap_lang_cd = a.lang_cd
   AND (c.sap_lang_cd = '@' OR c.language_id = a.client_id)
   INNER JOIN p_lew_core_ac.v_client_migration_per AS cmp    --To identify WAWI or ELWIS client
   ON a.client_id = cmp.client_id    
   AND cmp.active_fg = 1   

   WHERE a.item_fam_grp_descr IS NOT NULL

   UNION
   SELECT
      a.client_id
    , a.item_familygroup_id
    , COALESCE(a.language_id,-1)        AS language_id
    , COALESCE(c.language_iso_cd,'NA')  AS language_iso_cd
    , a.dat_rec_start
    , a.dat_rec_end
    , a.subitemgroup_id
    , a.family_cd                       AS itemfamily_cd
    , a.item_family_short_desc          AS desc_short
    , a.item_family_desc                AS desc_long
    , TIMESTAMP '1900-01-01 00:00:00'   AS dwh_updated
    , TIMESTAMP '1900-01-01 00:00:00'   AS dwh_created
    , CAST(-1 AS INTEGER)               AS dwh_load_id
    , a.load_id                         AS load_id
    , 1                                 AS src_id
   FROM p_lew_core_ac.v_wawi_itm_familygroup a
   INNER JOIN p_lew_core_ac.v_map_lang_spras c
   ON c.language_id = a.language_id
   AND (c.sap_lang_cd = '@' OR c.language_id = a.client_id)

   WHERE a.dat_rec_end > CURRENT_DATE + 1000
   AND a.item_familygroup_id > 0
   AND (a.client_id, a.item_familygroup_id) NOT IN (
     SELECT
          fam.client_id
        , fam.item_fam_grp_sid  AS item_familygroup_id
      FROM p_lew_core_ac.v_item_familygroup_descr fam
      INNER JOIN p_lew_core_ac.v_client_migration_per AS cmp    --To identify WAWI or ELWIS client
        ON fam.client_id = cmp.client_id    
        AND cmp.active_fg = 1
      WHERE fam.item_fam_grp_descr IS NOT NULL)
      ) dt_a
   INNER JOIN p_lew_core_ac.v_client c
   ON dt_a.client_id = c.client_id
   INNER JOIN p_lew_core_ac.v_country t
   ON c.country_sid = t.country_sid
;
