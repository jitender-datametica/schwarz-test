CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_fact_process_to_store_area_count_1 (dwh_tenant_cd, process_sid,
ft, nf, bs, bt, fl, pf, vt, im, fs, ka, la, lg, ff, `if`) AS SELECT dwh_tenant_cd,
 process_sid,
 SUM(CASE
   WHEN store_area_cd = 'FT'
   THEN 1
   ELSE 0
   END) AS ft,
 SUM(CASE
   WHEN store_area_cd = 'NF'
   THEN 1
   ELSE 0
   END) AS nf,
 SUM(CASE
   WHEN store_area_cd = 'BS'
   THEN 1
   ELSE 0
   END) AS bs,
 SUM(CASE
   WHEN store_area_cd = 'BT'
   THEN 1
   ELSE 0
   END) AS bt,
 SUM(CASE
   WHEN store_area_cd = 'FL'
   THEN 1
   ELSE 0
   END) AS fl,
 SUM(CASE
   WHEN store_area_cd = 'PF'
   THEN 1
   ELSE 0
   END) AS pf,
 SUM(CASE
   WHEN store_area_cd = 'VT'
   THEN 1
   ELSE 0
   END) AS vt,
 SUM(CASE
   WHEN store_area_cd = 'IM'
   THEN 1
   ELSE 0
   END) AS im,
 SUM(CASE
   WHEN store_area_cd = 'FS'
   THEN 1
   ELSE 0
   END) AS fs,
 SUM(CASE
   WHEN store_area_cd = 'KA'
   THEN 1
   ELSE 0
   END) AS ka,
 SUM(CASE
   WHEN store_area_cd = 'LA'
   THEN 1
   ELSE 0
   END) AS la,
 SUM(CASE
   WHEN store_area_cd = 'LG'
   THEN 1
   ELSE 0
   END) AS lg,
 SUM(CASE
   WHEN store_area_cd = 'FF'
   THEN 1
   ELSE 0
   END) AS ff,
 SUM(CASE
   WHEN store_area_cd = 'IF'
   THEN 1
   ELSE 0
   END) AS `if`
FROM ugs_aris_production_core.t_fact_process_to_store_area_1
WHERE dwh_valid_fg
GROUP BY dwh_tenant_cd,
 process_sid;