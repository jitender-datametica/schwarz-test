CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_REF_CLIENT_LEAD_BASE COMMENT = 'Lead project - Client lead base reference view'
/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- ----------------------------------
#  1.0 2020-03-12 Barbara Seneta         Initial version
#  1.1 08.06.2020 Roy,Ritanjal           Introduce new country latviya
#  1.2 03.01.2022 Morris, Michael        Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  int_id                 COMMENT 'Lidl International ID'
, client_id              COMMENT 'Mandant'
, country_iso_cd         COMMENT 'Landeskürzel'
, country_group_id       COMMENT 'Landesgruppen Kennzeichen'
, lisy_sort              COMMENT 'lisy sort'
, dashboard_relevant_fg  COMMENT 'Dashboardrelevant'
, country_desc_AT        COMMENT 'Filial-Land Landesspezifische Bezeichnung AT'
, country_desc_BE        COMMENT 'Filial-Land Landesspezifische Bezeichnung BE'
, country_desc_BG        COMMENT 'Filial-Land Landesspezifische Bezeichnung BG'
, country_desc_CH        COMMENT 'Filial-Land Landesspezifische Bezeichnung CH'
, country_desc_CY        COMMENT 'Filial-Land Landesspezifische Bezeichnung CY'
, country_desc_CZ        COMMENT 'Filial-Land Landesspezifische Bezeichnung CZ'
, country_desc           COMMENT 'Filial-Land Landesspezifische Bezeichnung'
, country_desc_DK        COMMENT 'Filial-Land Landesspezifische Bezeichnung DK'
, country_desc_EE        COMMENT 'Filial-Land Landesspezifische Bezeichnung EE'
, country_desc_ES        COMMENT 'Filial-Land Landesspezifische Bezeichnung ES'
, country_desc_FI        COMMENT 'Filial-Land Landesspezifische Bezeichnung FI'
, country_desc_FR        COMMENT 'Filial-Land Landesspezifische Bezeichnung FR'
, country_desc_GB        COMMENT 'Filial-Land Landesspezifische Bezeichnung GB'
, country_desc_GR        COMMENT 'Filial-Land Landesspezifische Bezeichnung GR'
, country_desc_HR        COMMENT 'Filial-Land Landesspezifische Bezeichnung HR'
, country_desc_HU        COMMENT 'Filial-Land Landesspezifische Bezeichnung HU'
, country_desc_IE        COMMENT 'Filial-Land Landesspezifische Bezeichnung IE'
, country_desc_IT        COMMENT 'Filial-Land Landesspezifische Bezeichnung IT'
, country_desc_LT        COMMENT 'Filial-Land Landesspezifische Bezeichnung LT'
, country_desc_LV        COMMENT 'Filial-Land Landesspezifische Bezeichnung LV'
, country_desc_NI        COMMENT 'Filial-Land Landesspezifische Bezeichnung NI'
, country_desc_NL        COMMENT 'Filial-Land Landesspezifische Bezeichnung NL'
, country_desc_DE        COMMENT 'Filial-Land Landesspezifische Bezeichnung DE'
, country_desc_PL        COMMENT 'Filial-Land Landesspezifische Bezeichnung PL'
, country_desc_PT        COMMENT 'Filial-Land Landesspezifische Bezeichnung PT'
, country_desc_RO        COMMENT 'Filial-Land Landesspezifische Bezeichnung RO'
, country_desc_SE        COMMENT 'Filial-Land Landesspezifische Bezeichnung SE'
, country_desc_SI        COMMENT 'Filial-Land Landesspezifische Bezeichnung SI'
, country_desc_SK        COMMENT 'Filial-Land Landesspezifische Bezeichnung SK'
, country_desc_CS        COMMENT 'Filial-Land Landesspezifische Bezeichnung CS'
, country_desc_MT        COMMENT 'Filial-Land Landesspezifische Bezeichnung MT'
, country_desc_US        COMMENT 'Filial-Land Landesspezifische Bezeichnung US'
, country_desc_RS        COMMENT 'Filial-Land Landesspezifische Bezeichnung RS'
, country_opening_date   COMMENT 'Eröffnungsdatum Land'
)
AS
SELECT   int_id
       , country_id AS client_id  /* Referenzierung des Landes */
       , country_iso_cd           /* Country ISO_Code, Landeskürzel */
       , country_group_id         /* techn. DWH- Schlüssel zur Referenzierung der Vorstandsregion */
       , lisy_sort                /* Sortierung aus dem Vorsystem Lisy */
       , dashboard_relevant_fg    /* Für Lead Dashboard relevant */
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
       , CASE client_id WHEN 23 THEN '1973'
                        WHEN 12 THEN '04/1989'
                        WHEN 18 THEN '03/1992'
                        WHEN 10 THEN '04/1994'
                        WHEN 13 THEN '11/1994'
                        WHEN  2 THEN '04/1995'
                        WHEN 25 THEN '07/1995'
                        WHEN 22 THEN '10/1997'
                        WHEN  1 THEN '11/1998'
                        WHEN 21 THEN '05/1999'
                        WHEN 14 THEN '06/1999'
                        WHEN 17 THEN '07/2000'
                        WHEN 24 THEN '04/2002'
                        WHEN 11 THEN '08/2002'
                        WHEN  6 THEN '06/2003'
                        WHEN 27 THEN '09/2003'
                        WHEN 29 THEN '09/2004'
                        WHEN 16 THEN '11/2004'
                        WHEN  8 THEN '09/2005'
                        WHEN 15 THEN '11/2006'
                        WHEN 28 THEN '03/2007'
                        WHEN 32 THEN '04/2008'
                        WHEN  4 THEN '03/2009'
                        WHEN 31 THEN '02/2010'
                        WHEN 26 THEN '01/2010'
                        WHEN  3 THEN '01/2010'
                        WHEN  5 THEN '11/2010'
                        WHEN 19 THEN '03/2016'
                        WHEN 33 THEN '01/2017'
                        WHEN 34 THEN '03/2018'
                        WHEN 20 THEN '01/2020'
                        WHEN  9 THEN '03/2022'
                        ELSE '01/1900'
          END AS country_opening_date
  FROM P_LEW_MART_LEAD.v_ref_country_lead
;