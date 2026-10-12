CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CAL_DAY_OF_WEEK_DESC_1 COMMENT = 'Multi language day of week descriptions'
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
#  1.9  17.05.2018    Wieber.Harald            Update Release 3.8
# 1.10  16.01.2019    Mike Davis               Slight reformat + comments.
# 1.11  19.11.2019    Meister,Ulrich           Patch 20191118_2292_Persistierung_Kalender_DWH20 (IDMO-2460, DWH-4137)
# 1.12  07.08.2020    Roy,Ritanjal             Introduce new country_1 Latviya
# 1.13  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
# 1.14  22.12.2021    Zied Nanaa               Add language Estonia EE
#----------------------------------------------------------------------------
*/
(
      day_of_week                  COMMENT 'Wochentag'
    , day_of_week_desc_AT          COMMENT 'Wochentag Landesspezifische Bezeichnung AT'
    , day_of_week_desc_BE          COMMENT 'Wochentag Landesspezifische Bezeichnung BE'
    , day_of_week_desc_BE_FR       COMMENT 'Wochentag Landesspezifische Bezeichnung BE_FR'
    , day_of_week_desc_BG          COMMENT 'Wochentag Landesspezifische Bezeichnung BG'
    , day_of_week_desc_CH          COMMENT 'Wochentag Landesspezifische Bezeichnung CH'
    , day_of_week_desc_CY          COMMENT 'Wochentag Landesspezifische Bezeichnung CY'
    , day_of_week_desc_CZ          COMMENT 'Wochentag Landesspezifische Bezeichnung CZ'
    , day_of_week_desc             COMMENT 'Wochentag Bezeichnung'
    , day_of_week_desc_DK          COMMENT 'Wochentag Landesspezifische Bezeichnung DK'
    , day_of_week_desc_EE          COMMENT 'Wochentag Landesspezifische Bezeichnung EE'
    , day_of_week_desc_ES          COMMENT 'Wochentag Landesspezifische Bezeichnung ES'
    , day_of_week_desc_FI          COMMENT 'Wochentag Landesspezifische Bezeichnung FI'
    , day_of_week_desc_FR          COMMENT 'Wochentag Landesspezifische Bezeichnung FR'
    , day_of_week_desc_GB          COMMENT 'Wochentag Landesspezifische Bezeichnung GB'
    , day_of_week_desc_GR          COMMENT 'Wochentag Landesspezifische Bezeichnung GR'
    , day_of_week_desc_HR          COMMENT 'Wochentag Landesspezifische Bezeichnung HR'
    , day_of_week_desc_HU          COMMENT 'Wochentag Landesspezifische Bezeichnung HU'
    , day_of_week_desc_IE          COMMENT 'Wochentag Landesspezifische Bezeichnung IE'
    , day_of_week_desc_IT          COMMENT 'Wochentag Landesspezifische Bezeichnung IT'
    , day_of_week_desc_LT          COMMENT 'Wochentag Landesspezifische Bezeichnung LT'
    , day_of_week_desc_LV          COMMENT 'Wochentag Landesspezifische Bezeichnung LV'
    , day_of_week_desc_NI          COMMENT 'Wochentag Landesspezifische Bezeichnung NI'
    , day_of_week_desc_NL          COMMENT 'Wochentag Landesspezifische Bezeichnung NL'
    , day_of_week_desc_DE          COMMENT 'Wochentag Landesspezifische Bezeichnung DE'
    , day_of_week_desc_PL          COMMENT 'Wochentag Landesspezifische Bezeichnung PL'
    , day_of_week_desc_PT          COMMENT 'Wochentag Landesspezifische Bezeichnung PT'
    , day_of_week_desc_RO          COMMENT 'Wochentag Landesspezifische Bezeichnung RO'
    , day_of_week_desc_SE          COMMENT 'Wochentag Landesspezifische Bezeichnung SE'
    , day_of_week_desc_SI          COMMENT 'Wochentag Landesspezifische Bezeichnung SI'
    , day_of_week_desc_SK          COMMENT 'Wochentag Landesspezifische Bezeichnung SK'
    , day_of_week_desc_CS          COMMENT 'Wochentag Landesspezifische Bezeichnung CS'
    , day_of_week_desc_MT          COMMENT 'Wochentag Landesspezifische Bezeichnung MT'
    , day_of_week_desc_US          COMMENT 'Wochentag Landesspezifische Bezeichnung US'
    , day_of_week_desc_RS          COMMENT 'Wochentag Landesspezifische Bezeichnung RS_1'
    , day_of_week_desc_short_AT    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung AT'
    , day_of_week_desc_short_BE    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung BE'
    , day_of_week_desc_short_BE_FR COMMENT 'Wochentag Landesspezifische Kurzbezeichnung BE_FR'
    , day_of_week_desc_short_BG    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung BG'
    , day_of_week_desc_short_CH    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung CH'
    , day_of_week_desc_short_CY    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung CY'
    , day_of_week_desc_short_CZ    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung CZ'
    , day_of_week_desc_short       COMMENT 'Wochentag Kurzeschreibung'
    , day_of_week_desc_short_DK    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung DK'
    , day_of_week_desc_short_EE    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung EE'
    , day_of_week_desc_short_ES    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung ES'
    , day_of_week_desc_short_FI    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung FI'
    , day_of_week_desc_short_FR    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung FR'
    , day_of_week_desc_short_GB    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung GB'
    , day_of_week_desc_short_GR    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung GR'
    , day_of_week_desc_short_HR    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung HR'
    , day_of_week_desc_short_HU    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung HU'
    , day_of_week_desc_short_IE    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung IE'
    , day_of_week_desc_short_IT    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung IT'
    , day_of_week_desc_short_LT    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung LT'
    , day_of_week_desc_short_LV    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung LT'
    , day_of_week_desc_short_NI    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung NI'
    , day_of_week_desc_short_NL    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung NL'
    , day_of_week_desc_short_DE    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung DE'
    , day_of_week_desc_short_PL    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung PL'
    , day_of_week_desc_short_PT    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung PT'
    , day_of_week_desc_short_RO    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung RO'
    , day_of_week_desc_short_SE    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung SE'
    , day_of_week_desc_short_SI    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung SI'
    , day_of_week_desc_short_SK    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung SK'
    , day_of_week_desc_short_CS    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung CS'
    , day_of_week_desc_short_MT    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung MT'
    , day_of_week_desc_short_US    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung US'
    , day_of_week_desc_short_RS    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung RS_1'
)
AS
SELECT   day_of_week
       , day_of_week_desc_AT
       , day_of_week_desc_BE
       , day_of_week_desc_BE_FR
       , day_of_week_desc_BG
       , day_of_week_desc_CH
       , day_of_week_desc_CY
       , day_of_week_desc_CZ
       , day_of_week_desc
       , day_of_week_desc_DK
       , day_of_week_desc_EE
       , day_of_week_desc_ES
       , day_of_week_desc_FI
       , day_of_week_desc_FR
       , day_of_week_desc_GB
       , day_of_week_desc_GR
       , day_of_week_desc_HR
       , day_of_week_desc_HU
       , day_of_week_desc_IE
       , day_of_week_desc_IT
       , day_of_week_desc_LT
       , day_of_week_desc_LV
       , day_of_week_desc_NI
       , day_of_week_desc_NL
       , day_of_week_desc_DE
       , day_of_week_desc_PL
       , day_of_week_desc_PT
       , day_of_week_desc_RO
       , day_of_week_desc_SE
       , day_of_week_desc_SI
       , day_of_week_desc_SK
       , day_of_week_desc_CS
       , day_of_week_desc_MT
       , day_of_week_desc_US
       , day_of_week_desc_RS
       , day_of_week_desc_short_AT
       , day_of_week_desc_short_BE
       , day_of_week_desc_short_BE_FR
       , day_of_week_desc_short_BG
       , day_of_week_desc_short_CH
       , day_of_week_desc_short_CY
       , day_of_week_desc_short_CZ
       , day_of_week_desc_short
       , day_of_week_desc_short_DK
       , day_of_week_desc_short_EE
       , day_of_week_desc_short_ES
       , day_of_week_desc_short_FI
       , day_of_week_desc_short_FR
       , day_of_week_desc_short_GB
       , day_of_week_desc_short_GR
       , day_of_week_desc_short_HR
       , day_of_week_desc_short_HU
       , day_of_week_desc_short_IE
       , day_of_week_desc_short_IT
       , day_of_week_desc_short_LT
       , day_of_week_desc_short_LV
       , day_of_week_desc_short_NI
       , day_of_week_desc_short_NL
       , day_of_week_desc_short_DE
       , day_of_week_desc_short_PL
       , day_of_week_desc_short_PT
       , day_of_week_desc_short_RO
       , day_of_week_desc_short_SE
       , day_of_week_desc_short_SI
       , day_of_week_desc_short_SK
       , day_of_week_desc_short_CS
       , day_of_week_desc_short_MT
       , day_of_week_desc_short_US
       , day_of_week_desc_short_RS
  FROM P_LEW_MART_MSI.v_cal_day_of_week_desc_1
;