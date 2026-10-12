CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_LIN_DATENFREIGABE_MAIL_2
(
kjmo
,akt_kjmo
,bericht_id
,versendet_fg
)
AS
   SELECT kjmo, RANK() OVER (PARTITION BY bericht_id ORDER BY kjmo DESC NULLS LAST), bericht_id, versendet_fg

   FROM
   (
   SELECT v01.kjmo, bericht_id, MAX(CASE WHEN v03.user_id IS NOT NULL THEN v02.versendet_fg ELSE 0 END) AS versendet_fg
   FROM dbp_msi_v_view.v_lin_datenfreigabe_2 v01
   INNER JOIN (SELECT service_id, CASE WHEN SUBSTR(service_name,1,10) = 'ds_user_vs' THEN 'ds_user_int'
   ELSE SUBSTR(service_name,1,10)
   END AS ds_user, SUBSTR(service_name,12,14) AS bericht_id, CAST(status_2 AS INTEGER) AS versendet_fg, CASE SUBSTR(service_name,9,2)  WHEN 'vs_2' THEN -1
   WHEN 'de' THEN 1
   WHEN 'cz' THEN 2
   WHEN 'pl' THEN 3
   WHEN 'sk' THEN 5
   WHEN 'hr' THEN 6
   WHEN 'ro' THEN 7
   WHEN 'bg' THEN 8
   END AS mandant_id
   FROM dbp_msi_v_view.v_ncs_log_2
   WHERE SUBSTR(service_name,12,14) IN ('vis_lin_15_1_1','vis_lin_15_1_2')

   ) v02
   ON v01.kjmo = v02.service_id
   AND v01.mandant_id = v02.mandant_id
   LEFT JOIN dbp_msi.akt_msi_user_2 v03
   ON v02.ds_user = v03.user_id

   WHERE v01.lin_freigabe_fg = 1
   AND v01.vertrieb_fg = 1
   GROUP BY v01.kjmo, bericht_id
   ) dt1;