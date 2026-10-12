CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_sapewm_mfs_tab_nio_artikel_2 (client_id OPTIONS(description='Client ID'),
wh_id OPTIONS(description='Warehouse ID'), hu_ident OPTIONS(description='NIO History Handling Unit_2 Identification'),
crtd_on_dt OPTIONS(description='NIO History Created on'), artikel_id OPTIONS(description='Product Item_2 ID'),
artikel_desc OPTIONS(description='Product Item_2 Description')) AS WITH RMV_DPL AS (SELECT client_id,
   wh_id,
   huident AS hu_ident,
   DATE(utc_timestamp) AS crtd_on_dt,
   matnr AS artikel_id,
   maktx AS artikel_desc,
   dwh_load_id,
   dwh_created,
   dwh_updated,
   ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(wh_id AS STRING), huident, DATE(utc_timestamp), matnr
      ORDER BY DATE(utc_timestamp) IS NULL, DATE(utc_timestamp)) AS rn
  FROM ldl_logop_data.t_sapewm_niohistory_2) (SELECT client_id,
   wh_id,
   hu_ident,
   crtd_on_dt,
   artikel_id,
   artikel_desc
  FROM RMV_DPL
  WHERE rn = 1);