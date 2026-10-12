CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_CAL_PARTIAL_WEEK_1
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_CAL_PARTIAL_WEEK_1
#----------------------------------------------------------------------------
# History:
#  1.0  19.11.2019    Ulrich Meister           Patch 20191113_2286_DM_t_pos_store_vat_avg_DWH20 (IDMO-2460, DWH-4137)
#  1.1 2020-08-07     Roy, Ritanjal            Introduce new country_1 Latviya
#  1.2  16.09.2021    Jaroslaw Syrokosz        Change from using CORE v_wawi_cal_partial_week_1 to views from BIL https://jira.schwarz/browse/REP2-10367
#  1.3  15.12.2021    Michael Morris           Added Estonia EE and BE_FR
#----------------------------------------------------------------------------
*/
(
   cy_week
 , cy_partial_week
 , cy_partial_week_name
 , cy_partial_week_short_name
 , cy_month
 , cy
 , byr
 , dat_valid_from
 , dat_valid_until
 , partialweek_in_mth_seq_asc
 , partialweek_in_mth_seq_desc
 , cy_partial_week_short_desc_AT
 , cy_partial_week_short_desc_BE
 , cy_partial_week_short_desc_BE_FR
 , cy_partial_week_short_desc_BG
 , cy_partial_week_short_desc_CH
 , cy_partial_week_short_desc_CY
 , cy_partial_week_short_desc_CZ
 , cy_partial_week_short_desc
 , cy_partial_week_short_desc_DK
 , cy_partial_week_short_desc_EE
 , cy_partial_week_short_desc_ES
 , cy_partial_week_short_desc_FI
 , cy_partial_week_short_desc_FR
 , cy_partial_week_short_desc_GB
 , cy_partial_week_short_desc_GR
 , cy_partial_week_short_desc_HR
 , cy_partial_week_short_desc_HU
 , cy_partial_week_short_desc_IE
 , cy_partial_week_short_desc_IT
 , cy_partial_week_short_desc_LT
 , cy_partial_week_short_desc_NI
 , cy_partial_week_short_desc_NL
 , cy_partial_week_short_desc_DE
 , cy_partial_week_short_desc_LV
 , cy_partial_week_short_desc_PL
 , cy_partial_week_short_desc_PT
 , cy_partial_week_short_desc_RO
 , cy_partial_week_short_desc_SE
 , cy_partial_week_short_desc_SI
 , cy_partial_week_short_desc_SK
 , cy_partial_week_short_desc_CS
 , cy_partial_week_short_desc_MT
 , cy_partial_week_short_desc_US
 , cy_partial_week_short_desc_RS
 )
AS
SELECT   cw.cy_week
       , cw.week_part_seq
       , 'TW ' || Trim(MOD(cw.cy_week, 100) ) || '/ ' || Trim(cw.week_part_seq) || '   ' || Trim(cy) AS cy_partial_week_name
       , 'TW ' || Trim(MOD(cw.cy_week, 100) ) || '/ ' || Trim(cw.week_part_seq)                      AS cy_partial_week_short_name
       , cw.cy_month
       , cw.cy
       , cw.bus_year                                                                                 AS byr
       , cw.cy_week_part_begin_dt                                                                    AS dat_valid_from
       , cw.cy_week_part_end_dt                                                                      AS dat_valid_until
       , ROW_NUMBER () OVER (PARTITION BY cy_month ORDER BY cy_week ASC)                             AS partialweek_in_mth_seq_asc
       , ROW_NUMBER () OVER (PARTITION BY cy_month ORDER BY cy_week DESC)                            AS partialweek_in_mth_seq_desc
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_AT , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_AT , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_AT
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_BE , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_BE , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_BE
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_FR , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_FR , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_BE_FR
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_BG , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_BG , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_BG
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_CH , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_CH , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_CH
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_CY , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_CY , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_CY
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_CZ , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_CZ , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_CZ
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN cw.cy_week_part_descr ELSE NULL END AS cy_partial_week_short_desc
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_DK , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_DK , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_DK
       , CAST(NULL AS VARCHAR(7)) AS cy_partial_week_short_desc_EE
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_ES , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_ES , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_ES
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_FI , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_FI , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_FI
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_FR , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_FR , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_FR
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_GB , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_GB , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_GB
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_GR , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_GR , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_GR
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_HR , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_HR , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_HR
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_HU , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_HU , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_HU
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_IE , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_IE , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_IE
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_IT , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_IT , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_IT
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN CASE WHEN cw.cy < 2024 THEN cy_partial_week_short_desc ELSE TRIM(SUBSTRING(fdow.day_of_week_desc_LT , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_LT , 1 , 2 )) END ELSE NULL END AS cy_partial_week_short_desc_LT
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_NI , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_NI , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_NI
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_NL , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_NL , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_NL
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_DE , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_DE , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_DE
       , CAST(NULL AS VARCHAR(7)) AS cy_partial_week_short_desc_LV
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_PL , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_PL , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_PL
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_PT , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_PT , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_PT
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_RO , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_RO , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_RO
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_SE , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_SE , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_SE
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_SI , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_SI , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_SI
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_SK , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_SK , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_SK
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_CS , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_CS , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_CS
       , CASE WHEN cy_week_part_full_week_fg = 0 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_MT , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_MT , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_MT
       , CASE WHEN cy_week_part_full_week_fg = 0 AND cw.cy > 2020 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_US , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_US , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_US
       , CASE WHEN cy_week_part_full_week_fg = 0 AND cw.cy > 2021 THEN TRIM(SUBSTRING(fdow.day_of_week_desc_RS , 1 , 2 ))||' - '||TRIM(SUBSTRING(ldow.day_of_week_desc_RS , 1 , 2 ))ELSE NULL END AS cy_partial_week_short_desc_RS

 FROM P_LEW_BIL_AC.V_DIM_CAL_WEEK_PARTIAL_1 AS cw
 INNER JOIN P_LEW_MART_MSI.V_CAL_DAY_OF_WEEK_DESC_1 AS fdow
    ON cw.cy_week_part_begin_day_of_week = fdow.day_of_week
 INNER JOIN P_LEW_MART_MSI.V_CAL_DAY_OF_WEEK_DESC_1 AS ldow
    ON cw.cy_week_part_end_day_of_week = ldow.day_of_week
 WHERE cw.cy_week <> -1
;



