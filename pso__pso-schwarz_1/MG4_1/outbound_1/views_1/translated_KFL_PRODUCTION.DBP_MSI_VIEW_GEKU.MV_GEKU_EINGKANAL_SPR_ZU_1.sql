-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert
 -- standard=deutsch

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_geku_eingkanal_spr_zu_1 (geku_eingangskanal_id, geku_eingangskanal_bez,
geku_eingangskanal_bez_cz, geku_eingangskanal_bez_pl, geku_eingangskanal_bez_sk, geku_eingangskanal_bez_hr,
geku_eingangskanal_bez_ro, geku_eingangskanal_bez_bg) AS SELECT geku_eingangskanal_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_eingangskanal_bez
   ELSE NULL
   END) AS geku_eingangskanal_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN geku_eingangskanal_bez
   ELSE NULL
   END) AS geku_eingangskanal_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN geku_eingangskanal_bez
   ELSE NULL
   END) AS geku_eingangskanal_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN geku_eingangskanal_bez
   ELSE NULL
   END) AS geku_eingangskanal_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN geku_eingangskanal_bez
   ELSE NULL
   END) AS geku_eingangskanal_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN geku_eingangskanal_bez
   ELSE NULL
   END) AS geku_eingangskanal_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN geku_eingangskanal_bez
   ELSE NULL
   END) AS geku_eingangskanal_bez_bg
FROM kfl_production_dbp_view.v_geku_eingangskanal_spr_zu_1 AS v01
GROUP BY geku_eingangskanal_id;