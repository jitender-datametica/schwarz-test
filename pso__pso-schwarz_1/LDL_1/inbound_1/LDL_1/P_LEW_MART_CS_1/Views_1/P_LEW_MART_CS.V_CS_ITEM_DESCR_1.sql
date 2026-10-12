/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_cs_item_descr_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  17.03.2021    Guenes, Oguzhan              CloudMig FS - APT Nachfolgepatch 4 TD: Änderungen in SNFLK 
#                                                  https://jira.schwarz/browse/DDLE-1994
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_cs_item_descr_1
(
client_id
, item_id
, orig_item_nr
, case_size
, item_descr_type_id
, valid_from
, valid_until
, item_descr
, country_iso_cd
, language_id
, language_iso_cd
, itemstatus_cd
, buying_list_type_id
, dwh_updated
, dwh_created
, dwh_load_id
)
AS
SELECT
     i.client_id                       AS client_id
     , i.item_sid                      AS item_id
     , i.orig_item_nr                  AS orig_item_nr
     , i.case_size                     AS case_size
     , 1                               AS item_descr_type_id -- immer 1, wobei 1: Hauptbezeichnung 2: Kurzbezeichnung,
     , CASE WHEN i.valid_from > CAST(COALESCE(descr.dwh_created,descr_sammel.dwh_created) AS DATE)
        THEN i.valid_from
        ELSE  CAST(COALESCE(descr.dwh_created,descr_sammel.dwh_created) AS DATE)
       END                             AS valid_from
     , i.valid_until
     , Coalesce(descr_sammel.item_descr, descr.item_descr) AS item_descr
     , cli.src_country_lidl_cd        AS country_iso_cd
     , lang.language_id         AS language_id
     , lang.language_iso_cd            AS language_iso_cd
     , i.itemstatus_cd                  AS itemstatus_cd
     , i.buying_list_type_id            AS buying_list_type_id
     , descr.dwh_updated
     , descr.dwh_created
     , descr.dwh_load_id
FROM (SELECT
          client_id
          , orig_item_nr
          , case_size
          , item_sid
          , item_sid_config
          , MIN(valid_from)     AS valid_from
          , MAX(valid_until)    AS valid_until
          , itemstatus_cd
          , buying_list_type_id
      FROM p_lew_mart_cs.v_gen_item_asis_1
      GROUP BY 1,2,3,4,5,8,9
      ) i

INNER JOIN p_lew_core_ac.v_item_hist_1 itm_h
ON i.client_id = itm_h.client_id
AND i.item_sid = itm_h.item_sid
AND itm_h.deleted_fg = 0
AND CURRENT_DATE BETWEEN itm_h.dwh_valid_from AND itm_h.dwh_valid_to

-- Ermittlung Land_1 des Clienten
INNER JOIN p_lew_core_ac.v_client_1               AS cli
ON cli.client_id = i.client_id

-- Ermittlung Sprache, Auffaechern auf Land_1 und Stiftung
INNER JOIN p_lew_core_ac.v_country_1              AS ctry
ON cli.country_sid = ctry.country_sid
OR ctry.src_country_lidl_cd = 'INT' -- Stiftung

-- Ermittlung Sprachcode
INNER JOIN p_lew_core_ac.v_report_language_1      AS rlang
ON ctry.lang_sid = rlang.lang_sid

-- Ermittlung WAWI Language ID
INNER JOIN p_lew_core_ac.v_map_lang_spras_1       AS lang
ON TRIM(lang.sap_lang_cd) = TRIM(rlang.iso_cd)

-- Zugriff auf Beschreibung mit Sprache (Land_1 und Stiftung) fuer Artikel_1
INNER JOIN p_lew_core_ac.v_item_descr_1      AS descr
ON i.client_id = descr.client_id
AND i.item_sid = descr.item_sid
AND rlang.lang_sid = descr.lang_sid

-- Optionale Ermittlung Sammelartikel fuer Zugriff auf Bezeichnung
LEFT OUTER JOIN p_lew_core_ac.v_item_1            AS itm_s
ON i.client_id = itm_s.client_id
AND i.item_sid_config = itm_s.item_sid

-- Zugriff auf Beschreibung mit Sprache (Land_1 und Stiftung) fuer Sammelartikel
LEFT OUTER JOIN p_lew_core_ac.v_item_descr_1      AS descr_sammel
ON i.client_id = descr_sammel.client_id
AND itm_s.item_sid = descr_sammel.item_sid
AND rlang.lang_sid = descr_sammel.lang_sid
; 
