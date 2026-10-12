
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_FAMILYGROUP_2 COMMENT = 'Multi language Item_2 Family Group descriptions'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  13.10.2017    Meister,Ulrich logic moved from mart_msi to lew_bil ll ll
#  1.2  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  28.11.2018    Proch, Marika            Änderung der Datenquelle  von Core  zu BIL-Layer
#  1.3  17.01.2018    Wieber,Harald            Release 2.2
#  1.4  16.03.2018    Proch,Marika             In der Family_desc fpr italien wird nun auch die Beschreibung von Malta angezeigt. Gleiches gilt für GR.
#  1.5  27.05.2020    Bachmann,Torsten         Added QUALIFY to avoid duplicate rows (INC1874813, IDMO-3035, Patch-Nr. 2483)
#  1.6  17.11.2020    Meme, Yasin              Add LV DWHA-248 Patch 2665
#  1.7  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.8  21.12.2021    Morris, Michael          Added Estonia EE
#  1.9  27.01.2022    Zied Nanaa               Set SH (Serbo-Croatian) as a language for the Republic of Serbia (RS_2)
#  1.10 28.02.2022    Bachmann, Torsten        Adjust order in SELECT to fit to Column-Definition
#                                              INC4267807, ADO User-Story 291917
#  1.11 15.05.2024    Bialek, Aleksander       Add the AF Code to the view for EK-Security filtering use, ADO WI:618120
#----------------------------------------------------------------------------
*/
(
  client_id                    COMMENT 'Landeskennzeichen'
, family_cd                    COMMENT 'Artikelfamile Landesspezifischer Code WAWI'
, item_familygroup_id          COMMENT 'Artikelfamilen ID'
, subitemgroup_id              COMMENT 'WAWI CD'
, src_familygrp_cd             COMMENT 'Full Artikelfamile Landesspezifischer Code WAWI'
, item_family_desc_AT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang AT'
, item_family_desc_BE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BE'
, item_family_desc_BE_FR       COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BE_FR'
, item_family_desc_BG          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang BG'
, item_family_desc_CH          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CH'
, item_family_desc_CY          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CY'
, item_family_desc_CZ          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CZ'
, item_family_desc             COMMENT 'Artikelfamile Bezeichnung Lang'
, item_family_desc_DK          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang DK'
, item_family_desc_EE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang EE'
, item_family_desc_ES          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang ES'
, item_family_desc_FI          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang FI'
, item_family_desc_FR          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang FR'
, item_family_desc_GB          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang GB'
, item_family_desc_GR          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang GR'
, item_family_desc_HR          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang HR'
, item_family_desc_HU          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang HU'
, item_family_desc_IE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang IE'
, item_family_desc_IT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang IT'
, item_family_desc_LT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang LT'
, item_family_desc_LV          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang LV'
, item_family_desc_NI          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang NI'
, item_family_desc_NL          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang NL'
, item_family_desc_DE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang DE'
, item_family_desc_PL          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang PL'
, item_family_desc_PT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang PT'
, item_family_desc_RO          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang RO'
, item_family_desc_SE          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SE'
, item_family_desc_SI          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SI'
, item_family_desc_SK          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang SK'
, item_family_desc_CS          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang CS'
, item_family_desc_MT          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang MT'
, item_family_desc_US          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang US'
, item_family_desc_RS          COMMENT 'Artikelfamile Landesspezifische Bezeichnung Lang RS_2'
, item_family_short_desc_AT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung AT'
, item_family_short_desc_BE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BE'
, item_family_short_desc_BE_FR COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BE_FR'
, item_family_short_desc_BG    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung BG'
, item_family_short_desc_CH    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CH'
, item_family_short_desc_CY    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CY'
, item_family_short_desc_CZ    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CZ'
, item_family_short_desc       COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung'
, item_family_short_desc_DK    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung DK'
, item_family_short_desc_EE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung EE'
, item_family_short_desc_ES    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung ES'
, item_family_short_desc_FI    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung FI'
, item_family_short_desc_FR    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung FR'
, item_family_short_desc_GB    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung GB'
, item_family_short_desc_GR    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung GR'
, item_family_short_desc_HR    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung HR'
, item_family_short_desc_HU    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung HU'
, item_family_short_desc_IE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung IE'
, item_family_short_desc_IT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung IT'
, item_family_short_desc_LT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung LT'
, item_family_short_desc_LV    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung LV'
, item_family_short_desc_NI    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung NI'
, item_family_short_desc_NL    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung NL'
, item_family_short_desc_DE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung DE'
, item_family_short_desc_PL    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung PL'
, item_family_short_desc_PT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung PT'
, item_family_short_desc_RO    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung RO'
, item_family_short_desc_SE    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SE'
, item_family_short_desc_SI    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SI'
, item_family_short_desc_SK    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung SK'
, item_family_short_desc_CS    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung CS'
, item_family_short_desc_MT    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung MT'
, item_family_short_desc_US    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung US'
, item_family_short_desc_RS    COMMENT 'Artikelfamile Landesspezifische Kurzbezeichnung RS_2'
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT   ifg.client_id
       , CASE /* extraktion des familycodes aus Kompositfeld, Datentypangleichung */
               WHEN CHARINDEX('.', ifg.src_familygrp_cd) > 0 AND CHARINDEX('.', ifg.src_familygrp_cd) < LENGTH(ifg.src_familygrp_cd)
                    THEN CAST(TO_NUMBER(SUBSTRING(ifg.src_familygrp_cd, CHARINDEX('.', ifg.src_familygrp_cd) +1)) AS INTEGER)
               ELSE NULL
          END                                                                                                            AS family_cd
       , COALESCE(ifg.src_familygrp_id, ifg.item_fam_grp_sid)                                                            AS item_familygroup_id
       , CAST(TO_NUMBER(sig.src_subitemgrp_cd) AS INTEGER) subitemgroup_id /* Datentypangleichung */
        , ifg.src_familygrp_cd
       , CASE WHEN ifg.client_id =  1       AND ifg.lang_cd_default='DE' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_AT
       , CASE WHEN ifg.client_id =  2       AND ifg.lang_cd_default='FR' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_BE
       , CASE WHEN ifg.client_id =  2       AND ifg.lang_cd_default='FR' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_BE_FR
       , CASE WHEN ifg.client_id =  3       AND ifg.lang_cd_default='BG' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_BG
       , CASE WHEN ifg.client_id =  4       AND ifg.lang_cd_default='DE' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_CH
       , CASE WHEN ifg.client_id =  5       AND ifg.lang_cd_default='EL' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_CY
       , CASE WHEN ifg.client_id =  6       AND ifg.lang_cd_default='CS' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_CZ
       , ifg.item_family_desc_lidl                                                                                       AS item_family_desc
       , CASE WHEN ifg.client_id =  8       AND ifg.lang_cd_default='DA' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_DK
       , CASE WHEN ifg.client_id =  9       AND ifg.lang_cd_default='EE' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_EE
       , CASE WHEN ifg.client_id IN (10,31) AND ifg.lang_cd_default='ES' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_ES
       , CASE WHEN ifg.client_id = 11       AND ifg.lang_cd_default='FI' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_FI
       , CASE WHEN ifg.client_id = 12       AND ifg.lang_cd_default='FR' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_FR
       , CASE WHEN ifg.client_id = 13       AND ifg.lang_cd_default='EN' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_GB
       , CASE WHEN ifg.client_id IN (5,14)  AND ifg.lang_cd_default='EL' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_GR
       , CASE WHEN ifg.client_id = 15       AND ifg.lang_cd_default='HR' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_HR
       , CASE WHEN ifg.client_id = 16       AND ifg.lang_cd_default='HU' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_HU
       , CASE WHEN ifg.client_id IN (17,21) AND ifg.lang_cd_default='EN' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_IE
       , CASE WHEN ifg.client_id IN (18,32) AND ifg.lang_cd_default='IT' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_IT
       , CASE WHEN ifg.client_id = 19       AND ifg.lang_cd_default='LT' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_LT
       , CASE WHEN ifg.client_id = 20       AND ifg.lang_cd_default='LV' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_LV
       , CASE WHEN ifg.client_id = 21       AND ifg.lang_cd_default='EN' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_NI
       , CASE WHEN ifg.client_id = 22       AND ifg.lang_cd_default='NL' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_NL
       , CASE WHEN ifg.client_id = 23       AND ifg.lang_cd_default='DE' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_DE
       , CASE WHEN ifg.client_id = 24       AND ifg.lang_cd_default='PL' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_PL
       , CASE WHEN ifg.client_id = 25       AND ifg.lang_cd_default='PT' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_PT
       , CASE WHEN ifg.client_id = 26       AND ifg.lang_cd_default='RO' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_RO
       , CASE WHEN ifg.client_id = 27       AND ifg.lang_cd_default='SV' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_SE
       , CASE WHEN ifg.client_id = 28       AND ifg.lang_cd_default='SL' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_SI
       , CASE WHEN ifg.client_id = 29       AND ifg.lang_cd_default='SK' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_SK
       , CASE WHEN ifg.client_id = 31       AND ifg.lang_cd_default='ES' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_CS
       , CASE WHEN ifg.client_id = 32       AND ifg.lang_cd_default='IT' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_MT
       , CASE WHEN ifg.client_id = 33       AND ifg.lang_cd_default='EN' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_US
       , CASE WHEN ifg.client_id = 34       AND ifg.lang_cd_default='SH' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_desc_RS
       , CASE WHEN ifg.client_id =  1       AND ifg.lang_cd_default='DE' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_AT
       , CASE WHEN ifg.client_id =  2       AND ifg.lang_cd_default='FR' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_BE
       , CASE WHEN ifg.client_id =  2       AND ifg.lang_cd_default='FR' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_BE_FR
       , CASE WHEN ifg.client_id =  3       AND ifg.lang_cd_default='BG' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_BG
       , CASE WHEN ifg.client_id =  4       AND ifg.lang_cd_default='DE' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_CH
       , CASE WHEN ifg.client_id =  5       AND ifg.lang_cd_default='EL' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_CY
       , CASE WHEN ifg.client_id =  6       AND ifg.lang_cd_default='CS' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_CZ
       , ifg.item_family_desc_lidl                                                                                       AS item_family_short_desc
       , CASE WHEN ifg.client_id =  8       AND ifg.lang_cd_default='DA' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_DK
       , CASE WHEN ifg.client_id =  9       AND ifg.lang_cd_default='EE' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_EE
       , CASE WHEN ifg.client_id IN (10,31) AND ifg.lang_cd_default='ES' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_ES
       , CASE WHEN ifg.client_id = 11       AND ifg.lang_cd_default='FI' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_FI
       , CASE WHEN ifg.client_id = 12       AND ifg.lang_cd_default='FR' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_FR
       , CASE WHEN ifg.client_id = 13       AND ifg.lang_cd_default='EN' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_GB
       , CASE WHEN ifg.client_id IN (5,14)  AND ifg.lang_cd_default='EL' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_GR
       , CASE WHEN ifg.client_id = 15       AND ifg.lang_cd_default='HR' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_HR
       , CASE WHEN ifg.client_id = 16       AND ifg.lang_cd_default='HU' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_HU
       , CASE WHEN ifg.client_id = 17       AND ifg.lang_cd_default='EN' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_IE
       , CASE WHEN ifg.client_id IN (18,32) AND ifg.lang_cd_default='IT' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_IT
       , CASE WHEN ifg.client_id = 19       AND ifg.lang_cd_default='LT' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_LT
       , CASE WHEN ifg.client_id = 20       AND ifg.lang_cd_default='LV' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_LV
       , CASE WHEN ifg.client_id IN (17,21) AND ifg.lang_cd_default='EN' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_NI
       , CASE WHEN ifg.client_id = 22       AND ifg.lang_cd_default='NL' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_NL
       , CASE WHEN ifg.client_id = 23       AND ifg.lang_cd_default='DE' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_DE
       , CASE WHEN ifg.client_id = 24       AND ifg.lang_cd_default='PL' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_PL
       , CASE WHEN ifg.client_id = 25       AND ifg.lang_cd_default='PT' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_PT
       , CASE WHEN ifg.client_id = 26       AND ifg.lang_cd_default='RO' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_RO
       , CASE WHEN ifg.client_id = 27       AND ifg.lang_cd_default='SV' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_SE
       , CASE WHEN ifg.client_id = 28       AND ifg.lang_cd_default='SL' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_SI
       , CASE WHEN ifg.client_id = 29       AND ifg.lang_cd_default='SK' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_SK
       , CASE WHEN ifg.client_id IN (10,31) AND ifg.lang_cd_default='ES' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_CS
       , CASE WHEN ifg.client_id = 32       AND ifg.lang_cd_default='IT' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_MT
       , CASE WHEN ifg.client_id = 33       AND ifg.lang_cd_default='EN' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_US
       , CASE WHEN ifg.client_id = 34       AND ifg.lang_cd_default='SH' THEN ifg.item_family_desc_default ELSE NULL END AS item_family_short_desc_RS
  FROM P_LEW_BIL_AC.v_item_familygroup_2   AS ifg /* Basistabelle familygroups */
 INNER JOIN P_LEW_CORE_AC.v_subitemgroup_2 AS sig /* Basistabelle Unterwarengruppen */
    ON sig.sub_item_grp_sid = ifg.sub_item_grp_sid
QUALIFY ROW_NUMBER() OVER (PARTITION BY ifg.client_id, item_familygroup_id ORDER BY ifg.item_fam_grp_sid DESC NULLS LAST) = 1
;
