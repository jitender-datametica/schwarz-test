CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_COUNTRY_LEAD COMMENT = 'Lead project - Country lead reference view'
/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-03-12 Barbara Seneta         Initial version
#  1.1 07.08.2020 Roy,Ritanjal           Introduce new country Latviya
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
, country_desc_AT       COMMENT 'Filial-Land Landesspezifische Bezeichnung AT'
, country_desc_BE       COMMENT 'Filial-Land Landesspezifische Bezeichnung BE'
, country_desc_BG       COMMENT 'Filial-Land Landesspezifische Bezeichnung BG'
, country_desc_CH       COMMENT 'Filial-Land Landesspezifische Bezeichnung CH'
, country_desc_CY       COMMENT 'Filial-Land Landesspezifische Bezeichnung CY'
, country_desc_CZ       COMMENT 'Filial-Land Landesspezifische Bezeichnung CZ'
, country_desc          COMMENT 'Filial-Land Bezeichnung'
, country_desc_DK       COMMENT 'Filial-Land Landesspezifische Bezeichnung DK'
, country_desc_EE       COMMENT 'Filial-Land Landesspezifische Bezeichnung EE'
, country_desc_ES       COMMENT 'Filial-Land Landesspezifische Bezeichnung ES'
, country_desc_FI       COMMENT 'Filial-Land Landesspezifische Bezeichnung FI'
, country_desc_FR       COMMENT 'Filial-Land Landesspezifische Bezeichnung FR'
, country_desc_GB       COMMENT 'Filial-Land Landesspezifische Bezeichnung GB'
, country_desc_GR       COMMENT 'Filial-Land Landesspezifische Bezeichnung GR'
, country_desc_HR       COMMENT 'Filial-Land Landesspezifische Bezeichnung HR'
, country_desc_HU       COMMENT 'Filial-Land Landesspezifische Bezeichnung HU'
, country_desc_IE       COMMENT 'Filial-Land Landesspezifische Bezeichnung IE'
, country_desc_IT       COMMENT 'Filial-Land Landesspezifische Bezeichnung IT'
, country_desc_LT       COMMENT 'Filial-Land Landesspezifische Bezeichnung LT'
, country_desc_LV       COMMENT 'Filial-Land Landesspezifische Bezeichnung LV'
, country_desc_NI       COMMENT 'Filial-Land Landesspezifische Bezeichnung NI'
, country_desc_NL       COMMENT 'Filial-Land Landesspezifische Bezeichnung NL'
, country_desc_DE       COMMENT 'Filial-Land Landesspezifische Bezeichnung DE'
, country_desc_PL       COMMENT 'Filial-Land Landesspezifische Bezeichnung PL'
, country_desc_PT       COMMENT 'Filial-Land Landesspezifische Bezeichnung PT'
, country_desc_RO       COMMENT 'Filial-Land Landesspezifische Bezeichnung RO'
, country_desc_SE       COMMENT 'Filial-Land Landesspezifische Bezeichnung SE'
, country_desc_SI       COMMENT 'Filial-Land Landesspezifische Bezeichnung SI'
, country_desc_SK       COMMENT 'Filial-Land Landesspezifische Bezeichnung SK'
, country_desc_CS       COMMENT 'Filial-Land Landesspezifische Bezeichnung CS'
, country_desc_MT       COMMENT 'Filial-Land Landesspezifische Bezeichnung MT'
, country_desc_US       COMMENT 'Filial-Land Landesspezifische Bezeichnung US'
, country_desc_RS       COMMENT 'Filial-Land Landesspezifische Bezeichnung RS'
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
  FROM P_LEW_MART_LEAD.v_ref_country_lead
;


