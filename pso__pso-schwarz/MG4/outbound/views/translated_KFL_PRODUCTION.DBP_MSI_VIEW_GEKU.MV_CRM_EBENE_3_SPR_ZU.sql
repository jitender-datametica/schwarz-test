-- Tabelle crm_themenbaum_lv2_spr_zu ist denormalisiert und enthält Ebene 1 + 2  + 3. Jeder Datensatz hat mit crm_themenbaum_lv2_id einen eindeutigen Schlüssel, der in MSI aber nicht relevant ist.

-- 23.07.2019 twie: SPEC0059158 Sprachview CRM Ebene 3 (unterste Stufe)

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_crm_ebene_3_spr_zu (ebene_3_id, ebene_3_bez, ebene_3_bez_cz,
ebene_3_bez_pl, ebene_3_bez_sk, ebene_3_bez_hr, ebene_3_bez_ro, ebene_3_bez_bg) AS -- standard=deutsch
 SELECT
 ebene_3_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN ebene_3_bez
   ELSE NULL
   END) AS ebene_3_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN ebene_3_bez
   ELSE NULL
   END) AS ebene_3_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN ebene_3_bez
   ELSE NULL
   END) AS ebene_3_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN ebene_3_bez
   ELSE NULL
   END) AS ebene_3_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN ebene_3_bez
   ELSE NULL
   END) AS ebene_3_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN ebene_3_bez
   ELSE NULL
   END) AS ebene_3_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN ebene_3_bez
   ELSE NULL
   END) AS ebene_3_bez_bg
FROM kfl_production_dbp_view.v_crm_themenbaum_lv2_spr_zu AS v01
GROUP BY ebene_3_id;