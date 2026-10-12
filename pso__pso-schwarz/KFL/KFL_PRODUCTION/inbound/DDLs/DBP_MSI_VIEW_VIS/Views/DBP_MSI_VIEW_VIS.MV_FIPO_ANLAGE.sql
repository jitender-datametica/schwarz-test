CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_ANLAGE as

   SELECT
   v01.fipo_anlage_id, v01.fipo_antwort_id, TRIM(v02.fipo_anlage_url) || TRIM(v01.fipo_anlage_id) AS fipo_webservice

   FROM dbp_view.v_fipo_anlage v01
   CROSS JOIN dbp_msi_v_view.v_fipo_webservice_url v02 --enthält nur eine Zeile mit URL

   WHERE v01.dat_bis >= CURRENT_DATE
   ;