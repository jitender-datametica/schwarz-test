CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_SAULE_CONFIG_REQUESTS
(
  req_id
, status_id
, req_date
, requestor
, approver
, status_desc
)
AS
   SELECT
     req_id,
   status_id,
   req_date,
   requestor,
   approver,
   status_desc
  FROM p_lew_process_mstr.t_saule_config_requests
;