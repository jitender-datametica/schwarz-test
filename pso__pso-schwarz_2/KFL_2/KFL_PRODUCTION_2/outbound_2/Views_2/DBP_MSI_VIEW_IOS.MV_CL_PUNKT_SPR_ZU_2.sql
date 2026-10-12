CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cl_punkt_spr_zu_2 AS SELECT T01.checkliste_punkt_id,
 T03.cpr_suchfeld AS cpr_suchfeld_id,
 PR.mandant_id,
 MAX(CASE
   WHEN T01.spr_id = 22
   THEN T01.cl_punkt_bez
   ELSE NULL
   END) AS cl_punkt_bez,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 124
    THEN T01.cl_punkt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_bez
    ELSE NULL
    END)) AS cl_punkt_bez_cz,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 108
    THEN T01.cl_punkt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_bez
    ELSE NULL
    END)) AS cl_punkt_bez_sk,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 65
    THEN T01.cl_punkt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_bez
    ELSE NULL
    END)) AS cl_punkt_bez_hr,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 90
    THEN T01.cl_punkt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_bez
    ELSE NULL
    END)) AS cl_punkt_bez_pl,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 95
    THEN T01.cl_punkt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_bez
    ELSE NULL
    END)) AS cl_punkt_bez_ro,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 24
    THEN T01.cl_punkt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_bez
    ELSE NULL
    END)) AS cl_punkt_bez_en,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 18
    THEN T01.cl_punkt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_bez
    ELSE NULL
    END)) AS cl_punkt_bez_bg,
 MAX(CASE
   WHEN T01.spr_id = 22
   THEN T01.cl_punkt_langtext
   ELSE NULL
   END) AS cl_punkt_langtext,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 124
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END)) AS cl_punkt_langtext_cz,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 108
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END)) AS cl_punkt_langtext_sk,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 65
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END)) AS cl_punkt_langtext_hr,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 90
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END)) AS cl_punkt_langtext_pl,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 95
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END)) AS cl_punkt_langtext_ro,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 24
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END)) AS cl_punkt_langtext_en,
 COALESCE(MAX(CASE
    WHEN T01.spr_id = 18
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN T01.spr_id = 22
    THEN T01.cl_punkt_langtext
    ELSE NULL
    END)) AS cl_punkt_langtext_bg
FROM kfl_production_dbp_view.v_cl_punkt_spr_zu_per_2 AS T01
 INNER JOIN kfl_production_dbp_view.v_cpr_cl_punkt_per_2 AS T02 ON T01.checkliste_punkt_id = T02.checkliste_punkt_id AND
   T02.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_cpr_checkliste_per_2 AS CL ON T02.cpr_checkliste_id = CL.cpr_checkliste_id AND CL.dat_bis
    = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_2 AS PH ON CL.projekt_phase_id = PH.projekt_phase_id AND PH.dat_bis =
   DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_2 AS PR ON PH.projekt_id = PR.projekt_id AND PR.dat_bis =
   DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_l_cpr_suchfeld_2 AS T03 ON T02.cpr_suchfeld_id = T03.cpr_suchfeld_id
WHERE T01.dat_bis = DATE '9999-12-31'
GROUP BY T01.checkliste_punkt_id,
 cpr_suchfeld_id,
 PR.mandant_id;