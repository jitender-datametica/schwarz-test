CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_wawi_bestandartikel_act_1 AS SELECT client_id,
  CASE
  WHEN client_id = 13 AND wh_nr = 600
  THEN 60
  WHEN client_id = 18 AND wh_nr = 20
  THEN 4
  WHEN client_id = 21 AND wh_nr = 20
  THEN 22
  ELSE wh_nr
  END AS wh_nr,
 artikelnr,
 menge,
 retail_price,
 scn,
 DATE(datum) AS datum,
 dwh_valid_from,
 dwh_valid_to,
 MAX(dwh_updated) OVER (PARTITION BY CAST(client_id AS STRING), wh_nr RANGE BETWEEN UNBOUNDED PRECEDING AND
  UNBOUNDED FOLLOWING) AS dwh_updated,
 deleted_fg
FROM ldl_logop_data.t_wawi_bestandartikel_act_1;