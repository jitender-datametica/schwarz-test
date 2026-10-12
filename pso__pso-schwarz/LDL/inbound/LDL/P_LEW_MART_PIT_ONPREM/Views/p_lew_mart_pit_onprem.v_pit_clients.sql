CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_CLIENTS
(
     client_id
,          effective_client_id
,          luxembourg_fg
)
AS
(SELECT
Clients.client_id              AS client_id
,Clients.effective_client_id    AS effective_client_id
,Clients.luxembourg_fg          AS luxembourg_fg
FROM p_lew_mart_pit_onprem.t_pit_clients        AS Clients
);