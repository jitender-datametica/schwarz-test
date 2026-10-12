CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_ref_miss_reason AS SELECT ROUND(SAFE_CAST(code AS BIGNUMERIC), 0) AS
 reason_id,
 MAX(CASE
   WHEN client_id = 23
   THEN description
   ELSE NULL
   END) AS reason_desc,
 MAX(CASE
   WHEN client_id = 1
   THEN description
   ELSE NULL
   END) AS reason_desc_at,
 MAX(CASE
   WHEN client_id = 2
   THEN description
   ELSE NULL
   END) AS reason_desc_be,
 MAX(CASE
   WHEN client_id = 3
   THEN description
   ELSE NULL
   END) AS reason_desc_bg,
 MAX(CASE
   WHEN client_id = 4
   THEN description
   ELSE NULL
   END) AS reason_desc_ch,
 MAX(CASE
   WHEN client_id = 5
   THEN description
   ELSE NULL
   END) AS reason_desc_cy,
 MAX(CASE
   WHEN client_id = 6
   THEN description
   ELSE NULL
   END) AS reason_desc_cz,
 MAX(CASE
   WHEN client_id = 23
   THEN description
   ELSE NULL
   END) AS reason_desc_de,
 MAX(CASE
   WHEN client_id = 8
   THEN description
   ELSE NULL
   END) AS reason_desc_dk,
 MAX(CASE
   WHEN client_id = 10
   THEN description
   ELSE NULL
   END) AS reason_desc_es,
 MAX(CASE
   WHEN client_id = 11
   THEN description
   ELSE NULL
   END) AS reason_desc_fi,
 MAX(CASE
   WHEN client_id = 12
   THEN description
   ELSE NULL
   END) AS reason_desc_fr,
 MAX(CASE
   WHEN client_id = 13
   THEN description
   ELSE NULL
   END) AS reason_desc_gb,
 MAX(CASE
   WHEN client_id = 14
   THEN description
   ELSE NULL
   END) AS reason_desc_gr,
 MAX(CASE
   WHEN client_id = 15
   THEN description
   ELSE NULL
   END) AS reason_desc_hr,
 MAX(CASE
   WHEN client_id = 16
   THEN description
   ELSE NULL
   END) AS reason_desc_hu,
 MAX(CASE
   WHEN client_id = 17
   THEN description
   ELSE NULL
   END) AS reason_desc_ie,
 MAX(CASE
   WHEN client_id = 18
   THEN description
   ELSE NULL
   END) AS reason_desc_it,
 MAX(CASE
   WHEN client_id = 19
   THEN description
   ELSE NULL
   END) AS reason_desc_lt,
 MAX(CASE
   WHEN client_id = 20
   THEN description
   ELSE NULL
   END) AS reason_desc_lv,
 MAX(CASE
   WHEN client_id = 21
   THEN description
   ELSE NULL
   END) AS reason_desc_ni,
 MAX(CASE
   WHEN client_id = 22
   THEN description
   ELSE NULL
   END) AS reason_desc_nl,
 MAX(CASE
   WHEN client_id = 24
   THEN description
   ELSE NULL
   END) AS reason_desc_pl,
 MAX(CASE
   WHEN client_id = 25
   THEN description
   ELSE NULL
   END) AS reason_desc_pt,
 MAX(CASE
   WHEN client_id = 26
   THEN description
   ELSE NULL
   END) AS reason_desc_ro,
 MAX(CASE
   WHEN client_id = 27
   THEN description
   ELSE NULL
   END) AS reason_desc_se,
 MAX(CASE
   WHEN client_id = 28
   THEN description
   ELSE NULL
   END) AS reason_desc_si,
 MAX(CASE
   WHEN client_id = 29
   THEN description
   ELSE NULL
   END) AS reason_desc_sk,
 MAX(CASE
   WHEN client_id = 31
   THEN description
   ELSE NULL
   END) AS reason_desc_cs,
 MAX(CASE
   WHEN client_id = 32
   THEN description
   ELSE NULL
   END) AS reason_desc_mt,
 MAX(CASE
   WHEN client_id = 33
   THEN description
   ELSE NULL
   END) AS reason_desc_us
FROM ldl_p_lew_core_ac.v_wawi_ref_description
WHERE desc_type = 'T178'
 AND read_only = 1
 AND language_id = client_id
GROUP BY reason_id;