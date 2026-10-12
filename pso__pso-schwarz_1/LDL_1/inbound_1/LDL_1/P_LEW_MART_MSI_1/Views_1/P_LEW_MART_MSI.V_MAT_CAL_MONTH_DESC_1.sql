CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_CAL_MONTH_DESC_1
/*
# History:
#  1.0  19.11.2019    Ulrich Meister           Patch 20191113_2286_DM_t_pos_store_vat_avg_DWH20 (IDMO-2460, DWH-4137)
#  1.1  06.08.2018    Roy,Ritanjal             Introduce new country_1 Latviya
#  1.2  18.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#  1.3  2021-10-04    Jaroslaw Syrokosz        Transall shutdown - update to use BIL view
#  1.4  2021-12-13    Michael Morris           Added Estonia EE & BE_FR
*/
(
   month_id
 , cy_month
 , cy
 , byr
 , cy_month_name_AT
 , cy_month_name_BE
 , cy_month_name_BE_FR
 , cy_month_name_BG
 , cy_month_name_CH
 , cy_month_name_CY
 , cy_month_name_CZ
 , cy_month_name
 , cy_month_name_DK
 , cy_month_name_EE
 , cy_month_name_ES
 , cy_month_name_FI
 , cy_month_name_FR
 , cy_month_name_GB
 , cy_month_name_GR
 , cy_month_name_HR
 , cy_month_name_HU
 , cy_month_name_IE
 , cy_month_name_IT
 , cy_month_name_LT
 , cy_month_name_LV
 , cy_month_name_NI
 , cy_month_name_NL
 , cy_month_name_DE
 , cy_month_name_PL
 , cy_month_name_PT
 , cy_month_name_RO
 , cy_month_name_SE
 , cy_month_name_SI
 , cy_month_name_SK
 , cy_month_name_CS
 , cy_month_name_MT
 , cy_month_name_US
 , cy_month_name_RS
 , cy_month_name_short_AT
 , cy_month_name_short_BE
 , cy_month_name_short_BE_FR
 , cy_month_name_short_BG
 , cy_month_name_short_CH
 , cy_month_name_short_CY
 , cy_month_name_short_CZ
 , cy_month_name_short
 , cy_month_name_short_DK
 , cy_month_name_short_EE
 , cy_month_name_short_ES
 , cy_month_name_short_FI
 , cy_month_name_short_FR
 , cy_month_name_short_GB
 , cy_month_name_short_GR
 , cy_month_name_short_HR
 , cy_month_name_short_HU
 , cy_month_name_short_IE
 , cy_month_name_short_IT
 , cy_month_name_short_LT
 , cy_month_name_short_LV
 , cy_month_name_short_NI
 , cy_month_name_short_NL
 , cy_month_name_short_DE
 , cy_month_name_short_PL
 , cy_month_name_short_PT
 , cy_month_name_short_RO
 , cy_month_name_short_SE
 , cy_month_name_short_SI
 , cy_month_name_short_SK
 , cy_month_name_short_CS
 , cy_month_name_short_MT
 , cy_month_name_short_US
 , cy_month_name_short_RS
 , month_name_AT
 , month_name_BE
 , month_name_BE_FR
 , month_name_BG
 , month_name_CH
 , month_name_CY
 , month_name_CZ
 , month_name
 , month_name_DK
 , month_name_EE
 , month_name_ES
 , month_name_FI
 , month_name_FR
 , month_name_GB
 , month_name_GR
 , month_name_HR
 , month_name_HU
 , month_name_IE
 , month_name_IT
 , month_name_LT
 , month_name_LV
 , month_name_NI
 , month_name_NL
 , month_name_DE
 , month_name_PL
 , month_name_PT
 , month_name_RO
 , month_name_SE
 , month_name_SI
 , month_name_SK
 , month_name_CS
 , month_name_MT
 , month_name_US
 , month_name_RS
 )
