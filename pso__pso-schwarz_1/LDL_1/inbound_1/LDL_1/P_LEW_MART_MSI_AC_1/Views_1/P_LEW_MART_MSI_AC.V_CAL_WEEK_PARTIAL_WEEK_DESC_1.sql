CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CAL_WEEK_PARTIAL_WEEK_DESC_1 COMMENT = 'Multi language Parztial Week decsriptions'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  15.11.2017    Wieber.Harald            Release 1.1
#  1.1  21.11.2017    Wieber.Harald            Remove SVN File Editor Issues
#  1.2  07.12.2017    Wieber.Harald            Update Release 2.0 - Patch 1512
#  1.3  21.12.2017    Wieber.Harald            Update Release 2.1
#  1.4  17.01.2018    Wieber.Harald            Release 2.2
#  1.5  22.02.2018    Wieber.Harald            Update Release 2.3.4
#  1.6  01.03.2018    Wieber.Harald            Update to Release 3.0
#  1.7  03.04.2018    Wieber.Harald            Update 03.04.2018
#  1.8  03.05.2018    Wieber.Harald            Release 3.6
#  1.9  17.05.2018    Wieber,Harald            Update Release 3.8
#  1.10 27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              Patch: 20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.12 28.12.2021    Zied Nanaa               Add languages BE_FR and EE
#-----------------------------------------------------------------------------
*/
(
    cy_week_partial_week_id1          COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Id - Zusammenfesetzte ID aus Jahr/KW'
  , cy_week_partial_week_id2          COMMENT 'Geschäftsjahr - Woche_1/Teilwoche - Wochenart Id- 1 = erster Teil - 2 = zweiter Teil - 9 = ganze Woche_1'
  , cy_week_partial_week_id           COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Id - Zusammenfesetzte ID aus Jahr/KW/Wochenart - 1 = erster Teil - 2 = zweiter Teil - 9 = ganze Woche_1'
  , cy_week_partial_week_desc_AT      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung AT'
  , cy_week_partial_week_desc_BE      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE'
  , cy_week_partial_week_desc_BE_FR   COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE_FR'
  , cy_week_partial_week_desc_BG      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BG'
  , cy_week_partial_week_desc_CH      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CH'
  , cy_week_partial_week_desc_CY      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CY'
  , cy_week_partial_week_desc_CZ      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CZ'
  , cy_week_partial_week_desc         COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Bezeichnung'
  , cy_week_partial_week_desc_DK      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DK'
  , cy_week_partial_week_desc_EE      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung EE'
  , cy_week_partial_week_desc_ES      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung ES'
  , cy_week_partial_week_desc_FI      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FI'
  , cy_week_partial_week_desc_FR      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FR'
  , cy_week_partial_week_desc_GB      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GB'
  , cy_week_partial_week_desc_GR      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GR'
  , cy_week_partial_week_desc_HR      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HR'
  , cy_week_partial_week_desc_HU      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HU'
  , cy_week_partial_week_desc_IE      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IE'
  , cy_week_partial_week_desc_IT      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IT'
  , cy_week_partial_week_desc_LT      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LT'
  , cy_week_partial_week_desc_LV      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LV'
  , cy_week_partial_week_desc_NI      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NI'
  , cy_week_partial_week_desc_NL      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NL'
  , cy_week_partial_week_desc_DE      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DE'
  , cy_week_partial_week_desc_PL      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PL'
  , cy_week_partial_week_desc_PT      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PT'
  , cy_week_partial_week_desc_RO      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RO'
  , cy_week_partial_week_desc_SE      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SE'
  , cy_week_partial_week_desc_SI      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SI'
  , cy_week_partial_week_desc_SK      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SK'
  , cy_week_partial_week_desc_CS      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CS'
  , cy_week_partial_week_desc_MT      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung MT'
  , cy_week_partial_week_desc_US      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung US'
  , cy_week_partial_week_desc_RS      COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RS_1'
  , cy_week_partial_week_desc_s_AT    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung AT kurz'
  , cy_week_partial_week_desc_s_BE    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE kurz'
  , cy_week_partial_week_desc_s_BE_FR COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BE_FR kurz'
  , cy_week_partial_week_desc_s_BG    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung BG kurz'
  , cy_week_partial_week_desc_s_CH    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CH kurz'
  , cy_week_partial_week_desc_s_CY    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CY kurz'
  , cy_week_partial_week_desc_s_CZ    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CZ kurz'
  , cy_week_partial_week_desc_s       COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Kurzbezeichnung'
  , cy_week_partial_week_desc_s_DK    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DK kurz'
  , cy_week_partial_week_desc_s_EE    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung EE kurz'
  , cy_week_partial_week_desc_s_ES    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung ES kurz'
  , cy_week_partial_week_desc_s_FI    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FI kurz'
  , cy_week_partial_week_desc_s_FR    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung FR kurz'
  , cy_week_partial_week_desc_s_GB    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GB kurz'
  , cy_week_partial_week_desc_s_GR    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung GR kurz'
  , cy_week_partial_week_desc_s_HR    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HR kurz'
  , cy_week_partial_week_desc_s_HU    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung HU kurz'
  , cy_week_partial_week_desc_s_IE    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IE kurz'
  , cy_week_partial_week_desc_s_IT    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung IT kurz'
  , cy_week_partial_week_desc_s_LT    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LT kurz'
  , cy_week_partial_week_desc_s_LV    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung LV kurz'
  , cy_week_partial_week_desc_s_NI    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NI kurz'
  , cy_week_partial_week_desc_s_NL    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung NL kurz'
  , cy_week_partial_week_desc_s_DE    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung DE kurz'
  , cy_week_partial_week_desc_s_PL    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PL kurz'
  , cy_week_partial_week_desc_s_PT    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung PT kurz'
  , cy_week_partial_week_desc_s_RO    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RO kurz'
  , cy_week_partial_week_desc_s_SE    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SE kurz'
  , cy_week_partial_week_desc_s_SI    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SI kurz'
  , cy_week_partial_week_desc_s_SK    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung SK kurz'
  , cy_week_partial_week_desc_s_CS    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung CS kurz'
  , cy_week_partial_week_desc_s_MT    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung MT kurz'
  , cy_week_partial_week_desc_s_US    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung US kurz'
  , cy_week_partial_week_desc_s_RS    COMMENT 'Geschäftsjahr - Woche_1/Teilwoche Landesspezifische Bezeichnung RS_1 kurz'
  , desc_wo_year                      COMMENT 'Default Teilwoche Bezeichnung ohne Geschäftsjahr'
) 
AS
SELECT  cy_week_partial_week_id1
      , cy_week_partial_week_id2
      , cy_week_partial_week_id
      , cy_week_partial_week_desc_AT
      , cy_week_partial_week_desc_BE
      , cy_week_partial_week_desc_BE_FR
      , cy_week_partial_week_desc_BG
      , cy_week_partial_week_desc_CH
      , cy_week_partial_week_desc_CY
      , cy_week_partial_week_desc_CZ
      , cy_week_partial_week_desc
      , cy_week_partial_week_desc_DK
      , cy_week_partial_week_desc_EE
      , cy_week_partial_week_desc_ES
      , cy_week_partial_week_desc_FI
      , cy_week_partial_week_desc_FR
      , cy_week_partial_week_desc_GB
      , cy_week_partial_week_desc_GR
      , cy_week_partial_week_desc_HR
      , cy_week_partial_week_desc_HU
      , cy_week_partial_week_desc_IE
      , cy_week_partial_week_desc_IT
      , cy_week_partial_week_desc_LT
      , cy_week_partial_week_desc_LV
      , cy_week_partial_week_desc_NI
      , cy_week_partial_week_desc_NL
      , cy_week_partial_week_desc_DE
      , cy_week_partial_week_desc_PL
      , cy_week_partial_week_desc_PT
      , cy_week_partial_week_desc_RO
      , cy_week_partial_week_desc_SE
      , cy_week_partial_week_desc_SI
      , cy_week_partial_week_desc_SK
      , cy_week_partial_week_desc_CS
      , cy_week_partial_week_desc_MT
      , cy_week_partial_week_desc_US
      , cy_week_partial_week_desc_RS
      , cy_week_partial_week_desc_s_AT
      , cy_week_partial_week_desc_s_BE
      , cy_week_partial_week_desc_s_BE_FR
      , cy_week_partial_week_desc_s_BG
      , cy_week_partial_week_desc_s_CH
      , cy_week_partial_week_desc_s_CY
      , cy_week_partial_week_desc_s_CZ
      , cy_week_partial_week_desc_s
      , cy_week_partial_week_desc_s_DK
      , cy_week_partial_week_desc_s_EE
      , cy_week_partial_week_desc_s_ES
      , cy_week_partial_week_desc_s_FI
      , cy_week_partial_week_desc_s_FR
      , cy_week_partial_week_desc_s_GB
      , cy_week_partial_week_desc_s_GR
      , cy_week_partial_week_desc_s_HR
      , cy_week_partial_week_desc_s_HU
      , cy_week_partial_week_desc_s_IE
      , cy_week_partial_week_desc_s_IT
      , cy_week_partial_week_desc_s_LT
      , cy_week_partial_week_desc_s_LV
      , cy_week_partial_week_desc_s_NI
      , cy_week_partial_week_desc_s_NL
      , cy_week_partial_week_desc_s_DE
      , cy_week_partial_week_desc_s_PL
      , cy_week_partial_week_desc_s_PT
      , cy_week_partial_week_desc_s_RO
      , cy_week_partial_week_desc_s_SE
      , cy_week_partial_week_desc_s_SI
      , cy_week_partial_week_desc_s_SK
      , cy_week_partial_week_desc_s_CS
      , cy_week_partial_week_desc_s_MT
      , cy_week_partial_week_desc_s_US
      , cy_week_partial_week_desc_s_RS
      , desc_wo_year
FROM    P_LEW_MART_MSI.v_cal_week_partial_week_desc_1
;