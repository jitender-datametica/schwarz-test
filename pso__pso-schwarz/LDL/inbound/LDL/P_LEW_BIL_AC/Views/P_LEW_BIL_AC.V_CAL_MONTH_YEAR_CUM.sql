/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_CAL_MONTH_YEAR_CUM
#----------------------------------------------------------------------------
# History:
#  1.0  2021-09-27    Jaroslaw Syrokosz        Initial
#                                              20210921_2939_TransAllCal_updts
#                                              https://jira.schwarz/browse/REP2-10367
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_CAL_MONTH_YEAR_CUM COMMENT = 'Calendar month year cumulative'
(
  cy_month COMMENT 'Year and month identifier'
, cy_month_year_cum COMMENT 'Cumulative month'
, cy_month_year_cum_py COMMENT 'Cumulative month (previous year)'
, cy_month_year_cum_ppy COMMENT 'Cumulative month (previous, previous year)'
)
AS
SELECT
  cy_month
, cy_month_year_cum
, cy_month_year_cum_py
, cy_month_year_cum_ppy
FROM P_LEW_BIL.V_CAL_MONTH_YEAR_CUM
;