AS
SELECT   _month_id AS month_id
       , cy_month
       , cy
       , byr
       , TRIM(month_name_AT) || ' ' || TRIM(cy) AS cy_month_name_AT
       , TRIM(month_name_BE) || ' ' || TRIM(cy) AS cy_month_name_BE
       , TRIM(month_name_FR) || ' ' || TRIM(cy) AS cy_month_name_BE_FR
       , TRIM(month_name_BG) || ' ' || TRIM(cy) AS cy_month_name_BG
       , TRIM(month_name_CH) || ' ' || TRIM(cy) AS cy_month_name_CH
       , TRIM(month_name_CY) || ' ' || TRIM(cy) AS cy_month_name_CY
       , TRIM(month_name_CZ) || ' ' || TRIM(cy) AS cy_month_name_CZ
       , TRIM(month_name)    || ' ' || TRIM(cy) AS cy_month_name
       , TRIM(month_name_DK) || ' ' || TRIM(cy) AS cy_month_name_DK
       , TRIM(month_name_EE) || ' ' || TRIM(cy) AS cy_month_name_EE
       , TRIM(month_name_ES) || ' ' || TRIM(cy) AS cy_month_name_ES
       , TRIM(month_name_FI) || ' ' || TRIM(cy) AS cy_month_name_FI
       , TRIM(month_name_FR) || ' ' || TRIM(cy) AS cy_month_name_FR
       , TRIM(month_name_GB) || ' ' || TRIM(cy) AS cy_month_name_GB
       , TRIM(month_name_GR) || ' ' || TRIM(cy) AS cy_month_name_GR
       , TRIM(month_name_HR) || ' ' || TRIM(cy) AS cy_month_name_HR
       , TRIM(month_name_HU) || ' ' || TRIM(cy) AS cy_month_name_HU
       , TRIM(month_name_IE) || ' ' || TRIM(cy) AS cy_month_name_IE
       , TRIM(month_name_IT) || ' ' || TRIM(cy) AS cy_month_name_IT
       , TRIM(month_name_LT) || ' ' || TRIM(cy) AS cy_month_name_LT
       , TRIM(month_name_LV) || ' ' || TRIM(cy) AS cy_month_name_LV
       , TRIM(month_name_NI) || ' ' || TRIM(cy) AS cy_month_name_NI
       , TRIM(month_name_NL) || ' ' || TRIM(cy) AS cy_month_name_NL
       , TRIM(month_name_DE) || ' ' || TRIM(cy) AS cy_month_name_DE
       , TRIM(month_name_PL) || ' ' || TRIM(cy) AS cy_month_name_PL
       , TRIM(month_name_PT) || ' ' || TRIM(cy) AS cy_month_name_PT
       , TRIM(month_name_RO) || ' ' || TRIM(cy) AS cy_month_name_RO
       , TRIM(month_name_SE) || ' ' || TRIM(cy) AS cy_month_name_SE
       , TRIM(month_name_SI) || ' ' || TRIM(cy) AS cy_month_name_SI
       , TRIM(month_name_SK) || ' ' || TRIM(cy) AS cy_month_name_SK
       , TRIM(month_name_CS) || ' ' || TRIM(cy) AS cy_month_name_CS
       , TRIM(month_name_MT) || ' ' || TRIM(cy) AS cy_month_name_MT
       , TRIM(month_name_US) || ' ' || TRIM(cy) AS cy_month_name_US
       , TRIM(month_name_RS) || ' ' || TRIM(cy) AS cy_month_name_RS
       , cy_month_name_short_AT
       , cy_month_name_short_BE
       , cy_month_name_short_FR AS cy_month_name_short_BE_FR
       , cy_month_name_short_BG
       , cy_month_name_short_CH
       , cy_month_name_short_CY
       , cy_month_name_short_CZ
       , cy_month_name_short
       , cy_month_name_short_DK
       , cy_month_name_short_EE
       , cy_month_name_short_ES
       , cy_month_name_short_FI
       , cy_month_name_short_FR
       , cy_month_name_short_GB
       , cy_month_name_short_GR
       , cy_month_name_short_HR
       , cy_month_name_short_HU
       , cy_month_name_short_IE
       , cy_month_name_short_IT
       , cy_month_name_short_LT
       , cy_month_name_short_LV
       , cy_month_name_short_NI
       , cy_month_name_short_NL
       , cy_month_name_short_DE
       , cy_month_name_short_PL
       , cy_month_name_short_PT
       , cy_month_name_short_RO
       , cy_month_name_short_SE
       , cy_month_name_short_SI
       , cy_month_name_short_SK
       , cy_month_name_short_CS
       , cy_month_name_short_MT
       , cy_month_name_short_US
       , cy_month_name_short_RS
       , month_name_AT
       , month_name_BE
       , month_name_FR AS month_name_BE_FR
       , month_name_BG
       , month_name_CH
       , month_name_CY
       , month_name_CZ
       , month_name
       , month_name_DK
       , month_name_EE
       , month_name_ES
       , month_name_FI
       , month_name_FR
       , month_name_GB
       , month_name_GR
       , month_name_HR
       , month_name_HU
       , month_name_IE
       , month_name_IT
       , month_name_LT
       , month_name_LV
       , month_name_NI
       , month_name_NL
       , month_name_DE
       , month_name_PL
       , month_name_PT
       , month_name_RO
       , month_name_SE
       , month_name_SI
       , month_name_SK
       , month_name_CS
       , month_name_MT
       , month_name_US
       , month_name_RS
  FROM (
        SELECT   MONTH_OF_YEAR                                AS _month_id
               , cy_month                                     AS cy_month
               , cy                                           AS cy
               , bus_year                                     AS byr
               , month_of_year_short_name_DE                  AS cy_month_name_short_AT
               , month_of_year_short_name_NL                  AS cy_month_name_short_BE
               , month_of_year_short_name_BG                  AS cy_month_name_short_BG
               , month_of_year_short_name_DE                  AS cy_month_name_short_CH
               , month_of_year_short_name_EL                  AS cy_month_name_short_CY
               , month_of_year_short_name_CS                  AS cy_month_name_short_CZ
               , month_of_year_short_name                     AS cy_month_name_short
               , month_of_year_short_name_DA                  AS cy_month_name_short_DK
               , CASE WHEN MONTH_OF_YEAR =  1 THEN 'Jaan.'
                      WHEN MONTH_OF_YEAR =  2 THEN 'Veeb.'
                      WHEN MONTH_OF_YEAR =  3 THEN 'Märts'
                      WHEN MONTH_OF_YEAR =  4 THEN 'Apr.'
                      WHEN MONTH_OF_YEAR =  5 THEN 'Mai'
                      WHEN MONTH_OF_YEAR =  6 THEN 'Juuni'
                      WHEN MONTH_OF_YEAR =  7 THEN 'Juuli'
                      WHEN MONTH_OF_YEAR =  8 THEN 'Aug.'
                      WHEN MONTH_OF_YEAR =  9 THEN 'Sept.'
                      WHEN MONTH_OF_YEAR = 10 THEN 'Okt.'
                      WHEN MONTH_OF_YEAR = 11 THEN 'Nov.'
                      WHEN MONTH_OF_YEAR = 12 THEN 'Dets.'
                  END                                         AS cy_month_name_short_EE
               , month_of_year_short_name_ES                  AS cy_month_name_short_ES
               , month_of_year_short_name_FI                  AS cy_month_name_short_FI
               , month_of_year_short_name_FR                  AS cy_month_name_short_FR
               , month_of_year_short_name_EN                  AS cy_month_name_short_GB
               , month_of_year_short_name_EL                  AS cy_month_name_short_GR
               , month_of_year_short_name_HR                  AS cy_month_name_short_HR
               , month_of_year_short_name_HU                  AS cy_month_name_short_HU
               , CASE WHEN MONTH_OF_YEAR = 12 THEN 'Dez'
                      ELSE month_of_year_short_name_EN
                  END                                         AS cy_month_name_short_IE
               , month_of_year_short_name_IT                  AS cy_month_name_short_IT
               , CASE WHEN MONTH_OF_YEAR =  1 THEN 'saus.'
                      WHEN MONTH_OF_YEAR =  2 THEN 'vas.'
                      WHEN MONTH_OF_YEAR =  3 THEN 'kovas'
                      WHEN MONTH_OF_YEAR =  4 THEN 'bal.'
                      WHEN MONTH_OF_YEAR =  5 THEN 'geg.'
                      WHEN MONTH_OF_YEAR =  6 THEN 'birz'
                      WHEN MONTH_OF_YEAR =  7 THEN 'liepa'
                      WHEN MONTH_OF_YEAR =  8 THEN 'rugp.'
                      WHEN MONTH_OF_YEAR =  9 THEN 'rugs.'
                      WHEN MONTH_OF_YEAR = 10 THEN 'spalis'
                      WHEN MONTH_OF_YEAR = 11 THEN 'lapkr.'
                      WHEN MONTH_OF_YEAR = 12 THEN 'gr.'
                  END                                         AS cy_month_name_short_LT
               , CASE WHEN MONTH_OF_YEAR =  5 THEN 'Maijs'
                      WHEN MONTH_OF_YEAR = 10 THEN 'Okt'
                      ELSE month_of_year_short_name_EN
                  END                                         AS cy_month_name_short_LV
               , CASE WHEN MONTH_OF_YEAR = 12 THEN 'Dez'
                      ELSE month_of_year_short_name_EN
                  END                                         AS cy_month_name_short_NI
               , month_of_year_short_name_NL                  AS cy_month_name_short_NL
               , month_of_year_short_name_DE                  AS cy_month_name_short_DE
               , month_of_year_short_name_PL                  AS cy_month_name_short_PL
               , month_of_year_short_name_PT                  AS cy_month_name_short_PT
               , month_of_year_short_name_RO                  AS cy_month_name_short_RO
               , month_of_year_short_name_SV                  AS cy_month_name_short_SE
               , month_of_year_short_name_SL                  AS cy_month_name_short_SI
               , month_of_year_short_name_SK                  AS cy_month_name_short_SK
               , month_of_year_short_name_ES                  AS cy_month_name_short_CS
               , month_of_year_short_name_EN                  AS cy_month_name_short_MT
               , month_of_year_short_name_EN                  AS cy_month_name_short_US
               , CASE WHEN MONTH_OF_YEAR = 8 THEN 'Avg'
                      ELSE month_of_year_short_name_SK
                  END                                         AS cy_month_name_short_RS
               , CASE WHEN MONTH_OF_YEAR = 1 THEN 'Jänner'
                      ELSE month_of_year_name_DE
                  END                                         AS month_name_AT
               , month_of_year_name_NL                        AS month_name_BE
               , month_of_year_name_BG                        AS month_name_BG
               , month_of_year_name_DE                        AS month_name_CH
               , CASE WHEN MONTH_OF_YEAR =  1 THEN 'Ιανουάριος'
                      WHEN MONTH_OF_YEAR =  2 THEN 'Φεβρουάριος'
                      WHEN MONTH_OF_YEAR =  3 THEN 'Μάρτιος'
                      WHEN MONTH_OF_YEAR =  4 THEN 'Απρίλιος'
                      WHEN MONTH_OF_YEAR =  5 THEN 'Μάϊος'
                      WHEN MONTH_OF_YEAR =  6 THEN 'Ιούνιος'
                      WHEN MONTH_OF_YEAR =  7 THEN 'Ιούλιος'
                      WHEN MONTH_OF_YEAR =  8 THEN 'Αύγουστος'
                      WHEN MONTH_OF_YEAR =  9 THEN 'Σεπτέμβριος'
                      WHEN MONTH_OF_YEAR = 10 THEN 'Οκτώβριος'
                      WHEN MONTH_OF_YEAR = 11 THEN 'Νοέμβριος'
                      WHEN MONTH_OF_YEAR = 12 THEN 'Δεκέμβριος'
                  END                                         AS month_name_CY
               , month_of_year_name_CS                        AS month_name_CZ
               , month_of_year_name                           AS month_name
               , month_of_year_name_DA                        AS month_name_DK
               , CASE WHEN MONTH_OF_YEAR =  1 THEN 'Jaanuar'
                      WHEN MONTH_OF_YEAR =  2 THEN 'Veebruar'
                      WHEN MONTH_OF_YEAR =  3 THEN 'Märts'
                      WHEN MONTH_OF_YEAR =  4 THEN 'Aprill'
                      WHEN MONTH_OF_YEAR =  5 THEN 'Mai'
                      WHEN MONTH_OF_YEAR =  6 THEN 'Juuni'
                      WHEN MONTH_OF_YEAR =  7 THEN 'Juuli'
                      WHEN MONTH_OF_YEAR =  8 THEN 'August'
                      WHEN MONTH_OF_YEAR =  9 THEN 'September'
                      WHEN MONTH_OF_YEAR = 10 THEN 'Oktoober'
                      WHEN MONTH_OF_YEAR = 11 THEN 'November'
                      WHEN MONTH_OF_YEAR = 12 THEN 'Detsember'
                  END                                         AS month_name_EE
               , month_of_year_name_ES                        AS month_name_ES
               , month_of_year_name_FI                        AS month_name_FI
               , month_of_year_name_FR                        AS month_name_FR
               , month_of_year_name_EN                        AS month_name_GB
               , month_name_CY                                AS month_name_GR
               , month_of_year_name_HR                        AS month_name_HR
               , month_of_year_name_HU                        AS month_name_HU
               , month_of_year_name_EN                        AS month_name_IE
               , month_of_year_name_IT                        AS month_name_IT
               , UPPER(SUBSTRING(month_of_year_name_LT , 1 , 1)) || SUBSTRING(month_of_year_name_LT , 2) AS month_name_LT
               , CASE WHEN MONTH_OF_YEAR =  1 THEN 'Janvaris'
                      WHEN MONTH_OF_YEAR =  2 THEN 'Februaris'
                      WHEN MONTH_OF_YEAR =  3 THEN 'Marts'
                      WHEN MONTH_OF_YEAR =  4 THEN 'Aprilis'
                      WHEN MONTH_OF_YEAR =  5 THEN 'Maijs'
                      WHEN MONTH_OF_YEAR =  6 THEN 'Junijs'
                      WHEN MONTH_OF_YEAR =  7 THEN 'Julijs'
                      WHEN MONTH_OF_YEAR =  8 THEN 'Augusts'
                      WHEN MONTH_OF_YEAR =  9 THEN 'Septembris'
                      WHEN MONTH_OF_YEAR = 10 THEN 'Oktobris'
                      WHEN MONTH_OF_YEAR = 11 THEN 'Novembris'
                      WHEN MONTH_OF_YEAR = 12 THEN 'Decembris'
                  END                                         AS month_name_LV
               , month_of_year_name_EN                        AS month_name_NI
               , month_of_year_name_NL                        AS month_name_NL
               , month_of_year_name_DE                        AS month_name_DE
               , month_of_year_name_PL                        AS month_name_PL
               , month_of_year_name_PT                        AS month_name_PT
               , month_of_year_name_RO                        AS month_name_RO
               , LOWER(month_of_year_name_SV)                 AS month_name_SE
               , month_of_year_name_SL                        AS month_name_SI
               , month_of_year_name_SK                        AS month_name_SK
               , month_of_year_name_ES                        AS month_name_CS
               , month_of_year_name_EN                        AS month_name_MT
               , month_of_year_name_EN                        AS month_name_US
               , CASE WHEN MONTH_OF_YEAR =  1 THEN 'Januar'
                      WHEN MONTH_OF_YEAR =  2 THEN 'Februar'
                      WHEN MONTH_OF_YEAR =  3 THEN 'Mart'
                      WHEN MONTH_OF_YEAR =  4 THEN 'April'
                      WHEN MONTH_OF_YEAR =  5 THEN 'Maj'
                      WHEN MONTH_OF_YEAR =  6 THEN 'Jun'
                      WHEN MONTH_OF_YEAR =  7 THEN 'Jul'
                      WHEN MONTH_OF_YEAR =  8 THEN 'Avgust'
                      WHEN MONTH_OF_YEAR =  9 THEN 'Septembar'
                      WHEN MONTH_OF_YEAR = 10 THEN 'Oktobar'
                      WHEN MONTH_OF_YEAR = 11 THEN 'Novembar'
                      WHEN MONTH_OF_YEAR = 12 THEN 'Decembar'
                  END                                         AS month_name_RS

  FROM P_LEW_BIL_AC.V_DIM_CAL_MONTH_1 AS dcm
  WHERE cy_month <> -1
 ) AS base
;