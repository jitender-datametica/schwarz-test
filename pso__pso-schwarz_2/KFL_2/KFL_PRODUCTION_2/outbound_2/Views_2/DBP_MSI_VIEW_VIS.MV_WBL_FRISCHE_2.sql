CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wbl_frische_2 AS SELECT mandant_id,
 ma_id AS wbl_frische_id,
 MAX(ma_ldap) AS ma_ldap,
 MAX(email) AS ma_email,
 MAX(mobil_tel) AS ma_tel,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_name
   ELSE NULL
   END) AS ma_name_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_vorname
   ELSE NULL
   END) AS ma_vorname_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_anrede
   ELSE NULL
   END) AS ma_anrede_de,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_name
   ELSE NULL
   END) AS ma_name,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_vorname
   ELSE NULL
   END) AS ma_vorname,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)) AS ma_name_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN ma_vorname
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)) AS ma_vorname_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)) AS ma_name_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN ma_vorname
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)) AS ma_vorname_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)) AS ma_name_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN ma_vorname
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)) AS ma_vorname_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)) AS ma_name_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN ma_vorname
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)) AS ma_vorname_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)) AS ma_name_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN ma_vorname
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)) AS ma_vorname_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)) AS ma_name_bg,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN ma_vorname
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)) AS ma_vorname_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN ma_anrede
   ELSE NULL
   END) AS ma_anrede,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN ma_anrede
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)) AS ma_anrede_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN ma_anrede
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)) AS ma_anrede_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN ma_anrede
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)) AS ma_anrede_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN ma_anrede
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)) AS ma_anrede_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN ma_anrede
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)) AS ma_anrede_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN ma_anrede
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)) AS ma_anrede_bg
FROM (SELECT mandant_id,
    ma_id,
    ma_name,
    ma_vorname,
    ma_anrede,
    email,
    mobil_tel,
    ma_ldap,
    spr_id
   FROM kfl_production_dbp_view.v_ma_spr_zu_2
   WHERE (mandant_id, ma_id) IN (SELECT (mandant_id, wbl_frische_id)
      FROM kfl_production_dbp_msi_v_view.v_wup_denorm_2)
   UNION ALL
   SELECT mandant_id,
    - 1,
    '--',
    '',
    '',
    '',
    '',
    '',
    22
   FROM kfl_production_dbp_view.v_mandant_2) AS msz
GROUP BY mandant_id,
 wbl_frische_id;