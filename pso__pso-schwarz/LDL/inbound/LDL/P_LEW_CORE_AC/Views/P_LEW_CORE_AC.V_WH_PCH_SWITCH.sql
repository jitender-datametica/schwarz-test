CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_WH_PCH_SWITCH
(
  client_id
, wh_id
, loc_sid_wh
, pch_bnl_switch_fg
, switch_date
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
   client_id,
   wh_id,
   loc_sid_wh,
   pch_bnl_switch_fg,
   switch_date,
   dwh_load_id,
   dwh_created,
   dwh_updated
   FROM p_lew_core.t_wh_pch_switch;