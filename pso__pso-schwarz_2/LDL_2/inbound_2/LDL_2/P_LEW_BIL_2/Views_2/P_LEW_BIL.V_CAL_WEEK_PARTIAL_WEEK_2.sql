/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_CAL_WEEK_PARTIAL_WEEK.
#----------------------------------------------------------------------------
# History:
#  1.0  15.09.2021    Syrokosz, Jaroslaw       First draft 
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_BIL.V_CAL_WEEK_PARTIAL_WEEK_2
/*
#DescStart#
#$Revision: 62789 $, $LastChangedBy: jsyrokosz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    cy_week_partial_week_id1
    , cy_week_partial_week_id2
    , cy_week_partial_week_name
    , cy_month
    , busyear
    , cy_week_partial_week_id
    , partialweek_in_mth_seq_asc
    , partialweek_in_mth_seq_desc
    , cy_partial_week_short_name
    , cy_partial_week_short_name_DE
    , cy_partial_week_short_name_EN
    , cy_partial_week_short_name_BG
    , cy_partial_week_short_name_CS
    , cy_partial_week_short_name_DA
    , cy_partial_week_short_name_EL
    , cy_partial_week_short_name_ES
    , cy_partial_week_short_name_FI
    , cy_partial_week_short_name_FR
    , cy_partial_week_short_name_HR
    , cy_partial_week_short_name_HU
    , cy_partial_week_short_name_IT
    , cy_partial_week_short_name_LT
    , cy_partial_week_short_name_NL
    , cy_partial_week_short_name_PL
    , cy_partial_week_short_name_PT
    , cy_partial_week_short_name_RO
    , cy_partial_week_short_name_SH
    , cy_partial_week_short_name_SK
    , cy_partial_week_short_name_SL
    , cy_partial_week_short_name_SV
) AS
SELECT 
 cw.cy_week cy_week_partial_week_id1
,CASE WHEN cw.cy_week_part_full_week_fg=1 THEN 9 ELSE cw.week_part_seq END cy_week_partial_week_id2
,CASE WHEN cy_week_partial_week_id2=9 
      THEN TRIM(TO_CHAR(cw.cy))||' KW '||TRIM(TO_CHAR(cw.WEEK_OF_YEAR, '00'))
      ELSE TRIM(TO_CHAR(cw.cy))||' KW '||TRIM(TO_CHAR(cw.WEEK_OF_YEAR, '00'))||'/'||TRIM(TO_CHAR(cw.week_part_seq, '0'))
      END cy_week_partial_week_name
,cw.cy_month
,cw.bus_year busyear
,10*cy_week_partial_week_id1+cy_week_partial_week_id2 cy_week_partial_week_id
,ROW_NUMBER () OVER (PARTITION BY cw.cy_month ORDER BY cw.cy_week_part ASC) partialweek_in_mth_seq_asc
,ROW_NUMBER () OVER (PARTITION BY cw.cy_month ORDER BY cw.cy_week_part DESC) partialweek_in_mth_seq_desc
,TRIM(fdow.day_of_week_short_name)||' - '||TRIM(ldow.day_of_week_short_name) cy_partial_week_short_name
,TRIM(fdow.day_of_week_short_name_DE)||' - '||TRIM(ldow.day_of_week_short_name_DE) cy_partial_week_short_name_DE
,TRIM(fdow.day_of_week_short_name_EN)||' - '||TRIM(ldow.day_of_week_short_name_EN) cy_partial_week_short_name_EN
,TRIM(fdow.day_of_week_short_name_BG)||' - '||TRIM(ldow.day_of_week_short_name_BG) cy_partial_week_short_name_BG
,TRIM(fdow.day_of_week_short_name_CS)||' - '||TRIM(ldow.day_of_week_short_name_CS) cy_partial_week_short_name_CS
,TRIM(fdow.day_of_week_short_name_DA)||' - '||TRIM(ldow.day_of_week_short_name_DA) cy_partial_week_short_name_DA
,TRIM(fdow.day_of_week_short_name_EL)||' - '||TRIM(ldow.day_of_week_short_name_EL) cy_partial_week_short_name_EL
,TRIM(fdow.day_of_week_short_name_ES)||' - '||TRIM(ldow.day_of_week_short_name_ES) cy_partial_week_short_name_ES
,TRIM(fdow.day_of_week_short_name_FI)||' - '||TRIM(ldow.day_of_week_short_name_FI) cy_partial_week_short_name_FI
,TRIM(fdow.day_of_week_short_name_FR)||' - '||TRIM(ldow.day_of_week_short_name_FR) cy_partial_week_short_name_FR
,TRIM(fdow.day_of_week_short_name_HR)||' - '||TRIM(ldow.day_of_week_short_name_HR) cy_partial_week_short_name_HR
,TRIM(fdow.day_of_week_short_name_HU)||' - '||TRIM(ldow.day_of_week_short_name_HU) cy_partial_week_short_name_HU
,TRIM(fdow.day_of_week_short_name_IT)||' - '||TRIM(ldow.day_of_week_short_name_IT) cy_partial_week_short_name_IT
,TRIM(fdow.day_of_week_short_name_LT)||' - '||TRIM(ldow.day_of_week_short_name_LT) cy_partial_week_short_name_LT
,TRIM(fdow.day_of_week_short_name_NL)||' - '||TRIM(ldow.day_of_week_short_name_NL) cy_partial_week_short_name_NL
,TRIM(fdow.day_of_week_short_name_PL)||' - '||TRIM(ldow.day_of_week_short_name_PL) cy_partial_week_short_name_PL
,TRIM(fdow.day_of_week_short_name_PT)||' - '||TRIM(ldow.day_of_week_short_name_PT) cy_partial_week_short_name_PT
,TRIM(fdow.day_of_week_short_name_RO)||' - '||TRIM(ldow.day_of_week_short_name_RO) cy_partial_week_short_name_RO
,TRIM(fdow.day_of_week_short_name_SH)||' - '||TRIM(ldow.day_of_week_short_name_SH) cy_partial_week_short_name_SH
,TRIM(fdow.day_of_week_short_name_SK)||' - '||TRIM(ldow.day_of_week_short_name_SK) cy_partial_week_short_name_SK
,TRIM(fdow.day_of_week_short_name_SL)||' - '||TRIM(ldow.day_of_week_short_name_SL) cy_partial_week_short_name_SL
,TRIM(fdow.day_of_week_short_name_SV)||' - '||TRIM(ldow.day_of_week_short_name_SV) cy_partial_week_short_name_SV

FROM P_LEW_BIL.T_DIM_CAL_WEEK_PARTIAL_2 AS cw
INNER JOIN P_LEW_BIL.T_DIM_CAL_DAY_OF_WEEK_2 AS fdow
 ON cw.cy_week_part_begin_day_of_week = fdow.day_of_week
INNER JOIN P_LEW_BIL.T_DIM_CAL_DAY_OF_WEEK_2 AS ldow
 ON cw.cy_week_part_end_day_of_week = ldow.day_of_week

UNION ALL

SELECT 
 cw.cy_week cy_week_partial_week_id1
,9 cy_week_partial_week_id2
,TRIM(TO_CHAR(cw.cy))||' KW '||TRIM(TO_CHAR(cw.WEEK_OF_YEAR, '00')) cy_week_partial_week_name
,cw.cy_month
,cw.bus_year busyear
,10*cy_week_partial_week_id1+cy_week_partial_week_id2 cy_week_partial_week_id
,NULL AS partialweek_in_mth_seq_asc
,NULL AS partialweek_in_mth_seq_desc
,TRIM(fdow.day_of_week_short_name)||' - '||TRIM(ldow.day_of_week_short_name) cy_partial_week_short_name
,TRIM(fdow.day_of_week_short_name_DE)||' - '||TRIM(ldow.day_of_week_short_name_DE) cy_partial_week_short_name_DE
,TRIM(fdow.day_of_week_short_name_EN)||' - '||TRIM(ldow.day_of_week_short_name_EN) cy_partial_week_short_name_EN
,TRIM(fdow.day_of_week_short_name_BG)||' - '||TRIM(ldow.day_of_week_short_name_BG) cy_partial_week_short_name_BG
,TRIM(fdow.day_of_week_short_name_CS)||' - '||TRIM(ldow.day_of_week_short_name_CS) cy_partial_week_short_name_CS
,TRIM(fdow.day_of_week_short_name_DA)||' - '||TRIM(ldow.day_of_week_short_name_DA) cy_partial_week_short_name_DA
,TRIM(fdow.day_of_week_short_name_EL)||' - '||TRIM(ldow.day_of_week_short_name_EL) cy_partial_week_short_name_EL
,TRIM(fdow.day_of_week_short_name_ES)||' - '||TRIM(ldow.day_of_week_short_name_ES) cy_partial_week_short_name_ES
,TRIM(fdow.day_of_week_short_name_FI)||' - '||TRIM(ldow.day_of_week_short_name_FI) cy_partial_week_short_name_FI
,TRIM(fdow.day_of_week_short_name_FR)||' - '||TRIM(ldow.day_of_week_short_name_FR) cy_partial_week_short_name_FR
,TRIM(fdow.day_of_week_short_name_HR)||' - '||TRIM(ldow.day_of_week_short_name_HR) cy_partial_week_short_name_HR
,TRIM(fdow.day_of_week_short_name_HU)||' - '||TRIM(ldow.day_of_week_short_name_HU) cy_partial_week_short_name_HU
,TRIM(fdow.day_of_week_short_name_IT)||' - '||TRIM(ldow.day_of_week_short_name_IT) cy_partial_week_short_name_IT
,TRIM(fdow.day_of_week_short_name_LT)||' - '||TRIM(ldow.day_of_week_short_name_LT) cy_partial_week_short_name_LT
,TRIM(fdow.day_of_week_short_name_NL)||' - '||TRIM(ldow.day_of_week_short_name_NL) cy_partial_week_short_name_NL
,TRIM(fdow.day_of_week_short_name_PL)||' - '||TRIM(ldow.day_of_week_short_name_PL) cy_partial_week_short_name_PL
,TRIM(fdow.day_of_week_short_name_PT)||' - '||TRIM(ldow.day_of_week_short_name_PT) cy_partial_week_short_name_PT
,TRIM(fdow.day_of_week_short_name_RO)||' - '||TRIM(ldow.day_of_week_short_name_RO) cy_partial_week_short_name_RO
,TRIM(fdow.day_of_week_short_name_SH)||' - '||TRIM(ldow.day_of_week_short_name_SH) cy_partial_week_short_name_SH
,TRIM(fdow.day_of_week_short_name_SK)||' - '||TRIM(ldow.day_of_week_short_name_SK) cy_partial_week_short_name_SK
,TRIM(fdow.day_of_week_short_name_SL)||' - '||TRIM(ldow.day_of_week_short_name_SL) cy_partial_week_short_name_SL
,TRIM(fdow.day_of_week_short_name_SV)||' - '||TRIM(ldow.day_of_week_short_name_SV) cy_partial_week_short_name_SV

FROM P_LEW_BIL.T_DIM_CAL_WEEK_PARTIAL_2 AS cw
INNER JOIN P_LEW_BIL.T_DIM_CAL_DAY_OF_WEEK_2 AS fdow
 ON cw.cy_week_part_begin_day_of_week = fdow.day_of_week
INNER JOIN P_LEW_BIL.T_DIM_CAL_DAY_OF_WEEK_2 AS ldow
 ON cw.cy_week_part_end_day_of_week = ldow.day_of_week
WHERE cw.week_part_seq=2
;
