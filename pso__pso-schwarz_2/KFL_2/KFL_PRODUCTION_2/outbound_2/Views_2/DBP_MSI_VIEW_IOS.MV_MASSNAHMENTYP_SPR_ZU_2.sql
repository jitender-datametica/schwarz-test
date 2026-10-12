CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_massnahmentyp_spr_zu_2 AS SELECT V01.massnahmentyp_id,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN CASE
    WHEN V02.massnahmentyp_id = -1
    THEN '  '
    ELSE V02.massnahmentyp_bez
    END
   ELSE NULL
   END) AS massnahmentyp_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124 AND V02.massnahmentyp_id <> -1
    THEN V02.massnahmentyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CASE
     WHEN V02.massnahmentyp_id = -1
     THEN '  '
     ELSE V02.massnahmentyp_bez
     END
    ELSE NULL
    END)) AS massnahmentyp_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108 AND V02.massnahmentyp_id <> -1
    THEN V02.massnahmentyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CASE
     WHEN V02.massnahmentyp_id = -1
     THEN '  '
     ELSE V02.massnahmentyp_bez
     END
    ELSE NULL
    END)) AS massnahmentyp_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65 AND V02.massnahmentyp_id <> -1
    THEN V02.massnahmentyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CASE
     WHEN V02.massnahmentyp_id = -1
     THEN '  '
     ELSE V02.massnahmentyp_bez
     END
    ELSE NULL
    END)) AS massnahmentyp_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90 AND V02.massnahmentyp_id <> -1
    THEN V02.massnahmentyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CASE
     WHEN V02.massnahmentyp_id = -1
     THEN '  '
     ELSE V02.massnahmentyp_bez
     END
    ELSE NULL
    END)) AS massnahmentyp_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95 AND V02.massnahmentyp_id <> -1
    THEN V02.massnahmentyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CASE
     WHEN V02.massnahmentyp_id = -1
     THEN '  '
     ELSE V02.massnahmentyp_bez
     END
    ELSE NULL
    END)) AS massnahmentyp_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24 AND V02.massnahmentyp_id <> -1
    THEN V02.massnahmentyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CASE
     WHEN V02.massnahmentyp_id = -1
     THEN '  '
     ELSE V02.massnahmentyp_bez
     END
    ELSE NULL
    END)) AS massnahmentyp_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18 AND V02.massnahmentyp_id <> -1
    THEN V02.massnahmentyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN CASE
     WHEN V02.massnahmentyp_id = -1
     THEN '  '
     ELSE V02.massnahmentyp_bez
     END
    ELSE NULL
    END)) AS massnahmentyp_bez_bg
FROM kfl_production_dbp_view.v_l_massnahmentyp_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_massnahmentyp_spr_zu_2 AS V02 ON V01.massnahmentyp_id = V02.massnahmentyp_id
GROUP BY V01.massnahmentyp_id;