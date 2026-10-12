-- Tabelle crm_themenbaum_lv2_spr_zu_1 ist denormalisiert und enthält Ebene 1 + 2  + 3. Jeder Datensatz hat mit crm_themenbaum_lv2_id einen eindeutigen Schlüssel, der in MSI aber nicht relevant ist.

-- 23.07.2019 twie: SPEC0059158 Sprachview CRM Ebene 1 (oberste Stufe)

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_ebene_1_spr_zu_1 (ebene_1_id, ebene_1_bez, ebene_1_bez_cz,
ebene_1_bez_pl, ebene_1_bez_sk, ebene_1_bez_hr, ebene_1_bez_ro, ebene_1_bez_bg) AS -- standard=deutsch
 SELECT
 ebene_1_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ebene_1_bez
   ELSE NULL
   END) AS ebene_1_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN ebene_1_bez
   ELSE NULL
   END) AS ebene_1_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN ebene_1_bez
   ELSE NULL
   END) AS ebene_1_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN ebene_1_bez
   ELSE NULL
   END) AS ebene_1_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN ebene_1_bez
   ELSE NULL
   END) AS ebene_1_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN ebene_1_bez
   ELSE NULL
   END) AS ebene_1_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN ebene_1_bez
   ELSE NULL
   END) AS ebene_1_bez_bg
FROM kfl_production_dbp_view.v_crm_themenbaum_lv2_spr_zu_1 AS v01
GROUP BY ebene_1_id;