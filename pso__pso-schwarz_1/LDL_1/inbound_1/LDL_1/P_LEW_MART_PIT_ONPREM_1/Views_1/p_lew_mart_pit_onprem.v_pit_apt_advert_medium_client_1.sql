CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_ADVERT_MEDIUM_CLIENT_1
(
  client_id
, advert_medium_sid
, anl_advert_medium_sid
, advert_medium
, advert_medium_sort_val
, advert_medium_group_sid
, advert_medium_group
, advert_medium_group_sort_val
, advert_medium_ignore_fg
, advert_medium_delete_fg
, deleted_fg
, dwh_created
)
AS
(SELECT
Apt.client_id                       AS client_id
,Apt.advert_medium_sid               AS advert_medium_sid
,Apt.anl_advert_medium_sid           AS advert_medium_sid
,Apt.advert_medium                   AS advert_medium
,Apt.advert_medium_sort_val          AS advert_medium_sort_val
,Apt.advert_medium_group_sid         AS advert_medium_group_sid
,Apt.advert_medium_group             AS advert_medium_group
,Apt.advert_medium_group_sort_val    AS advert_medium_group_sort_val
,Apt.advert_medium_ignore_fg         AS advert_medium_ignore_fg
,Apt.advert_medium_delete_fg         AS advert_medium_delete_fg
,Apt.deleted_fg                      AS deleted_fg
,Apt.dwh_created                     AS dwh_created
FROM p_lew_mart_pit_onprem.t_pit_apt_advert_medium_client_1 AS Apt
);