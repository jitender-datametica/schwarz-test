CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_AGG_DSBRD_CURRENCY_TM_2
(
  client_id
, currency_iso_cd
, curr_tot_id
, tm_lvl_id
, cy_week
, cy_month
, dummytime
)
AS
   SELECT
     client_id,
   currency_iso_cd,
   curr_tot_id,
   tm_lvl_id,
   cy_week,
   cy_month,
   dummytime
  FROM p_lew_process_mstr.v_agg_dsbrd_currency_tm_2
;