CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_CLIENT_PROG_HIST_2
(
  client_id
, prog_sid
, prog_start_tmsp
, prog_end_tmsp
, full_client_start_tmsp
, full_client_end_tmsp
, client_repo_start_tmsp
, load_id
, dwh_inserted
, dwh_updated
)
AS
   SELECT
     client_id,
   prog_sid,
   prog_start_tmsp,
   prog_end_tmsp,
   full_client_start_tmsp,
   full_client_end_tmsp,
   client_repo_start_tmsp,
   load_id,
   dwh_inserted,
   dwh_updated
  FROM p_lew_mart_lead.t_client_prog_hist_2
;