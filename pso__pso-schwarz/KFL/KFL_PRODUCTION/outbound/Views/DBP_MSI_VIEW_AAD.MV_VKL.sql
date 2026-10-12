CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_vkl AS SELECT V01.mandant_id,
 V01.ma_id AS vkl_id,
 V02.gf_id,
 MAX(CASE
   WHEN V01.spr_id = 22
   THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
   ELSE NULL
   END) AS vkl_name,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 124
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END)) AS vkl_name_cz,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 108
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END)) AS vkl_name_sk,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 65
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END)) AS vkl_name_hr,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 90
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END)) AS vkl_name_pl,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 95
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END)) AS vkl_name_ro,
 COALESCE(MAX(CASE
    WHEN V01.spr_id = 18
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN V01.spr_id = 22
    THEN V01.ma_anrede || ' ' || V01.ma_vorname || ' ' || V01.ma_name
    ELSE NULL
    END)) AS vkl_name_bg
FROM kfl_production_dbp_view.v_ma_spr_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_vkl AS V02 ON V01.ma_id = V02.vkl_id AND V01.mandant_id = V02.mandant_id
WHERE (V01.mandant_id, V01.ma_id) IN (SELECT (mandant_id, vkl_id)
   FROM (SELECT mandant_id,
       vkl_id
      FROM kfl_production_dbp_view.v_wup
      WHERE nb_id IN (0, - 1, 2, 7)
       AND vkl_id <> wup_id
      UNION ALL
      SELECT mandant_id,
         (1000 + mandant_id * 100 + vs_id * 10) * - 1
      FROM kfl_production_dbp_view.v_vs) AS t2)
GROUP BY V01.mandant_id,
 vkl_id,
 V02.gf_id;