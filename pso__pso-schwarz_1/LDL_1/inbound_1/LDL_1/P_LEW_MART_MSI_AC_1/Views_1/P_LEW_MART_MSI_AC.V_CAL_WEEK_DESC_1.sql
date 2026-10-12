CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CAL_WEEK_DESC_1 COMMENT = 'Multi language week descriptions'
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            ReleASe 1.1
#  1.2  17.01.2018    Wieber,Harald            ReleASe 2.2
#  1.3  30.07.2020    Morris, Michael          20200730_2551_Litauen_lang_ref_data (INC2047852) REP4-6910
#                                              Kalenderwoche-Kurzel auf 'KS' geändert für Litauen LT
#  1.4  27.11.2020    Morris, Michael          Add Column(s) for _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.5  16.09.2021    Jaroslaw Syrokosz        Change from v_wawi_cal_week_1 to v_cal_week_1 https://jira.schwarz/browse/REP2-10367
#                                              OVERwrite previous changes AS agreed in https://jira.schwarz/browse/REP4-7173
#  1.6  23.12.2021    Zied Nanaa               Add languages BE_FR and EE
#-----------------------------------------------------------------------------
*/
(
      cy_week                        COMMENT 'Geschäftsjahr - Woche_1 Id - Format JJJJMM'
    , cy_week_desc_AT                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung AT'
    , cy_week_desc_BE                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung BE'
    , cy_week_desc_BE_FR             COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung BE_FR'
    , cy_week_desc_BG                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung BG'
    , cy_week_desc_CH                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung CH'
    , cy_week_desc_CY                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung CY'
    , cy_week_desc_CZ                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung CZ'
    , cy_week_desc                   COMMENT 'Geschäftsjahr - Woche_1 Bezeichnung'
    , cy_week_desc_DK                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung DK'
    , cy_week_desc_EE                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung EE'
    , cy_week_desc_ES                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung ES'
    , cy_week_desc_FI                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung FI'
    , cy_week_desc_FR                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung FR'
    , cy_week_desc_GB                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung GB'
    , cy_week_desc_GR                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung GR'
    , cy_week_desc_HR                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung HR'
    , cy_week_desc_HU                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung HU'
    , cy_week_desc_IE                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung IE'
    , cy_week_desc_IT                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung IT'
    , cy_week_desc_LT                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung LT'
    , cy_week_desc_LV                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung LV'
    , cy_week_desc_NI                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung NI'
    , cy_week_desc_NL                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung NL'
    , cy_week_desc_DE                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung DE'
    , cy_week_desc_PL                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung PL'
    , cy_week_desc_PT                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung PT'
    , cy_week_desc_RO                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung RO'
    , cy_week_desc_SE                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung SE'
    , cy_week_desc_SI                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung SI'
    , cy_week_desc_SK                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung SK'
    , cy_week_desc_CS                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung CS'
    , cy_week_desc_MT                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung MT'
    , cy_week_desc_US                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung US'
    , cy_week_desc_RS                COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Bezeichnung RS_1'
    , cy_week_desc_short_AT          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung AT'
    , cy_week_desc_short_BE          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung BE'
    , cy_week_desc_short_BE_FR       COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung BE_FR'
    , cy_week_desc_short_BG          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung BG'
    , cy_week_desc_short_CH          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung CH'
    , cy_week_desc_short_CY          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung CY'
    , cy_week_desc_short_CZ          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung CZ'
    , cy_week_desc_short             COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung'
    , cy_week_desc_short_DK          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung DK'
    , cy_week_desc_short_EE          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung EE'
    , cy_week_desc_short_ES          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung ES'
    , cy_week_desc_short_FI          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung FI'
    , cy_week_desc_short_FR          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung FR'
    , cy_week_desc_short_GB          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung GB'
    , cy_week_desc_short_GR          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung GR'
    , cy_week_desc_short_HR          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung HR'
    , cy_week_desc_short_HU          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung HU'
    , cy_week_desc_short_IE          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung IE'
    , cy_week_desc_short_IT          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung IT'
    , cy_week_desc_short_LT          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung LT'
    , cy_week_desc_short_LV          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung LV'
    , cy_week_desc_short_NI          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung NI'
    , cy_week_desc_short_NL          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung NL'
    , cy_week_desc_short_DE          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung DE'
    , cy_week_desc_short_PL          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung PL'
    , cy_week_desc_short_PT          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung PT'
    , cy_week_desc_short_RO          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung RO'
    , cy_week_desc_short_SE          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung SE'
    , cy_week_desc_short_SI          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung SI'
    , cy_week_desc_short_SK          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung SK'
    , cy_week_desc_short_CS          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung CS'
    , cy_week_desc_short_MT          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung MT'
    , cy_week_desc_short_US          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung US'
    , cy_week_desc_short_RS          COMMENT 'Geschäftsjahr - Woche_1 Landesspezifische Kurzbezeichnung RS_1'
) AS
SELECT  cy_week
      , cy_week_desc_AT
      , cy_week_desc_BE
      , cy_week_desc_BE_FR
      , cy_week_desc_BG
      , cy_week_desc_CH
      , cy_week_desc_CY
      , cy_week_desc_CZ
      , cy_week_desc
      , cy_week_desc_DK
      , cy_week_desc_EE
      , cy_week_desc_ES
      , cy_week_desc_FI
      , cy_week_desc_FR
      , cy_week_desc_GB
      , cy_week_desc_GR
      , cy_week_desc_HR
      , cy_week_desc_HU
      , cy_week_desc_IE
      , cy_week_desc_IT
      , cy_week_desc_LT
      , cy_week_desc_LV
      , cy_week_desc_NI
      , cy_week_desc_NL
      , cy_week_desc_DE
      , cy_week_desc_PL
      , cy_week_desc_PT
      , cy_week_desc_RO
      , cy_week_desc_SE
      , cy_week_desc_SI
      , cy_week_desc_SK
      , cy_week_desc_CS
      , cy_week_desc_MT
      , cy_week_desc_US
      , cy_week_desc_RS
      , cy_week_desc_short_AT
      , cy_week_desc_short_BE
      , cy_week_desc_short_BE_FR
      , cy_week_desc_short_BG
      , cy_week_desc_short_CH
      , cy_week_desc_short_CY
      , cy_week_desc_short_CZ
      , cy_week_desc_short
      , cy_week_desc_short_DK
      , cy_week_desc_short_EE
      , cy_week_desc_short_ES
      , cy_week_desc_short_FI
      , cy_week_desc_short_FR
      , cy_week_desc_short_GB
      , cy_week_desc_short_GR
      , cy_week_desc_short_HR
      , cy_week_desc_short_HU
      , cy_week_desc_short_IE
      , cy_week_desc_short_IT
      , cy_week_desc_short_LT
      , cy_week_desc_short_LV
      , cy_week_desc_short_NI
      , cy_week_desc_short_NL
      , cy_week_desc_short_DE
      , cy_week_desc_short_PL
      , cy_week_desc_short_PT
      , cy_week_desc_short_RO
      , cy_week_desc_short_SE
      , cy_week_desc_short_SI
      , cy_week_desc_short_SK
      , cy_week_desc_short_CS
      , cy_week_desc_short_MT
      , cy_week_desc_short_US
      , cy_week_desc_short_RS
FROM    P_LEW_MART_MSI.v_cal_week_desc_1
;