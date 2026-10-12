CREATE OR REPLACE VIEW ldl_p_lew_mart_pit_onprem.v_pit_apt_core_advert_medium_client_2 (client_id, advert_medium,
deleted_fg) AS SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
  CASE
  WHEN advertising_medium_cd = ''
  THEN 'empty'
  ELSE CAST(advertising_medium_cd AS STRING)
  END AS advert_medium,
 MIN(deleted_fg) AS deleted_fg
FROM ldl_p_lew_mart_pit_onprem.v_pit_apt_core_item_promotion_medium_2 AS APT
GROUP BY client_id,
 advert_medium;