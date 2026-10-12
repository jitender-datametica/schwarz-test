-- 10.05.2022 twie: SPEC0145413 Sprachview CRM Marke
 -- standard=deutsch

-- man nimmt in Kauf das für den Fall dass es 2 oder mehr Übersetzungen gibt bei deutsch sozusagen zufällig eine_2 der vorhandenen angezeigt wird (MAX Funktion)

-- 18.01.2024 twie: NSR4260499 da deutsch mit spr_id = 22 nicht immer gefüllt ist, sondern immer nur eine_2 der Sprachen

-- soll bei deutsch der Inhalt der anderen Sprachen gezeigt werden

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_crm_brand_spr_zu_2 (crm_brand_id, crm_brand_bez, crm_brand_bez_cz
, crm_brand_bez_pl, crm_brand_bez_sk, crm_brand_bez_hr, crm_brand_bez_ro, crm_brand_bez_bg) AS SELECT crm_brand_id,
 MAX(crm_brand_bez) AS crm_brand_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN crm_brand_bez
   ELSE NULL
   END) AS crm_brand_bez_bg
FROM kfl_production_dbp_view.v_crm_brand_spr_zu_2 AS v01
GROUP BY crm_brand_id;