CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_APT_CORE_ADVERT_THEME_CLIENT_2
(
     client_id

,          advert_theme

,          deleted_fg

,          excluded_fg
)
AS
(SELECT
Actc.client_id       AS client_id
,Actc.advert_theme    AS advert_theme
,Actc.deleted_fg      AS deleted_fg
,Actc.excluded_fg     AS excluded_fg
FROM p_lew_mart_pit_onprem.v_pit_apt_core_advert_theme_client_2        AS Actc
);