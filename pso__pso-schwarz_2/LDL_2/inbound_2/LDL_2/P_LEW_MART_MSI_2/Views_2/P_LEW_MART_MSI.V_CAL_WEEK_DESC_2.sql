CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_WEEK_DESC_2 COMMENT = 'Multi language week descriptions'
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_CAL_WEEK_DESC.
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
#  1.5  16.09.2021    Jaroslaw Syrokosz        Change from v_wawi_cal_week_2 to v_cal_week_2 https://jira.schwarz/browse/REP2-10367
#                                              OVERwrite previous changes AS agreed in https://jira.schwarz/browse/REP4-7173
#----------------------------------------------------------------------------
*/
(
        cy_week                  COMMENT 'Geschäftsjahr - Woche_2 Id - Format JJJJMM'
      , cy_week_desc_AT          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung AT'
      , cy_week_desc_BE          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung BE'
      , cy_week_desc_BE_FR       COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung BE_FR'
      , cy_week_desc_BG          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung BG'
      , cy_week_desc_CH          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung CH'
      , cy_week_desc_CY          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung CY'
      , cy_week_desc_CZ          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung CZ'
      , cy_week_desc             COMMENT 'Geschäftsjahr - Woche_2 Bezeichnung'
      , cy_week_desc_DK          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung DK'
      , cy_week_desc_EE          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung EE'
      , cy_week_desc_ES          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung ES'
      , cy_week_desc_FI          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung FI'
      , cy_week_desc_FR          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung FR'
      , cy_week_desc_GB          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung GB'
      , cy_week_desc_GR          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung GR'
      , cy_week_desc_HR          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung HR'
      , cy_week_desc_HU          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung HU'
      , cy_week_desc_IE          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung IE'
      , cy_week_desc_IT          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung IT'
      , cy_week_desc_LT          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung LT'
      , cy_week_desc_LV          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung LV'
      , cy_week_desc_NI          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung NI'
      , cy_week_desc_NL          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung NL'
      , cy_week_desc_DE          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung DE'
      , cy_week_desc_PL          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung PL'
      , cy_week_desc_PT          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung PT'
      , cy_week_desc_RO          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung RO'
      , cy_week_desc_SE          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung SE'
      , cy_week_desc_SI          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung SI'
      , cy_week_desc_SK          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung SK'
      , cy_week_desc_CS          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung CS'
      , cy_week_desc_MT          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung MT'
      , cy_week_desc_US          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung US'
      , cy_week_desc_RS          COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Bezeichnung RS_2'
      , cy_week_desc_short_AT    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung AT'
      , cy_week_desc_short_BE    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung BE'
      , cy_week_desc_short_BE_FR COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung BE_FR'
      , cy_week_desc_short_BG    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung BG'
      , cy_week_desc_short_CH    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung CH'
      , cy_week_desc_short_CY    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung CY'
      , cy_week_desc_short_CZ    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung CZ'
      , cy_week_desc_short       COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung'
      , cy_week_desc_short_DK    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung DK'
      , cy_week_desc_short_EE    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung EE'
      , cy_week_desc_short_ES    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung ES'
      , cy_week_desc_short_FI    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung FI'
      , cy_week_desc_short_FR    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung FR'
      , cy_week_desc_short_GB    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung GB'
      , cy_week_desc_short_GR    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung GR'
      , cy_week_desc_short_HR    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung HR'
      , cy_week_desc_short_HU    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung HU'
      , cy_week_desc_short_IE    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung IE'
      , cy_week_desc_short_IT    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung IT'
      , cy_week_desc_short_LT    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung LT'
      , cy_week_desc_short_LV    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung LV'
      , cy_week_desc_short_NI    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung NI'
      , cy_week_desc_short_NL    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung NL'
      , cy_week_desc_short_DE    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung DE'
      , cy_week_desc_short_PL    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung PL'
      , cy_week_desc_short_PT    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung PT'
      , cy_week_desc_short_RO    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung RO'
      , cy_week_desc_short_SE    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung SE'
      , cy_week_desc_short_SI    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung SI'
      , cy_week_desc_short_SK    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung SK'
      , cy_week_desc_short_CS    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung CS'
      , cy_week_desc_short_MT    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung MT'
      , cy_week_desc_short_US    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung US'
      , cy_week_desc_short_RS    COMMENT 'Geschäftsjahr - Woche_2 Landesspezifische Kurzbezeichnung RS_2'
)
AS
SELECT   t1.cy_week
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_AT
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_BE
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' S '  || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_BE_FR
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KC ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_BG
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_CH
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' EB ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_CY
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KT ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_CZ
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' U '  || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_DK
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_EE
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' S '  || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_ES
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' vk_2 ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_FI
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' S '  || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_FR
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' Wk ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_GB
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' EB ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_GR
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KT ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_HR
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' NH ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_HU
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' WK ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_IE
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_IT
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KS ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_LT
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_LV
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' WK ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_NI
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_NL
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_DE
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' TK ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_PL
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_PT
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' ST ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_RO
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' v. ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_SE
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KT ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_SI
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KT ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_SK
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' S '  || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_CS
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_MT
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' Wk ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_US
       , SUBSTRING(TRIM (t1.cy_week), 1, 4) || ' KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_RS
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_AT
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_BE
       , 'S '  || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_BE_FR
       , 'KC ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_BG
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_CH
       , 'EB ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_CY
       , 'KT ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_CZ
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short
       , 'U '  || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_DK
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_EE
       , 'S '  || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_ES
       , 'vk_2 ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_FI
       , 'S '  || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_FR
       , 'Wk ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_GB
       , 'EB ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_GR
       , 'KT ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_HR
       , 'NH ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_HU
       , 'WK ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_IE
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_IT
       , 'KS ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_LT
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_LV
       , 'WK ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_NI
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_NL
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_DE
       , 'TK ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_PL
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_PT
       , 'ST ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_RO
       , 'v. ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_SE
       , 'KT ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_SI
       , 'KT ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_SK
       , 'S '  || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_CS
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_MT
       , 'Wk ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_US
       , 'KW ' || SUBSTRING(TRIM (t1.cy_week), 5, 2) AS cy_week_desc_short_RS
  FROM P_LEW_CORE_AC.V_CAL_WEEK_2 AS t1_2
;