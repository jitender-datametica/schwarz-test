-- 15.06.2023 snik: SPEC0200542 Lookup VKL_2, analog KMR ohne Zusatz für Maritz

CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_vkl_2 (mandant_id, vkl_id, gf_id, vkl_name, vkl_name_cz, vkl_name_sk,
vkl_name_hr, vkl_name_pl, vkl_name_ro, vkl_name_bg) AS -- Ermittlung gf_id über vkl_2 Tabelle
 -- Zentralfilialen
 SELECT
 v01.mandant_id,
 v01.ma_id AS vkl_id,
 v02.gf_id,
 MAX(CASE
   WHEN v01.spr_id = 22
   THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
   ELSE NULL
   END) AS vkl_name,
 COALESCE(MAX(CASE
    WHEN v01.spr_id = 124
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN v01.spr_id = 22
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END)) AS vkl_name_cz,
 COALESCE(MAX(CASE
    WHEN v01.spr_id = 108
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN v01.spr_id = 22
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END)) AS vkl_name_sk,
 COALESCE(MAX(CASE
    WHEN v01.spr_id = 65
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN v01.spr_id = 22
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END)) AS vkl_name_hr,
 COALESCE(MAX(CASE
    WHEN v01.spr_id = 90
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN v01.spr_id = 22
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END)) AS vkl_name_pl,
 COALESCE(MAX(CASE
    WHEN v01.spr_id = 95
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN v01.spr_id = 22
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END)) AS vkl_name_ro,
 COALESCE(MAX(CASE
    WHEN v01.spr_id = 18
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN v01.spr_id = 22
    THEN v01.ma_anrede || ' ' || v01.ma_vorname || ' ' || v01.ma_name
    ELSE NULL
    END)) AS vkl_name_bg
FROM kfl_production_dbp_view.v_ma_spr_zu_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_vkl_2 AS v02 ON v01.ma_id = v02.vkl_id AND v01.mandant_id = v02.mandant_id
WHERE (v01.mandant_id, v01.ma_id) IN (SELECT (mandant_id, vkl_id)
   FROM (SELECT mandant_id,
       vkl_id
      FROM kfl_production_dbp_view.v_wup_2
      WHERE nb_id IN (0, - 1, 2, 7)
       AND vkl_id <> wup_id
      UNION ALL
      SELECT mandant_id,
         (1000 + mandant_id * 100 + vs_id * 10) * - 1
      FROM kfl_production_dbp_view.v_vs_2) AS t2)
GROUP BY v01.mandant_id,
 vkl_id,
 v02.gf_id;