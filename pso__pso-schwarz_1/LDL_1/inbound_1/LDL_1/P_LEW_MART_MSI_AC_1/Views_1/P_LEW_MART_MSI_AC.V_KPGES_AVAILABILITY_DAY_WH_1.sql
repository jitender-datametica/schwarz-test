CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_KPGES_AVAILABILITY_DAY_WH_1
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
client_id
, wh_id
, aspect_id
, dat_calendar
, indicator_id
, availability_fg
 )
AS
SELECT
client_id,
wh_id,
aspect_id,
dat_calendar,
indicator_id,
availability_fg
FROM p_lew_mart_msi.v_kpges_availability_day_wh_1;


