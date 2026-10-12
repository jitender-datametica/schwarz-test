CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_EXCHANGE_RATE_REPORT_ASIS_1
AS
   SELECT client_id,
   curr_sid_from,
   curr_sid_to,
   curr_cd_from,
   curr_cd_to,
   exchange_rate
  FROM p_lew_bil.v_exchange_rate_report_asis_1
;