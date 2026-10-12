CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_oug_id_spr_zu (oug_id, oug_id_bez, oug_id_bez_de,
oug_id_bez_cz, oug_id_bez_sk, oug_id_bez_hr, oug_id_bez_pl, oug_id_bez_ro, oug_id_bez_bg) AS SELECT oug_id,
 a1 AS oug_id_bez,
 a2 AS oug_id_bez_de,
 a3 AS oug_id_bez_cz,
 a4 AS oug_id_bez_sk,
 a5 AS oug_id_bez_hr,
 a6 AS oug_id_bez_pl,
 a7 AS oug_id_bez_ro,
 a8 AS oug_id_bez_bg
FROM (SELECT oug_id,
    MAX(CASE
      WHEN spr_id = 22
      THEN oug_id_bez
      ELSE NULL
      END) AS a1,
    MAX(CASE
      WHEN spr_id = 22
      THEN oug_id_bez
      ELSE NULL
      END) AS a2,
    MAX(CASE
      WHEN spr_id = 124
      THEN oug_id_bez
      ELSE NULL
      END) AS a3,
    MAX(CASE
      WHEN spr_id = 108
      THEN oug_id_bez
      ELSE NULL
      END) AS a4,
    MAX(CASE
      WHEN spr_id = 65
      THEN oug_id_bez
      ELSE NULL
      END) AS a5,
    MAX(CASE
      WHEN spr_id = 90
      THEN oug_id_bez
      ELSE NULL
      END) AS a6,
    MAX(CASE
      WHEN spr_id = 95
      THEN oug_id_bez
      ELSE NULL
      END) AS a7,
    MAX(CASE
      WHEN spr_id = 18
      THEN oug_id_bez
      ELSE NULL
      END) AS a8
   FROM kfl_production_dbp_view.v_oug_id_spr_zu
   WHERE oug_id > 0
   GROUP BY oug_id
   UNION ALL
   SELECT 0,
    'nicht gepflegt',
    'nicht gepflegt',
    'žádné specifikace',
    'žiadne špecifikácie',
    'nema specifikacija',
    'bez specyfikacji',
    'fara precizare',
    'без спецификация'
   FROM UNNEST(GENERATE_ARRAY(0, 0)) AS SEQ) AS sub00;