CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_REGION_1
AS
   SELECT
   r.mandant_id, CASE
   WHEN r.region_id < 0 THEN -r.mandant_id
   ELSE region_id
   END AS region_id, MAX(CASE
   WHEN r.region_id >= 0 AND m.mandant_id = 8  THEN dbp_process.transcriptc(r.region_name)
   WHEN r.region_id >= 0 AND m.mandant_id <> 8 THEN r.region_name
   ELSE m.mandant_kbez
   END) AS region_name, MAX(CASE
   WHEN r.region_id >= 0 AND m.mandant_id = 8  THEN dbp_process.transcriptc(r.region_name)
   WHEN r.region_id >= 0 AND m.mandant_id <> 8 THEN r.region_name
   ELSE m.mandant_kbez
   END) AS region_name_de, MAX(CASE
   WHEN r.region_id >= 0 AND m.mandant_id = 8  THEN dbp_process.transcriptc(r.region_name)
   WHEN r.region_id >= 0 AND m.mandant_id <> 8 THEN r.region_name
   ELSE m.mandant_kbez
   END) AS region_name_cz, MAX(CASE
   WHEN r.region_id >= 0 AND m.mandant_id = 8  THEN dbp_process.transcriptc(r.region_name)
   WHEN r.region_id >= 0 AND m.mandant_id <> 8 THEN r.region_name
   ELSE m.mandant_kbez
   END) AS region_name_pl, MAX(CASE
   WHEN r.region_id >= 0 AND m.mandant_id = 8  THEN dbp_process.transcriptc(r.region_name)
   WHEN r.region_id >= 0 AND m.mandant_id <> 8 THEN r.region_name
   ELSE m.mandant_kbez
   END) AS region_name_sk, MAX(CASE
   WHEN r.region_id >= 0 AND m.mandant_id = 8  THEN dbp_process.transcriptc(r.region_name)
   WHEN r.region_id >= 0 AND m.mandant_id <> 8 THEN r.region_name
   ELSE m.mandant_kbez
   END) AS region_name_hr, MAX(CASE
   WHEN r.region_id >= 0 AND m.mandant_id = 8  THEN dbp_process.transcriptc(r.region_name)
   WHEN r.region_id >= 0 AND m.mandant_id <> 8 THEN r.region_name
   ELSE m.mandant_kbez
   END) AS region_name_ro, MAX(CASE
   WHEN r.region_id >= 0 AND m.mandant_id <> 8  THEN dbp_process.transcriptc(r.region_name)
   WHEN r.region_id >= 0 AND m.mandant_id = 8 THEN r.region_name
   ELSE m.mandant_kbez
   END) region_name_bg
   FROM dbp_view.v_region_1 r
   INNER JOIN dbp_view.v_mandant_1 m
   ON r.mandant_id= m.mandant_id
   WHERE
   CASE WHEN m.mandant_kbez='D' THEN 'DE' ELSE mandant_kbez END = r.land_id
   GROUP BY
   r.mandant_id, region_id;