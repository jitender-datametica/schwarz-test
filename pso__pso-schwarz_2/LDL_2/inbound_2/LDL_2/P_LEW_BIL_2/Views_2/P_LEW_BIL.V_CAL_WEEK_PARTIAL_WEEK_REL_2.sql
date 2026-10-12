/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_CAL_WEEK_PARTIAL_WEEK_REL.
#----------------------------------------------------------------------------
# History:
#  1.0  15.09.2021    Syrokosz, Jaroslaw       First draft 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_CAL_WEEK_PARTIAL_WEEK_REL_2
/*
#DescStart#
#$Revision: 62789 $, $LastChangedBy: jsyrokosz $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    dat_calendar
    , cy_week_partial_week_id1
    , cy_week_partial_week_id2
    , cy_week_partial_week_id
    , cy_day_sequence
) AS
SELECT 
 dcd.cal_dt AS dat_calendar
,cw.cy_week AS cy_week_partial_week_id1
,CASE WHEN cw.cy_week_part_full_week_fg=1 THEN 9 ELSE dcd.week_part_seq END AS cy_week_partial_week_id2
,10*cy_week_partial_week_id1+cy_week_partial_week_id2 AS cy_week_partial_week_id
,dcd.cal_dt_offset AS cy_day_sequence
FROM P_LEW_BIL.t_dim_cal_week_partial_2 cw
INNER JOIN P_LEW_BIL.t_dim_cal_day_2 dcd
 ON cw.cy_week = dcd.cy_week
 AND cw.cy = dcd.cy

UNION 

SELECT 
 dcd.cal_dt AS dat_calendar
,cw.cy_week AS cy_week_partial_week_id1
,9 cy_week_partial_week_id2
,10*cy_week_partial_week_id1+cy_week_partial_week_id2 AS cy_week_partial_week_id
,dcd.cal_dt_offset AS cy_day_sequence
FROM P_LEW_BIL.t_dim_cal_week_partial_2 cw
INNER JOIN P_LEW_BIL.t_dim_cal_day_2 dcd
 ON cw.cy_week = dcd.cy_week
 AND cw.cy = dcd.cy
WHERE cw.week_part_seq=2

UNION ALL

SELECT 
 dcd.cal_dt AS dat_calendar
,cw.cy_week AS cy_week_partial_week_id1
,9 cy_week_partial_week_id2
,10*cy_week_partial_week_id1+cy_week_partial_week_id2 AS cy_week_partial_week_id
,dcd.cal_dt_offset AS cy_day_sequence
FROM P_LEW_BIL.t_dim_cal_week_partial_2 cw
INNER JOIN P_LEW_BIL.t_dim_cal_day_2 dcd
 ON cw.cy_week = dcd.cy_week
 AND cw.cy = dcd.cy
WHERE dcd.MONTH_OF_YEAR = 12
 AND cw.cy_week_part_full_week_fg = 0
 AND dcd.WEEK_OF_YEAR IN (1,52,53)
;
