CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_APT_ANALYTICS_ADVERT_MEDIUM
(
     client_id
,          anl_advert_medium_sid      --  version in analytics tables, until we unify everything
,          advert_medium
,          advert_medium_sort_val
,          advert_medium_group_sid
,          advert_medium_group
,          advert_medium_group_sort_val
,          advert_medium_ignore_fg
,          advert_medium_delete_fg
)
AS
(SELECT
Aam.client_id                       AS client_id
,Aam.anl_advert_medium_sid           AS anl_advert_medium_sid
,Aam.advert_medium                   AS advert_medium
,Aam.advert_medium_sort_val          AS advert_medium_sort_val
,Aam.advert_medium_group_sid         AS advert_medium_group_sid
,Aam.advert_medium_group             AS advert_medium_group
,Aam.advert_medium_group_sort_val    AS advert_medium_group_sort_val
,Aam.advert_medium_ignore_fg         AS advert_medium_ignore_fg
,Aam.advert_medium_delete_fg         AS advert_medium_delete_fg
FROM p_lew_mart_pit_onprem.v_pit_apt_analytics_advert_medium        AS Aam
);