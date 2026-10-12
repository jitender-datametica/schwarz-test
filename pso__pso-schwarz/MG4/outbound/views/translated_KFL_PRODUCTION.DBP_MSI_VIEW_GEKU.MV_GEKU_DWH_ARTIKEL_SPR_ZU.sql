-- 19.02.2018 twie: SPEC0034180 Case Bedingung nochmals angepasst

-- 13.11.2015 twie: Bezeichnungsfeld, das die alten gemappten Ebene 4 Nummern enthält

-- 03.03.2017 twie: SPEC0019359 Umstellung spaltenbasiert

-- Filterung über Artikel (4. Ebene) damit für DWH Artikel keine Elemente angezeigt werden

-- 07.06.2018 twie: SPEC0038139 Schlüssel für DWH Artikel um kmr_quelle_id ergänzt für Zusammenführung Hierarchie

-- 31.01.2018 twie: SPEC0032924 die bez2 bei Artikel ID zw. 2500 und 5999 mit (alt 2017) erweitern

-- 09.09.2015 twie: Sprachview für DWH Artikel (3. Ebene)

-- für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_dwh_artikel_spr_zu (geku_dwh_artikel_id, kmr_quelle_id,
geku_dwh_artikel_bez, geku_dwh_artikel_bez_cz, geku_dwh_artikel_bez_pl, geku_dwh_artikel_bez_sk, geku_dwh_artikel_bez_hr
, geku_dwh_artikel_bez_ro, geku_dwh_artikel_bez_bg, geku_dwh_artikel_bez2, geku_dwh_artikel_bez2_cz,
geku_dwh_artikel_bez2_pl, geku_dwh_artikel_bez2_sk, geku_dwh_artikel_bez2_hr, geku_dwh_artikel_bez2_ro,
geku_dwh_artikel_bez2_bg) AS -- standard=deutsch
 SELECT v01.geku_dwh_artikel_id,
 3 AS kmr_quelle_id,
 MAX(CASE
   WHEN v01.spr_id = 22
   THEN v01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez,
 MAX(CASE
   WHEN v01.spr_id = 124
   THEN v01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_cz,
 MAX(CASE
   WHEN v01.spr_id = 90
   THEN v01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_pl,
 MAX(CASE
   WHEN v01.spr_id = 108
   THEN v01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_sk,
 MAX(CASE
   WHEN v01.spr_id = 65
   THEN v01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_hr,
 MAX(CASE
   WHEN v01.spr_id = 95
   THEN v01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_ro,
 MAX(CASE
   WHEN v01.spr_id = 18
   THEN v01.geku_dwh_artikel_bez
   ELSE NULL
   END) AS geku_dwh_artikel_bez_bg,
 MAX(CASE
   WHEN v01.spr_id = 22
   THEN CASE
    WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN v02.alt_fg = 1
    THEN v01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN v02.geku_artikel_id_alt IS NULL
     THEN v01.geku_dwh_artikel_bez
     ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2,
 MAX(CASE
   WHEN v01.spr_id = 124
   THEN CASE
    WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN v02.alt_fg = 1
    THEN v01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN v02.geku_artikel_id_alt IS NULL
     THEN v01.geku_dwh_artikel_bez
     ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_cz,
 MAX(CASE
   WHEN v01.spr_id = 90
   THEN CASE
    WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN v02.alt_fg = 1
    THEN v01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN v02.geku_artikel_id_alt IS NULL
     THEN v01.geku_dwh_artikel_bez
     ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_pl,
 MAX(CASE
   WHEN v01.spr_id = 108
   THEN CASE
    WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN v02.alt_fg = 1
    THEN v01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN v02.geku_artikel_id_alt IS NULL
     THEN v01.geku_dwh_artikel_bez
     ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_sk,
 MAX(CASE
   WHEN v01.spr_id = 65
   THEN CASE
    WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN v02.alt_fg = 1
    THEN v01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN v02.geku_artikel_id_alt IS NULL
     THEN v01.geku_dwh_artikel_bez
     ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_hr,
 MAX(CASE
   WHEN v01.spr_id = 95
   THEN CASE
    WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN v02.alt_fg = 1
    THEN v01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN v02.geku_artikel_id_alt IS NULL
     THEN v01.geku_dwh_artikel_bez
     ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_ro,
 MAX(CASE
   WHEN v01.spr_id = 18
   THEN CASE
    WHEN v02.alt_fg = 1 AND v02.geku_dwh_artikel_id BETWEEN 2500 AND 5999
    THEN v01.geku_dwh_artikel_bez || ' (alt 2017)'
    WHEN v02.alt_fg = 1
    THEN v01.geku_dwh_artikel_bez || ' (alt)'
    ELSE CASE
     WHEN v02.geku_artikel_id_alt IS NULL
     THEN v01.geku_dwh_artikel_bez
     ELSE v01.geku_dwh_artikel_bez || ' (' || v02.geku_artikel_id_alt || ')'
     END
    END
   ELSE NULL
   END) AS geku_dwh_artikel_bez2_bg
FROM kfl_production_dbp_view.v_geku_dwh_artikel_spr_zu AS v01
 INNER JOIN kfl_production_dbp_view.v_l_geku_dwh_artikel AS v02 ON v01.geku_dwh_artikel_id = v02.geku_dwh_artikel_id
WHERE v01.geku_dwh_artikel_id IN (SELECT geku_dwh_artikel_id
   FROM kfl_production_dbp_view.v_l_geku_artikel)
GROUP BY v01.geku_dwh_artikel_id;