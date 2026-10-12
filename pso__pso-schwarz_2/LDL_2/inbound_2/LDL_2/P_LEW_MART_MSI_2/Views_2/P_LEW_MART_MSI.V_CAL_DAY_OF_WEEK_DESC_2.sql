CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_DAY_OF_WEEK_DESC_2 COMMENT = 'Multi language day of week descriptions'
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL FOR P_LEW_MART_MSI.V_CAL_DAY_OF_WEEK_DESC_2 .
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber,Harald            ReleASe 1.1
#  1.2  17.01.2018    Wieber,Harald            ReleASe 2.2
#  1.3  06.08.2020    Roy,Ritanjal             Introduce new country_2 LV
#  1.4  27.11.2020    Morris, Michael          Add Column(s) FOR _BE_fr
#                                              20200824_2572_trans_NR_FR_corr
#                                              https://jira.schwarz/browse/REP4-7173
#  1.2  16.09.2021    Jaroslaw Syrokosz        Change from using CORE v_wawi_cal_day_of_week_desc_2 to view from BIL https://jira.schwarz/browse/REP2-10367
#                                              OVERwrite previous changes AS agreed in https://jira.schwarz/browse/REP4-7173
#  1.3  15.12.2021    Michael Morris           Added Estonia EE & BE_FR
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
      , day_of_week_desc_RS          COMMENT 'Wochentag Landesspezifische Bezeichnung RS_2'
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
      , day_of_week_desc_short_RS    COMMENT 'Wochentag Landesspezifische Kurzbezeichnung RS_2'
) 
AS
 SELECT   day_of_week
        , day_of_week_name_DE AS day_of_week_desc_AT
        , day_of_week_name_NL AS day_of_week_desc_BE
        , day_of_week_name_FR AS day_of_week_desc_BE_FR
        , CASE WHEN day_of_week = 1 THEN 'Понеделник'
               WHEN day_of_week = 2 THEN 'Вторник'
               WHEN day_of_week = 3 THEN 'Сряда'
               WHEN day_of_week = 4 THEN 'Четвъртък'
               WHEN day_of_week = 5 THEN 'Петък'
               WHEN day_of_week = 6 THEN 'Събота'
               WHEN day_of_week = 7 THEN 'Неделя'
           END                AS day_of_week_desc_BG
        , day_of_week_name_DE AS day_of_week_desc_CH
        , day_of_week_name_EL AS day_of_week_desc_CY
        , day_of_week_name_CS AS day_of_week_desc_CZ
        , day_of_week_name AS day_of_week_desc
        , day_of_week_name_DA AS day_of_week_desc_DK
        , CASE WHEN day_of_week = 1 THEN 'Esmaspäev'
               WHEN day_of_week = 2 THEN 'Teisipäev'
               WHEN day_of_week = 3 THEN 'Kolmapäev'
               WHEN day_of_week = 4 THEN 'Neljapäev'
               WHEN day_of_week = 5 THEN 'Reede'
               WHEN day_of_week = 6 THEN 'Laupäev'
               WHEN day_of_week = 7 THEN 'Pühapäev'
          END                 AS day_of_week_desc_EE
        , day_of_week_name_ES AS day_of_week_desc_ES
        , day_of_week_name_FI AS day_of_week_desc_FI
        , day_of_week_name_FR AS day_of_week_desc_FR
        , day_of_week_name_EN AS day_of_week_desc_GB
        , day_of_week_name_EL AS day_of_week_desc_GR
        , day_of_week_name_HR AS day_of_week_desc_HR
        , day_of_week_name_HU AS day_of_week_desc_HU
        , day_of_week_name_EN AS day_of_week_desc_IE
        , day_of_week_name_IT AS day_of_week_desc_IT
        , UPPER(SUBSTRING(day_of_week_name_LT , 1, 1)) || SUBSTRING(day_of_week_name_LT , 2)  AS day_of_week_desc_LT
        , CASE WHEN day_of_week = 1 THEN 'Pirmdiena'
               WHEN day_of_week = 2 THEN 'Otrdiena'
               WHEN day_of_week = 3 THEN 'Tresdiena'
               WHEN day_of_week = 4 THEN 'Ceturtdiena'
               WHEN day_of_week = 5 THEN 'Piektdiena'
               WHEN day_of_week = 6 THEN 'Sestdiena'
               WHEN day_of_week = 7 THEN 'Svetdiena'
           END                AS day_of_week_desc_LV
        , day_of_week_name_EN AS day_of_week_desc_NI
        , day_of_week_name_NL AS day_of_week_desc_NL
        , day_of_week_name_DE AS day_of_week_desc_DE
        , day_of_week_name_PL AS day_of_week_desc_PL
        , day_of_week_name_PT AS day_of_week_desc_PT
        , day_of_week_name_RO AS day_of_week_desc_RO
        , day_of_week_name_SV AS day_of_week_desc_SE
        , CASE WHEN day_of_week = 4 THEN 'Četrtek' ELSE day_of_week_name_SL END AS day_of_week_desc_SI
        , CASE WHEN day_of_week = 7 THEN 'Nedeľa' ELSE day_of_week_name_SK END AS day_of_week_desc_SK
        , day_of_week_name_ES AS day_of_week_desc_CS
        , day_of_week_name_EN AS day_of_week_desc_MT
        , day_of_week_name_EN AS day_of_week_desc_US
        , CASE WHEN day_of_week = 1 THEN 'Ponedeljak'
               WHEN day_of_week = 2 THEN 'Utorak'
               WHEN day_of_week = 3 THEN 'Sreda'
               WHEN day_of_week = 4 THEN 'Cetvrtak'
               WHEN day_of_week = 5 THEN 'Petak'
               WHEN day_of_week = 6 THEN 'Subota'
               WHEN day_of_week = 7 THEN 'Nedelja'
           END                                  AS day_of_week_desc_RS
        , SUBSTRING(day_of_week_desc_AT , 1, 2) AS day_of_week_desc_short_AT
        , SUBSTRING(day_of_week_desc_BE , 1, 2) AS day_of_week_desc_short_BE
        , SUBSTRING(day_of_week_desc_FR , 1, 2) AS day_of_week_desc_short_BE_FR
        , SUBSTRING(day_of_week_desc_BG , 1, 2) AS day_of_week_desc_short_BG
        , SUBSTRING(day_of_week_desc_CH , 1, 2) AS day_of_week_desc_short_CH
        , SUBSTRING(day_of_week_desc_CY , 1, 2) AS day_of_week_desc_short_CY
        , SUBSTRING(day_of_week_desc_CZ , 1, 2) AS day_of_week_desc_short_CZ
        , SUBSTRING(day_of_week_desc , 1, 2)    AS day_of_week_desc_short
        , SUBSTRING(day_of_week_desc_DK , 1, 2) AS day_of_week_desc_short_DK
        , SUBSTRING(day_of_week_desc_EE , 1, 2) AS day_of_week_desc_short_EE
        , SUBSTRING(day_of_week_desc_ES , 1, 2) AS day_of_week_desc_short_ES
        , SUBSTRING(day_of_week_desc_FI , 1, 2) AS day_of_week_desc_short_FI
        , SUBSTRING(day_of_week_desc_FR , 1, 2) AS day_of_week_desc_short_FR
        , SUBSTRING(day_of_week_desc_GB , 1, 2) AS day_of_week_desc_short_GB
        , SUBSTRING(day_of_week_desc_GR , 1, 2) AS day_of_week_desc_short_GR
        , SUBSTRING(day_of_week_desc_HR , 1, 2) AS day_of_week_desc_short_HR
        , SUBSTRING(day_of_week_desc_HU , 1, 2) AS day_of_week_desc_short_HU
        , SUBSTRING(day_of_week_desc_IE , 1, 2) AS day_of_week_desc_short_IE
        , SUBSTRING(day_of_week_desc_IT , 1, 2) AS day_of_week_desc_short_IT
        , SUBSTRING(day_of_week_desc_LT , 1, 2) AS day_of_week_desc_short_LT
        , SUBSTRING(day_of_week_desc_DE , 1, 2) AS day_of_week_desc_short_LV
        , SUBSTRING(day_of_week_desc_NI , 1, 2) AS day_of_week_desc_short_NI
        , SUBSTRING(day_of_week_desc_NL , 1, 2) AS day_of_week_desc_short_NL
        , SUBSTRING(day_of_week_desc_DE , 1, 2) AS day_of_week_desc_short_DE
        , SUBSTRING(day_of_week_desc_PL , 1, 2) AS day_of_week_desc_short_PL
        , SUBSTRING(day_of_week_desc_PT , 1, 2) AS day_of_week_desc_short_PT
        , SUBSTRING(day_of_week_desc_RO , 1, 2) AS day_of_week_desc_short_RO
        , SUBSTRING(day_of_week_desc_SE , 1, 2) AS day_of_week_desc_short_SE
        , SUBSTRING(day_of_week_desc_SI , 1, 2) AS day_of_week_desc_short_SI
        , SUBSTRING(day_of_week_desc_SK , 1, 2) AS day_of_week_desc_short_SK
        , SUBSTRING(day_of_week_desc_CS , 1, 2) AS day_of_week_desc_short_CS
        , SUBSTRING(day_of_week_desc_MT , 1, 2) AS day_of_week_desc_short_MT
        , SUBSTRING(day_of_week_desc_US , 1, 2) AS day_of_week_desc_short_US
        , SUBSTRING(day_of_week_desc_RS , 1, 2) AS day_of_week_desc_short_RS

 FROM P_LEW_BIL_AC.V_DIM_CAL_DAY_OF_WEEK_2
WHERE day_of_week <> -1
;