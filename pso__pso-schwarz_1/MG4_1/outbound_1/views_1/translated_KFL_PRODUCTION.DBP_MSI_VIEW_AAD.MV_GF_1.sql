-- 15.06.2023 snik: SPEC0200542 Lookup GF_1, analog KMR
 -- Zentralfilialen

-- 07.09.2023 twie: SPEC0215747 ldap für Securityfilter GF_1 hinzu
 CREATE OR REPLACE VIEW dbp_msi_view_aad.mv_gf_1 (gf_id,
mandant_id, ma_ldap, gf_name, gf_name_cz, gf_name_sk, gf_name_hr, gf_name_pl, gf_name_ro, gf_name_bg) AS SELECT ma_id AS
 gf_id,
 mandant_id,
 MAX(ma_ldap) AS ma_ldap,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
   ELSE NULL
   END) AS gf_name,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS gf_name_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS gf_name_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS gf_name_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS gf_name_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS gf_name_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede || ' ' || ma_vorname || ' ' || ma_name
    ELSE NULL
    END)) AS gf_name_bg
FROM kfl_production_dbp_view.v_ma_spr_zu_1
WHERE (mandant_id, ma_id) IN (SELECT (mandant_id, gf_id)
   FROM (SELECT mandant_id,
       gf_id
      FROM kfl_production_dbp_view.v_wup_1
      WHERE nb_id IN (0, - 1, 2, 7)
      UNION ALL
      SELECT mandant_id,
         (1000 + mandant_id * 100 + vs_id * 10) * - 1
      FROM kfl_production_dbp_view.v_vs_1) AS t2)
GROUP BY gf_id,
 mandant_id;