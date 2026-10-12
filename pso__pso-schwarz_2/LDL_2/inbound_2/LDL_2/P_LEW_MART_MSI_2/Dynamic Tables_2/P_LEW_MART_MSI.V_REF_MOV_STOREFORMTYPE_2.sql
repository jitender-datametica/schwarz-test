
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_MOV_STOREFORMTYPE_2 COMMENT = 'Multi language reference for storeform'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  17.12.2019    Michael Ueding           Ersetzen Legacy mit Core Objekt
#  1.4  10.01.2020    Ulrich Meister           changed to replace n_-View approach, Patch 20191218_2333_MCD_mart_views_WH_MOVE_DWH20 IDMO-2570, DWH-7995
#  1.5  06.08.2020    Roy,Ritanjal             Introduce new country_2 LV
#  1.6  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#----------------------------------------------------------------------------
*/
(
  client_id          COMMENT 'Landeskennzeichen'
, sfotype_id         COMMENT 'Belegtyp-Belegtyp'
, sfotype_desc_AT    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit AT'
, sfotype_desc_BE    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit BE'
, sfotype_desc_BE_FR COMMENT 'sfotype Landesspezifische Bezeichnung Einheit BE_FR'
, sfotype_desc_BG    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit BG'
, sfotype_desc_CH    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit CH'
, sfotype_desc_CY    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit CY'
, sfotype_desc_CZ    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit CZ'
, sfotype_desc       COMMENT 'Belegbeschreibung-Belegbeschreibung'
, sfotype_desc_DK    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit DK'
, sfotype_desc_EE    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit EE'
, sfotype_desc_ES    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit ES'
, sfotype_desc_FI    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit FI'
, sfotype_desc_FR    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit FR'
, sfotype_desc_GB    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit GB'
, sfotype_desc_GR    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit GR'
, sfotype_desc_HR    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit HR'
, sfotype_desc_HU    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit HU'
, sfotype_desc_IE    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit IE'
, sfotype_desc_IT    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit IT'
, sfotype_desc_LT    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit LT'
, sfotype_desc_LV    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit LV'
, sfotype_desc_NI    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit NI'
, sfotype_desc_NL    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit NL'
, sfotype_desc_DE    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit DE'
, sfotype_desc_PL    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit PL'
, sfotype_desc_PT    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit PT'
, sfotype_desc_RO    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit RO'
, sfotype_desc_SE    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit SE'
, sfotype_desc_SI    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit SI'
, sfotype_desc_SK    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit SK'
, sfotype_desc_CS    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit CS'
, sfotype_desc_MT    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit MT'
, sfotype_desc_US    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit US'
, sfotype_desc_RS    COMMENT 'sfotype Landesspezifische Bezeichnung Einheit RS_2'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT   client_id
       , sfotype_id
       , MAX(CASE WHEN language_id = 1  THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_AT
       , MAX(CASE WHEN language_id = 2  THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_BE
       , MAX(CASE WHEN language_id = 12 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_BE_FR
       , MAX(CASE WHEN language_id = 3  THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_BG
       , MAX(CASE WHEN language_id = 4  THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_CH
       , MAX(CASE WHEN language_id = 5  THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_CY
       , MAX(CASE WHEN language_id = 6  THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_CZ
       , MAX(CASE WHEN language_id = 7  THEN sfotype_desc ELSE NULL END ) AS sfotype_desc
       , MAX(CASE WHEN language_id = 8  THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_DK
       , MAX(CASE WHEN language_id = 9  THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_ES
       , MAX(CASE WHEN language_id = 11 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_FI
       , MAX(CASE WHEN language_id = 12 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_FR
       , MAX(CASE WHEN language_id = 13 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_GB
       , MAX(CASE WHEN language_id = 14 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_GR
       , MAX(CASE WHEN language_id = 15 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_HR
       , MAX(CASE WHEN language_id = 16 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_HU
       , MAX(CASE WHEN language_id = 17 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_IE
       , MAX(CASE WHEN language_id = 18 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_IT
       , MAX(CASE WHEN language_id = 19 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_LT
       , MAX(CASE WHEN language_id = 20 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_LV
       , MAX(CASE WHEN language_id = 21 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_NI
       , MAX(CASE WHEN language_id = 22 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_NL
       , MAX(CASE WHEN language_id = 23 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_DE
       , MAX(CASE WHEN language_id = 24 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_PL
       , MAX(CASE WHEN language_id = 25 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_PT
       , MAX(CASE WHEN language_id = 26 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_RO
       , MAX(CASE WHEN language_id = 27 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_SE
       , MAX(CASE WHEN language_id = 28 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_SI
       , MAX(CASE WHEN language_id = 29 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_SK
       , MAX(CASE WHEN language_id = 31 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_CS
       , MAX(CASE WHEN language_id = 32 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_MT
       , MAX(CASE WHEN language_id = 33 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_US
       , MAX(CASE WHEN language_id = 34 THEN sfotype_desc ELSE NULL END ) AS sfotype_desc_RS
  FROM (
        SELECT   sto.client_id
               , sto.sfo_type_id    AS sfotype_id
               , sto.sfo_type_descr AS sfotype_desc
               , m.language_id
          FROM P_LEW_CORE_AC.v_ref_store_form_type_descr_2 AS sto
         INNER JOIN p_lew_core_ac.v_report_language_2      AS l
            ON sto.lang_sid = l.lang_sid
         INNER JOIN p_lew_core_ac.v_map_lang_spras_2       AS m
            ON TRIM(m.sap_lang_cd) = TRIM(l.iso_cd)
        ) AS x
 GROUP BY   client_id
          , sfotype_id
;
/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_wawi_ref_ejr_return_text_2", "p_lew_core_ac.v_wawi_org_wh_act_2", "p_lew_bil_ac.v_warehouse_2", "p_lew_core_ac.v_ref_claim_reason_2", "p_lew_core_ac.v_ref_return_reason_descr_2" ****/
