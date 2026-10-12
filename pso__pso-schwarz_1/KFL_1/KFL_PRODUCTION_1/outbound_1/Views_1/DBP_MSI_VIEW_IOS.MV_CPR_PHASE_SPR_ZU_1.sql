CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_phase_spr_zu_1 AS SELECT V02.projekt_phase_id,
 V04.mandant_id,
 V02.dat_von,
 V02.dat_bis,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN V02.cpr_phase_bez
   ELSE NULL
   END) AS cpr_phase_bez,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN V02.cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN V02.cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN V02.cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN V02.cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN V02.cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN V02.cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN V02.cpr_phase_bez
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN V02.cpr_phase_bez
    ELSE NULL
    END)) AS cpr_phase_bez_bg,
 MAX(CASE
   WHEN V02.spr_id = 22
   THEN COALESCE(V02.cpr_phase_langtext, '')
   ELSE NULL
   END) AS cpr_phase_langtext,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 124
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END)) AS cpr_phase_langtext_cz,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 108
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END)) AS cpr_phase_langtext_sk,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 65
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END)) AS cpr_phase_langtext_hr,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 90
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END)) AS cpr_phase_langtext_pl,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 95
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END)) AS cpr_phase_langtext_ro,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 24
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END)) AS cpr_phase_langtext_en,
 COALESCE(MAX(CASE
    WHEN V02.spr_id = 18
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END), MAX(CASE
    WHEN V02.spr_id = 22
    THEN COALESCE(V02.cpr_phase_langtext, '')
    ELSE NULL
    END)) AS cpr_phase_langtext_bg
FROM kfl_production_dbp_view.v_cpr_phase_spr_zu_per_1 AS V02
 INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_1 AS V03 ON V02.projekt_phase_id = V03.projekt_phase_id AND V03.dat_bis
    = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_1 AS V04 ON V03.projekt_id = V04.projekt_id AND V04.dat_bis =
   DATE '9999-12-31'
WHERE V02.dat_bis = DATE '9999-12-31'
 AND V03.dat_bis = DATE '9999-12-31'
 AND V04.dat_bis = DATE '9999-12-31'
GROUP BY V02.projekt_phase_id,
 V04.mandant_id,
 V02.dat_von,
 V02.dat_bis;