CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_APT_CORE_ADVERT_THEME_CLIENT_2

(
  client_id
, advert_theme
, deleted_fg
, excluded_fg
)
AS
(SELECT
CAST( Apt.client_id AS INTEGER)                                               AS client_id
,CASE WHEN Apt.advertising_theme = '' THEN 'empty'::VARCHAR(100)
      ELSE
          Apt.advertising_theme::VARCHAR(100)
 END                                                                          AS advert_theme
,MIN ( Apt.deleted_fg )                                                        AS deleted_fg
,MIN ( Apt.excluded_fg )                                                       AS excluded_fg
FROM p_lew_mart_pit_onprem.v_pit_apt_core_item_promotion_2 Apt
GROUP BY 1, 2
);