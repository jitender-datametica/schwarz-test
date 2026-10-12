CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_REF_GL_REGION_MERGE_1 COMMENT = 'Multi language Region_1/Land_1 reference'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2018    Khusainov, Timur            Initiliazation
#  1.1  17.11.2020    Meme, Yasin                 Add LV DWHA-248 Patch 2665
#  1.2  27.11.2020    Morris, Michael             Add Column(s) for _BE_fr
#                                                 20200824_2572_trans_NR_FR_corr
#                                                 https://jira.schwarz/browse/REP4-7173
#  1.3  27.12.2021    Zied Nanaa                  Add languages BE_FR and EE
#-----------------------------------------------------------------------------
*/
(
  client_id             COMMENT 'Land_1/Client ID'
, gl_region_id          COMMENT 'Region_1 ID'
, gl_region_desc        COMMENT 'Regional Manager Vollname'
, gl_last_name          COMMENT 'Regional Manager Familienname'
, gl_first_name         COMMENT 'Regional Manager Vorname'
, aspect_id             COMMENT 'BGES (1)/VGES (2) ID'
, int_id                COMMENT 'Lidl International ID'
, country_iso_cd        COMMENT 'Landeskennzeichen'
, country_group_id      COMMENT 'Landes ISO Code'
, lisy_sort             COMMENT 'Lisy Sort Wert'
, dashboard_relevant_fg COMMENT 'Dashboeard relevant Flag'
, country_desc_AT       COMMENT 'Landesspezifische Bezeichnung des Landes AT'
, country_desc_BE       COMMENT 'Landesspezifische Bezeichnung des Landes BE'
, country_desc_BE_FR    COMMENT 'Landesspezifische Bezeichnung des Landes BE_FR'
, country_desc_BG       COMMENT 'Landesspezifische Bezeichnung des Landes BG'
, country_desc_CH       COMMENT 'Landesspezifische Bezeichnung des Landes CH'
, country_desc_CY       COMMENT 'Landesspezifische Bezeichnung des Landes CY'
, country_desc_CZ       COMMENT 'Landesspezifische Bezeichnung des Landes CZ'
, country_desc          COMMENT 'Bezeichnung des Landes'
, country_desc_DK       COMMENT 'Landesspezifische Bezeichnung des Landes DK'
, country_desc_EE       COMMENT 'Landesspezifische Bezeichnung des Landes EE'
, country_desc_ES       COMMENT 'Landesspezifische Bezeichnung des Landes ES'
, country_desc_FI       COMMENT 'Landesspezifische Bezeichnung des Landes FI'
, country_desc_FR       COMMENT 'Landesspezifische Bezeichnung des Landes FR'
, country_desc_GB       COMMENT 'Landesspezifische Bezeichnung des Landes GB'
, country_desc_GR       COMMENT 'Landesspezifische Bezeichnung des Landes GR'
, country_desc_HR       COMMENT 'Landesspezifische Bezeichnung des Landes HR'
, country_desc_HU       COMMENT 'Landesspezifische Bezeichnung des Landes HU'
, country_desc_IE       COMMENT 'Landesspezifische Bezeichnung des Landes IE'
, country_desc_IT       COMMENT 'Landesspezifische Bezeichnung des Landes IT'
, country_desc_LT       COMMENT 'Landesspezifische Bezeichnung des Landes LT'
, country_desc_LV       COMMENT 'Landesspezifische Bezeichnung des Landes LV'
, country_desc_NI       COMMENT 'Landesspezifische Bezeichnung des Landes NI'
, country_desc_NL       COMMENT 'Landesspezifische Bezeichnung des Landes NL'
, country_desc_DE       COMMENT 'Landesspezifische Bezeichnung des Landes DE'
, country_desc_PL       COMMENT 'Landesspezifische Bezeichnung des Landes PL'
, country_desc_PT       COMMENT 'Landesspezifische Bezeichnung des Landes PT'
, country_desc_RO       COMMENT 'Landesspezifische Bezeichnung des Landes RO'
, country_desc_SE       COMMENT 'Landesspezifische Bezeichnung des Landes SE'
, country_desc_SI       COMMENT 'Landesspezifische Bezeichnung des Landes SI'
, country_desc_SK       COMMENT 'Landesspezifische Bezeichnung des Landes SK'
, country_desc_CS       COMMENT 'Landesspezifische Bezeichnung des Landes CS'
, country_desc_MT       COMMENT 'Landesspezifische Bezeichnung des Landes MT'
, country_desc_US       COMMENT 'Landesspezifische Bezeichnung des Landes US'
, country_desc_RS       COMMENT 'Landesspezifische Bezeichnung des Landes RS_1'
, country_opening_date  COMMENT 'Landes Eröffnungsdatum'
)
AS
SELECT   client_id
       , gl_region_id
       , gl_region_desc
       , gl_last_name
       , gl_first_name
       , aspect_id
       , int_id
       , country_iso_cd
       , country_group_id
       , lisy_sort
       , dashboard_relevant_fg
       , country_desc_AT
       , country_desc_BE
       , country_desc_BE_FR
       , country_desc_BG
       , country_desc_CH
       , country_desc_CY
       , country_desc_CZ
       , country_desc
       , country_desc_DK
       , country_desc_EE
       , country_desc_ES
       , country_desc_FI
       , country_desc_FR
       , country_desc_GB
       , country_desc_GR
       , country_desc_HR
       , country_desc_HU
       , country_desc_IE
       , country_desc_IT
       , country_desc_LT
       , country_desc_LV
       , country_desc_NI
       , country_desc_NL
       , country_desc_DE
       , country_desc_PL
       , country_desc_PT
       , country_desc_RO
       , country_desc_SE
       , country_desc_SI
       , country_desc_SK
       , country_desc_CS
       , country_desc_MT
       , country_desc_US
       , country_desc_RS
       , country_opening_date
  FROM P_LEW_MART_MSI.v_ref_gl_region_merge_1
;