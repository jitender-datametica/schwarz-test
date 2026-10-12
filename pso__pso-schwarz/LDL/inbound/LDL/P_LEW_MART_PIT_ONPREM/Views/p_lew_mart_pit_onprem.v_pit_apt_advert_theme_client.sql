CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_ADVERT_THEME_CLIENT
(
  client_id
, advert_theme_sid
, advert_theme
, deleted_fg
, excluded_fg
, dwh_created
)
AS
(SELECT
Apt.client_id           AS client_id
,Apt.advert_theme_sid    AS advert_theme_sid
,Apt.advert_theme        AS advert_theme
,Apt.deleted_fg          AS deleted_fg
,Apt.excluded_fg         AS excluded_fg
,Apt.dwh_created         AS dwh_created
FROM p_lew_mart_pit_onprem.t_pit_apt_advert_theme_client AS Apt
);