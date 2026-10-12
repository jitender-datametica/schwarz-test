CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_lin_datenfreigabe_mail_1 (kjmo, akt_kjmo, bericht_id,
versendet_fg) AS SELECT V01.kjmo,
 RANK() OVER (PARTITION BY v02.bericht_id ORDER BY V01.kjmo IS NULL, V01.kjmo) AS akt_kjmo,
 v02.bericht_id,
 MAX(CASE
   WHEN V03.user_id IS NOT NULL
   THEN v02.versendet_fg
   ELSE 0
   END) AS versendet_fg
FROM kfl_production_dbp_msi_v_view.v_lin_datenfreigabe_1 AS V01
 INNER JOIN (SELECT service_id,
    CASE
    WHEN SUBSTR(service_name, 1, 10) = 'ds_user_vs'
    THEN 'ds_user_int'
    ELSE SUBSTR(service_name, 1, 10)
    END AS ds_user,
   SUBSTR(service_name, 12, 14) AS bericht_id,
   CAST(status_1 AS BIGNUMERIC) AS versendet_fg,
    CASE
    WHEN SUBSTR(service_name, 9, 2) = 'vs_1'
    THEN - 1
    WHEN SUBSTR(service_name, 9, 2) = 'de'
    THEN 1
    WHEN SUBSTR(service_name, 9, 2) = 'cz'
    THEN 2
    WHEN SUBSTR(service_name, 9, 2) = 'pl'
    THEN 3
    WHEN SUBSTR(service_name, 9, 2) = 'sk'
    THEN 5
    WHEN SUBSTR(service_name, 9, 2) = 'hr'
    THEN 6
    WHEN SUBSTR(service_name, 9, 2) = 'ro'
    THEN 7
    WHEN SUBSTR(service_name, 9, 2) = 'bg'
    THEN 8
    ELSE NULL
    END AS mandant_id
  FROM kfl_production_dbp_msi_v_view.v_ncs_log_1
  WHERE SUBSTR(service_name, 12, 14) IN ('vis_lin_15_1_1', 'vis_lin_15_1_2')) AS v02 ON V01.kjmo = CAST(v02.service_id AS FLOAT64)
    AND V01.mandant_id = v02.mandant_id
 LEFT JOIN kfl_production_dbp_msi.akt_msi_user_1 AS V03 ON v02.ds_user = V03.user_id
WHERE V01.lin_freigabe_fg = 1
 AND V01.vertrieb_fg = 1
GROUP BY V01.kjmo,
 v02.bericht_id;