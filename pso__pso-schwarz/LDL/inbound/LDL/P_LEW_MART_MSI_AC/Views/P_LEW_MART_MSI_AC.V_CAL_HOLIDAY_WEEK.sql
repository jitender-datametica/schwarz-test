CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CAL_HOLIDAY_WEEK
/*
#DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
country_id
, cy_week_holiday
, holidaytype_id
 )
AS
SELECT
country_id,
cy_week_holiday,
holidaytype_id
FROM p_lew_mart_msi.v_cal_holiday_week;


