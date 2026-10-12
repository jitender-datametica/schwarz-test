
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_REF_THM_1 COMMENT = 'Multi language reference view for thm'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  13.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  03.01.2022    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  client_id      COMMENT 'Landeskennzeichen'
, orig_thm_nr    COMMENT 'Orig_Thk Bez. Einheit nr'
, factor_ep      COMMENT 'Factor EP'
, thm_desc       COMMENT 'Thm_Desk Bez. Einheit desc'
, thm_desc_AT    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit AT'
, thm_desc_BE    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit BE'
, thm_desc_BE_FR COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit BE_FR'
, thm_desc_BG    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit BG'
, thm_desc_CH    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit CH'
, thm_desc_CY    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit CY'
, thm_desc_CZ    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit CZ'
, thm_desc_DK    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit DK'
, thm_desc_EE    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit EE'
, thm_desc_ES    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit ES'
, thm_desc_FI    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit FI'
, thm_desc_FR    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit FR'
, thm_desc_GB    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit GB'
, thm_desc_GR    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit GR'
, thm_desc_HR    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit HR'
, thm_desc_HU    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit HU'
, thm_desc_IE    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit IE'
, thm_desc_IT    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit IT'
, thm_desc_LT    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit LT'
, thm_desc_LV    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit LV'
, thm_desc_NI    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit NI'
, thm_desc_NL    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit NL'
, thm_desc_DE    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit DE'
, thm_desc_PL    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit PL'
, thm_desc_PT    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit PT'
, thm_desc_RO    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit RO'
, thm_desc_SE    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit SE'
, thm_desc_SI    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit SI'
, thm_desc_SK    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit SK'
, thm_desc_CS    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit CS'
, thm_desc_MT    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit MT'
, thm_desc_US    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit US'
, thm_desc_RS    COMMENT 'Thm_Desk Landesspezifische Bezeichnung Einheit RS_1'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT   client_id
       , orig_thm_nr
       , MAX(factor_ep) AS factor_ep
       , MAX(CASE WHEN language_id IN (7)     THEN thm_desc ELSE NULL END) AS thm_desc
       , MAX(CASE WHEN language_id IN (1)     THEN thm_desc ELSE NULL END) AS thm_desc_AT
       , MAX(CASE WHEN language_id IN (2)     THEN thm_desc ELSE NULL END) AS thm_desc_BE
       , MAX(CASE WHEN language_id IN (12)    THEN thm_desc ELSE NULL END) AS thm_desc_BE_FR
       , MAX(CASE WHEN language_id IN (3)     THEN thm_desc ELSE NULL END) AS thm_desc_BG
       , MAX(CASE WHEN language_id IN (4)     THEN thm_desc ELSE NULL END) AS thm_desc_CH
       , MAX(CASE WHEN language_id IN (5)     THEN thm_desc ELSE NULL END) AS thm_desc_CY
       , MAX(CASE WHEN language_id IN (6)     THEN thm_desc ELSE NULL END) AS thm_desc_CZ
       , MAX(CASE WHEN language_id IN (8)     THEN thm_desc ELSE NULL END) AS thm_desc_DK
       , MAX(CASE WHEN language_id IN (9)     THEN thm_desc ELSE NULL END) AS thm_desc_EE
       , MAX(CASE WHEN language_id IN (10,31) THEN thm_desc ELSE NULL END) AS thm_desc_ES
       , MAX(CASE WHEN language_id IN (11)    THEN thm_desc ELSE NULL END) AS thm_desc_FI
       , MAX(CASE WHEN language_id IN (12)    THEN thm_desc ELSE NULL END) AS thm_desc_FR
       , MAX(CASE WHEN language_id IN (13)    THEN thm_desc ELSE NULL END) AS thm_desc_GB
       , MAX(CASE WHEN language_id IN (14,5)  THEN thm_desc ELSE NULL END) AS thm_desc_GR
       , MAX(CASE WHEN language_id IN (15)    THEN thm_desc ELSE NULL END) AS thm_desc_HR
       , MAX(CASE WHEN language_id IN (16)    THEN thm_desc ELSE NULL END) AS thm_desc_HU
       , MAX(CASE WHEN language_id IN (17,21) THEN thm_desc ELSE NULL END) AS thm_desc_IE
       , MAX(CASE WHEN language_id IN (18,32) THEN thm_desc ELSE NULL END) AS thm_desc_IT
       , MAX(CASE WHEN language_id IN (19)    THEN thm_desc ELSE NULL END) AS thm_desc_LT
       , MAX(CASE WHEN language_id IN (20)    THEN thm_desc ELSE NULL END) AS thm_desc_LV
       , MAX(CASE WHEN language_id IN (21)    THEN thm_desc ELSE NULL END) AS thm_desc_NI
       , MAX(CASE WHEN language_id IN (22)    THEN thm_desc ELSE NULL END) AS thm_desc_NL
       , MAX(CASE WHEN language_id IN (23)    THEN thm_desc ELSE NULL END) AS thm_desc_DE
       , MAX(CASE WHEN language_id IN (24)    THEN thm_desc ELSE NULL END) AS thm_desc_PL
       , MAX(CASE WHEN language_id IN (25)    THEN thm_desc ELSE NULL END) AS thm_desc_PT
       , MAX(CASE WHEN language_id IN (26)    THEN thm_desc ELSE NULL END) AS thm_desc_RO
       , MAX(CASE WHEN language_id IN (27)    THEN thm_desc ELSE NULL END) AS thm_desc_SE
       , MAX(CASE WHEN language_id IN (28)    THEN thm_desc ELSE NULL END) AS thm_desc_SI
       , MAX(CASE WHEN language_id IN (29)    THEN thm_desc ELSE NULL END) AS thm_desc_SK
       , MAX(CASE WHEN language_id IN (31)    THEN thm_desc ELSE NULL END) AS thm_desc_CS
       , MAX(CASE WHEN language_id IN (32)    THEN thm_desc ELSE NULL END) AS thm_desc_MT
       , MAX(CASE WHEN language_id IN (33)    THEN thm_desc ELSE NULL END) AS thm_desc_US
       , MAX(CASE WHEN language_id IN (34)    THEN thm_desc ELSE NULL END) AS thm_desc_RS
  FROM (
        SELECT   ocs.client_id
               , COALESCE(thm_client.orig_thm_nr, thm_global.orig_thm_nr) AS orig_thm_nr
               , COALESCE(thm_client.factor_ep,   thm_global.factor_ep)   AS factor_ep
               , COALESCE(thm_client.language_id, thm_global.language_id) AS language_id
               , COALESCE(thm_client.thm_desc,    thm_global.thm_desc)    AS thm_desc
          FROM P_LEW_CORE_AC.v_wawi_org_client_skey_1    AS ocs
          LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_ref_thm_1 AS thm_client
            ON ocs.client_id = thm_client.client_id
          LEFT OUTER JOIN P_LEW_CORE_AC.v_wawi_ref_thm_1 AS thm_global
            ON thm_client.client_id IS NULL
           AND thm_global.client_id = 7
       ) AS t
 GROUP BY   client_id
          , orig_thm_nr
;
