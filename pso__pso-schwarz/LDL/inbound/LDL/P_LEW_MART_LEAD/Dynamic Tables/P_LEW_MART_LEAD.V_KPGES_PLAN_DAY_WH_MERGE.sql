CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_KPGES_PLAN_DAY_WH_MERGE
 /*
 #DescStart#
 #$Revision: 10781 $, $LastChangedBy: ekun $
 #SubjectAreas#: KPGES Views
 #DescEnd#
 */
(
  client_id
, wh_id
, loc_sid_wh
, aspect_id
, indicator_id
, dat_formdate
, val_indicator
, currency_iso_cd
, dat_dayend
 )

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
SELECT
iday.client_id,
iday.org_unit_nr AS wh_id,
vwh.loc_sid_wh,
CASE WHEN iday.org_type_id = 50 THEN 1 ELSE 2 END AS aspect_id,
iday.indicator_id,
iday.dat_formdate,
CASE WHEN iday.indicator_id IN (105,108,112,117,120,125,126,133,135,136,146,155,
156,157,158,161,162,163,168,169,170,172,174,177,179,203,204,209,210,212,216,
225,228,229,230,238,240,242,243,244,250,251,252,256,257,258,259,260,261,270,
271,272,273,276,280,281,282,283,284,286,288,289,151,293,302,304,306,308,310,312,314)
THEN iday.val_indicator / cry.rate_currency_exchange ELSE iday.val_indicator END AS val_indicator,
cry.currency_iso_cd,
iday.dat_dayend
FROM p_lew_bil_ac.v_kpi_day AS iday
INNER JOIN p_lew_bil_ac.v_warehouse AS vwh
ON  iday.client_id = vwh.client_id
AND iday.org_unit_nr = vwh.src_wh_id
AND vwh.dwh_actual_fg  = 1
INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
ON  iday.client_id = cry.client_id
AND iday.org_type_id IN (50, 60)
AND iday.indicator_type_id = 2
AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
;
