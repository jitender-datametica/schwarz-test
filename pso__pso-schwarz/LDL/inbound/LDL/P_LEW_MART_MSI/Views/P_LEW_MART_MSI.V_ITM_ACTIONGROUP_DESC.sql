CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_ACTIONGROUP_DESC COMMENT = 'Mulri language item action group descriptions'
/*
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            Release 1.1
#  1.2  17.01.2018    Wieber,Harald            Release 2.2
#  1.3  06.08.2020    Roy,Ritanjal             Introduce new country LV
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  21.12.2021    Morris, Michael          Added Estonia EE
#----------------------------------------------------------------------------
*/
(
  client_id                COMMENT 'Landeskennzeichen'
, item_actiongroup_id      COMMENT 'Referenziert auf C665_MAINGRPNR, in der WAWI auf VARCHAR 13, da zuerst geplant war, ACTIONGRP und AC'
, dat_valid_from           COMMENT 'Gültig ab, wird vom Vorsystem Wawi geliefert'
, dat_valid_until          COMMENT 'Gültig bis, wird vom Vorsystem Wawi geliefert'
, item_actgroup_desc_AT    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung AT'
, item_actgroup_desc_BE    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung BE'
, item_actgroup_desc_BE_FR COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung BE_FR'
, item_actgroup_desc_BG    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung BG'
, item_actgroup_desc_CH    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung CH'
, item_actgroup_desc_CY    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung CY'
, item_actgroup_desc_CZ    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung CZ'
, item_actgroup_desc       COMMENT 'Artikel - Aktionsgruppe Beschreibung'
, item_actgroup_desc_DK    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung DK'
, item_actgroup_desc_EE    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung EE'
, item_actgroup_desc_ES    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung ES'
, item_actgroup_desc_FI    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung FI'
, item_actgroup_desc_FR    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung FR'
, item_actgroup_desc_GB    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung GB'
, item_actgroup_desc_GR    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung GR'
, item_actgroup_desc_HR    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung HR'
, item_actgroup_desc_HU    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung HU'
, item_actgroup_desc_IE    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung IE'
, item_actgroup_desc_IT    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung IT'
, item_actgroup_desc_LT    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung LT'
, item_actgroup_desc_LV    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung LV'
, item_actgroup_desc_NI    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung NI'
, item_actgroup_desc_NL    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung NL'
, item_actgroup_desc_DE    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung DE'
, item_actgroup_desc_PL    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung PL'
, item_actgroup_desc_PT    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung PT'
, item_actgroup_desc_RO    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung RO'
, item_actgroup_desc_SE    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung SE'
, item_actgroup_desc_SI    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung SI'
, item_actgroup_desc_SK    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung SK'
, item_actgroup_desc_CS    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung CS'
, item_actgroup_desc_MT    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung MT'
, item_actgroup_desc_US    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung US'
, item_actgroup_desc_RS    COMMENT 'Artikel - Aktionsgruppe Landesspezifische Bezeichnung RS'
)
AS
SELECT   client_id
       , item_actiongroup_id
       , MIN(dat_valid_from) AS dat_valid_from
       , MAX(dat_valid_until) AS dat_valid_until
       , MAX(CASE WHEN language_id = 1  THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_AT
       , MAX(CASE WHEN language_id = 2  THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_BE
       , MAX(CASE WHEN language_id = 12 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_BE_FR
       , MAX(CASE WHEN language_id = 3  THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_BG
       , MAX(CASE WHEN language_id = 4  THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_CH
       , MAX(CASE WHEN language_id = 5  THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_CY
       , MAX(CASE WHEN language_id = 6  THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_CZ
       , MAX(CASE WHEN language_id = 7  THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc
       , MAX(CASE WHEN language_id = 8  THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_DK
       , MAX(CASE WHEN language_id = 9  THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_EE
       , MAX(CASE WHEN language_id = 10 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_ES
       , MAX(CASE WHEN language_id = 11 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_FI
       , MAX(CASE WHEN language_id = 12 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_FR
       , MAX(CASE WHEN language_id = 13 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_GB
       , MAX(CASE WHEN language_id = 14 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_GR
       , MAX(CASE WHEN language_id = 15 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_HR
       , MAX(CASE WHEN language_id = 16 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_HU
       , MAX(CASE WHEN language_id = 17 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_IE
       , MAX(CASE WHEN language_id = 18 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_IT
       , MAX(CASE WHEN language_id = 19 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_LT
       , MAX(CASE WHEN language_id = 20 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_LV
       , MAX(CASE WHEN language_id = 21 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_NI
       , MAX(CASE WHEN language_id = 22 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_NL
       , MAX(CASE WHEN language_id = 23 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_DE
       , MAX(CASE WHEN language_id = 24 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_PL
       , MAX(CASE WHEN language_id = 25 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_PT
       , MAX(CASE WHEN language_id = 26 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_RO
       , MAX(CASE WHEN language_id = 27 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_SE
       , MAX(CASE WHEN language_id = 28 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_SI
       , MAX(CASE WHEN language_id = 29 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_SK
       , MAX(CASE WHEN language_id = 31 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_CS
       , MAX(CASE WHEN language_id = 32 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_MT
       , MAX(CASE WHEN language_id = 33 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_US
       , MAX(CASE WHEN language_id = 34 THEN item_actgroup_desc ELSE NULL END ) AS item_actgroup_desc_RS

  FROM P_LEW_CORE_AC.v_wawi_itm_actiongroup_desc

 WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end

 GROUP BY   client_id
          , item_actiongroup_id
;