CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_APT_CORE_ADVERT_MEDIUM_CLIENT_1
(
     client_id

,          advert_medium

,          deleted_fg
)
AS
(SELECT
Acmc.client_id       AS client_id
,Acmc.advert_medium    AS advert_medium
,Acmc.deleted_fg      AS deleted_fg
FROM p_lew_mart_pit_onprem.v_pit_apt_core_advert_medium_client_1        AS Acmc
);