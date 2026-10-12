CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_COUNTRY_LEAD_1 COMMENT = 'Lead project - Country_1 lead reference view'
/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-03-12 Barbara Seneta         Initial version
#  1.1 07.08.2020 Roy,Ritanjal           Introduce new country_1 Latviya
#  1.2 04.01.2022 Michael Morris         Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  int_id                COMMENT 'Lidl International ID'
, country_id            COMMENT 'Landeskennzeichen'
, country_iso_cd        COMMENT 'Landeskürzel'
, country_group_id      COMMENT 'Landesgruppen Kennzeichen'
, lisy_sort             COMMENT 'Lisy sort Wert'
, dashboard_relevant_fg COMMENT 'Dashboardrelevant'
, country_desc_AT       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung AT'
, country_desc_BE       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung BE'
, country_desc_BG       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung BG'
, country_desc_CH       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung CH'
, country_desc_CY       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung CY'
, country_desc_CZ       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung CZ'
, country_desc          COMMENT 'Filial-Land_1 Bezeichnung'
, country_desc_DK       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung DK'
, country_desc_EE       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung EE'
, country_desc_ES       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung ES'
, country_desc_FI       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung FI'
, country_desc_FR       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung FR'
, country_desc_GB       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung GB'
, country_desc_GR       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung GR'
, country_desc_HR       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung HR'
, country_desc_HU       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung HU'
, country_desc_IE       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung IE'
, country_desc_IT       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung IT'
, country_desc_LT       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung LT'
, country_desc_LV       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung LV'
, country_desc_NI       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung NI'
, country_desc_NL       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung NL'
, country_desc_DE       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung DE'
, country_desc_PL       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung PL'
, country_desc_PT       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung PT'
, country_desc_RO       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung RO'
, country_desc_SE       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung SE'
, country_desc_SI       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung SI'
, country_desc_SK       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung SK'
, country_desc_CS       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung CS'
, country_desc_MT       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung MT'
, country_desc_US       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung US'
, country_desc_RS       COMMENT 'Filial-Land_1 Landesspezifische Bezeichnung RS_1'
)
AS
SELECT   int_id
       , country_id
       , country_iso_cd
       , country_group_id
       , lisy_sort
       , dashboard_relevant_fg
       , country_desc_AT
       , country_desc_BE
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
  FROM P_LEW_MART_LEAD.v_ref_country_lead_1
;


