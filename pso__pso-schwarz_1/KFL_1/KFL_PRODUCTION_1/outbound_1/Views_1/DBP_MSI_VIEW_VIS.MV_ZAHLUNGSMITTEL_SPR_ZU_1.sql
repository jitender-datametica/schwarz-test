CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_zahlungsmittel_spr_zu_1 (mandant_id, zahlungsmittel_id,
zahlungsmittel_bez, zahlungsmittel_bez_de, zahlungsmittel_bez_cz, zahlungsmittel_bez_pl, zahlungsmittel_bez_sk,
zahlungsmittel_bez_hr, zahlungsmittel_bez_ro, zahlungsmittel_bez_bg) AS SELECT mandant_id,
 zahlungsmittel_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN zahlungsmittel_bez
   ELSE NULL
   END) AS zahlungsmittel_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN zahlungsmittel_bez
   ELSE NULL
   END) AS zahlungsmittel_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN zahlungsmittel_bez
   ELSE NULL
   END) AS zahlungsmittel_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN zahlungsmittel_bez
   ELSE NULL
   END) AS zahlungsmittel_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN zahlungsmittel_bez
   ELSE NULL
   END) AS zahlungsmittel_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN zahlungsmittel_bez
   ELSE NULL
   END) AS zahlungsmittel_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN zahlungsmittel_bez
   ELSE NULL
   END) AS zahlungsmittel_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN zahlungsmittel_bez
   ELSE NULL
   END) AS zahlungsmittel_bez_bg
FROM kfl_production_dbp_v_ods.v_zahlungsmittel_spr_zu_1 AS V01
GROUP BY mandant_id,
 zahlungsmittel_id;