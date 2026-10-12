CREATE OR REPLACE VIEW p_lew_mart_lead_ac.v_agg_wh_day_itemgroup_pch_1
/*
#DescStart#
#$Revision: 14779 $, $LastChangedBy: tbachmann $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
  client_id
, loc_sid_wh
, wh_id
, aspect_id
, itemgroup_int_id
, pcwo_reason_id
, sfotype_id
, currency_iso_cd
, pch_bnl_switch_fg
, dwh_cal_dt
, val_price_change
)
AS
SELECT
v.client_id,
v.loc_sid_wh,
v.wh_id,
v.aspect_id,
v.itemgroup_int_id,
v.pcwo_reason_id,
v.sfotype_id,
v.currency_iso_cd,
v.pch_bnl_switch_fg,
v.dwh_cal_dt,
v.val_price_change
FROM p_lew_mart_lead.v_agg_wh_day_itemgroup_pch_1 AS v
;

