CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_cpr_checkliste_spr_zu_2 AS SELECT PR.mandant_id,
 CL_S.cpr_checkliste_id,
 MAX(CASE
   WHEN CL_S.spr_id = 22
   THEN CL_S.cpr_checkliste_langtext
   ELSE NULL
   END) AS cpr_checkliste_langtext,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 124
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END)) AS cpr_checkliste_langtext_cz,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 108
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END)) AS cpr_checkliste_langtext_sk,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 65
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END)) AS cpr_checkliste_langtext_hr,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 90
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END)) AS cpr_checkliste_langtext_pl,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 95
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END)) AS cpr_checkliste_langtext_ro,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 24
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END)) AS cpr_checkliste_langtext_en,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 18
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_langtext
    ELSE NULL
    END)) AS cpr_checkliste_langtext_bg,
 MAX(CASE
   WHEN CL_S.spr_id = 22
   THEN CL_S.cpr_checkliste_bez
   ELSE NULL
   END) AS cpr_checkliste_bez,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 124
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END)) AS cpr_checkliste_bez_cz,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 108
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END)) AS cpr_checkliste_bez_sk,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 65
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END)) AS cpr_checkliste_bez_hr,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 90
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END)) AS cpr_checkliste_bez_pl,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 95
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END)) AS cpr_checkliste_bez_ro,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 24
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END)) AS cpr_checkliste_bez_en,
 COALESCE(MAX(CASE
    WHEN CL_S.spr_id = 18
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END), MAX(CASE
    WHEN CL_S.spr_id = 22
    THEN CL_S.cpr_checkliste_bez
    ELSE NULL
    END)) AS cpr_checkliste_bez_bg
FROM kfl_production_dbp_view.v_cpr_checkliste_spr_zu_per_2 AS CL_S
 INNER JOIN kfl_production_dbp_view.v_cpr_checkliste_per_2 AS CL ON CL_S.cpr_checkliste_id = CL.cpr_checkliste_id AND CL.dat_bis
    = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_cpr_phase_per_2 AS PH ON CL.projekt_phase_id = PH.projekt_phase_id AND PH.dat_bis =
   DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_per_2 AS PR ON PH.projekt_id = PR.projekt_id AND PR.dat_bis =
   DATE '9999-12-31'
WHERE CL_S.dat_bis = DATE '9999-12-31'
GROUP BY PR.mandant_id,
 CL_S.cpr_checkliste_id;