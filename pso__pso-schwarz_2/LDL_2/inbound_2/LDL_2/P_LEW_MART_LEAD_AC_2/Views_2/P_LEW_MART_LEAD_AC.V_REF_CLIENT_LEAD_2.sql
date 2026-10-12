CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_CLIENT_LEAD_2 COMMENT = 'Lead project - Client lead reference view'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  2018-01-29      Deepak Kumar Purseth   Initial version - DDL for Abshiften
#                                              20180328_1631_QuickView_BR_Client_View
#  1.1  04.01.2022      Michael Morris         Added Estonia EE
#  1.2  23.08.2024      Malec, Marcin          Added column vs_sort, with an additional country_2 sorting logic; User Story 665161
#----------------------------------------------------------------------------
*/
(
  int_id                COMMENT 'Lidl International ID'
, client_id             COMMENT 'Mandant_2'
, country_iso_cd        COMMENT 'Landeskürzel'
, country_group_id      COMMENT 'Landesgruppen Kennzeichen'
, lisy_sort             COMMENT 'lisy sort'
, vs_sort               COMMENT 'VS_2 sort'
, dashboard_relevant_fg COMMENT 'Dashboardrelevant'
, country_desc_AT       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung AT'
, country_desc_BE       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung BE'
, country_desc_BG       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung BG'
, country_desc_CH       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung CH'
, country_desc_CY       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung CY'
, country_desc_CZ       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung CZ'
, country_desc          COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung'
, country_desc_DK       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung DK'
, country_desc_EE       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung EE'
, country_desc_ES       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung ES'
, country_desc_FI       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung FI'
, country_desc_FR       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung FR'
, country_desc_GB       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung GB'
, country_desc_GR       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung GR'
, country_desc_HR       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung HR'
, country_desc_HU       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung HU'
, country_desc_IE       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung IE'
, country_desc_IT       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung IT'
, country_desc_LT       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung LT'
, country_desc_LV       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung LV'
, country_desc_NI       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung NI'
, country_desc_NL       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung NL'
, country_desc_DE       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung DE'
, country_desc_PL       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung PL'
, country_desc_PT       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung PT'
, country_desc_RO       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung RO'
, country_desc_SE       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung SE'
, country_desc_SI       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung SI'
, country_desc_SK       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung SK'
, country_desc_CS       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung CS'
, country_desc_MT       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung MT'
, country_desc_US       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung US'
, country_desc_RS       COMMENT 'Filial-Land_2 Landesspezifische Bezeichnung RS_2'
, country_opening_date  COMMENT 'Eröffnungsdatum Land_2'
)
AS
SELECT   int_id
       , client_id
       , country_iso_cd
       , country_group_id
       , lisy_sort
       , vs_sort
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
       , country_opening_date
  FROM P_LEW_MART_LEAD.v_ref_client_lead_2
;