CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_mfs_nio_error_2 (client_id, wh_id, hu_ident, log_seq, crtd_on_dt,
com_point, hu_stat, hu_stat_short, err_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 wh_id,
 huident AS hu_ident,
 log_seq,
 DATE(utc_timestamp) AS crtd_on_dt,
 cp AS com_point,
 hu_status AS hu_stat,
 hu_status_short AS hu_stat_short,
  CASE
  WHEN client_id <> 23
  THEN IF((cp LIKE 'IB-IP1%' OR cp LIKE 'DI-IP1%' OR cp LIKE 'B1-IP1%' OR cp LIKE 'F1-IP1%' OR cp LIKE 'B2-IP1%' OR cp
        LIKE 'P2-IP1%' OR cp LIKE 'TI-IP1%') AND (hu_status_short LIKE 'CLOW' OR hu_status_short LIKE 'COBE' OR
       hu_status_short = 'CFFR'), NULL, hu_status_short)
  WHEN client_id = 23
  THEN IF(cp LIKE 'TI%' AND hu_status_short IS NOT NULL, hu_status_short, NULL)
  ELSE NULL
  END AS err_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_logop_data.t_sapewm_niohistory_2
WHERE (client_id, wh_id) IN ((1, 9), (8, 6), (10, 7), (13, 60), (18, 4), (23, 18), (25, 96));