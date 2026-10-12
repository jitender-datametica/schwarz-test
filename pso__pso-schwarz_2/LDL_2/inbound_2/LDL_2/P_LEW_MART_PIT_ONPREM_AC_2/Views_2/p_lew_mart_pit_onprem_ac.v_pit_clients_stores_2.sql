CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_CLIENTS_STORES_2
(
     client_id

,          effective_client_id

,          store_sid

,          store_grp_luxembourg_fg

,          orig_store_nr

,          store_name
)
AS
(SELECT
CStores.client_id                  AS client_id
,CStores.effective_client_id        AS effective_client_id
,CStores.store_sid                  AS store_sid
,CStores.store_grp_luxembourg_fg    AS store_grp_luxembourg_fg
,CStores.orig_store_nr              AS orig_store_nr
,CStores.store_name                 AS store_name
FROM p_lew_mart_pit_onprem.t_pit_clients_stores_2        AS CStores
);