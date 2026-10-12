CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_ims_systemstatus_spr_zu (systemstatus_id, mandant_id,
systemstatus_bez_kurz, systemstatus_bez_kurz_cz, systemstatus_bez_kurz_sk, systemstatus_bez_kurz_hr,
systemstatus_bez_kurz_pl, systemstatus_bez_kurz_ro, systemstatus_bez_kurz_en, systemstatus_bez_kurz_bg, systemstatus_bez
, systemstatus_bez_cz, systemstatus_bez_sk, systemstatus_bez_hr, systemstatus_bez_pl, systemstatus_bez_ro,
systemstatus_bez_en, systemstatus_bez_bg) AS SELECT systemstatus_id,
 mandant_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN systemstatus_bez_kurz
   ELSE NULL
   END) AS systemstatus_bez_kurz,
 MAX(CASE
   WHEN spr_id = 124
   THEN systemstatus_bez_kurz
   ELSE NULL
   END) AS systemstatus_bez_kurz_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN systemstatus_bez_kurz
   ELSE NULL
   END) AS systemstatus_bez_kurz_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN systemstatus_bez_kurz
   ELSE NULL
   END) AS systemstatus_bez_kurz_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN systemstatus_bez_kurz
   ELSE NULL
   END) AS systemstatus_bez_kurz_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN systemstatus_bez_kurz
   ELSE NULL
   END) AS systemstatus_bez_kurz_ro,
 MAX(CASE
   WHEN spr_id = 24
   THEN systemstatus_bez_kurz
   ELSE NULL
   END) AS systemstatus_bez_kurz_en,
 MAX(CASE
   WHEN spr_id = 18
   THEN systemstatus_bez_kurz
   ELSE NULL
   END) AS systemstatus_bez_kurz_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN systemstatus_bez
   ELSE NULL
   END) AS systemstatus_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN systemstatus_bez
   ELSE NULL
   END) AS systemstatus_bez_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN systemstatus_bez
   ELSE NULL
   END) AS systemstatus_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN systemstatus_bez
   ELSE NULL
   END) AS systemstatus_bez_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN systemstatus_bez
   ELSE NULL
   END) AS systemstatus_bez_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN systemstatus_bez
   ELSE NULL
   END) AS systemstatus_bez_ro,
 MAX(CASE
   WHEN spr_id = 24
   THEN systemstatus_bez
   ELSE NULL
   END) AS systemstatus_bez_en,
 MAX(CASE
   WHEN spr_id = 18
   THEN systemstatus_bez
   ELSE NULL
   END) AS systemstatus_bez_bg
FROM kfl_production_dbp_view.v_ims_systemstatus_spr_zu AS V01
GROUP BY systemstatus_id,
 mandant_id;