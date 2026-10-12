CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_apt_core_advert_theme_client_1 (client_id, advert_theme, deleted_fg
, excluded_fg) AS SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
  CASE
  WHEN advertising_theme = ''
  THEN 'empty'
  ELSE CAST(advertising_theme AS STRING)
  END AS advert_theme,
 MIN(deleted_fg) AS deleted_fg,
 MIN(excluded_fg) AS excluded_fg
FROM ldl_p_lew_mart_pit_onprem.v_pit_apt_core_item_promotion_1 AS APT
GROUP BY client_id,
 advert_theme;