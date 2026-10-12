CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_KPGES_DAY_COUNTRY
(
  client_id
, indicator_id
, dat_formdate
, val_indicator
, currency_iso_cd
, dat_dayend
, curr_tot_id
)
AS
   SELECT
     client_id,
   indicator_id,
   dat_formdate,
   val_indicator,
   currency_iso_cd,
   dat_dayend,
   curr_tot_id
  FROM p_lew_mart_lead.v_kpges_day_country
;