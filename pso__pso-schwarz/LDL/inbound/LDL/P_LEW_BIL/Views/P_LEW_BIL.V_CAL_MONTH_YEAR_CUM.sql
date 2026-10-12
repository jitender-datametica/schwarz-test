/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_CAL_MONTH_YEAR_CUM
#----------------------------------------------------------------------------
# History:
#  1.0  2021-09-27    Jaroslaw Syrokosz        Initial
#                                              20210921_2939_TransAllCal_updts
#                                              https://jira.schwarz/browse/REP2-10367
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_CAL_MONTH_YEAR_CUM
(
  cy_month
, cy_month_year_cum
, cy_month_year_cum_py
, cy_month_year_cum_ppy
)
AS
SELECT
  cal1.cy_month        AS cy_month
, cal2.cy_month        AS cy_month_year_cum
, cal2.cy_month - 100  AS cy_month_year_cum_py
, cal2.cy_month - 200  AS cy_month_year_cum_ppy
FROM P_LEW_CORE_AC.V_CAL_MONTH AS cal1
INNER JOIN P_LEW_CORE_AC.V_CAL_MONTH AS cal2
 ON cal2.cy_month_seq BETWEEN cal1.cy_month_seq - 11 AND cal1.cy_month_seq
;
