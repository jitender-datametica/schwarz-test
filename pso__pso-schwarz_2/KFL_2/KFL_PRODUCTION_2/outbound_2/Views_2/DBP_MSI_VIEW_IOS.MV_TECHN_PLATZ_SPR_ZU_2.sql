CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_techn_platz_spr_zu_2 AS SELECT TP_S.techn_platz_id,
 1 AS fg,
 MAX(CASE
   WHEN TP_S.spr_id = 22
   THEN TP_S.tech_platz_bez
   ELSE NULL
   END) AS tech_platz_bez,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 124
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END)) AS tech_platz_bez_cz,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 108
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END)) AS tech_platz_bez_sk,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 65
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END)) AS tech_platz_bez_hr,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 90
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END)) AS tech_platz_bez_pl,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 95
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END)) AS tech_platz_bez_ro,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 24
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END)) AS tech_platz_bez_en,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 18
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN TP_S.tech_platz_bez
    ELSE NULL
    END)) AS tech_platz_bez_bg,
 MAX(CASE
   WHEN TP_S.spr_id = 22
   THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
   ELSE NULL
   END) AS tech_platz_kbez,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 124
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_cz,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 108
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_sk,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 65
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_hr,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 90
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_pl,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 95
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_ro,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 24
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_en,
 COALESCE(MAX(CASE
    WHEN TP_S.spr_id = 18
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN TP_S.spr_id = 22
    THEN SUBSTR(TP_S.tech_platz_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_bg,
 TP.mandant_id
FROM kfl_production_dbp_view.v_techn_platz_per_2 AS TP
 INNER JOIN kfl_production_dbp_view.v_techn_platz_spr_zu_per_2 AS TP_S ON TP.techn_platz_id = TP_S.techn_platz_id AND TP_S
   .dat_bis = DATE '9999-12-31'
WHERE TP.wup_stadt IS NOT NULL
 AND TP.dat_bis = DATE '9999-12-31'
GROUP BY TP_S.techn_platz_id,
 fg,
 TP.mandant_id
UNION DISTINCT
SELECT PR.techn_platz_id,
 0 AS fg,
 MAX(CASE
   WHEN PR_S.spr_id = 22
   THEN PR_S.cpr_projekt_bez
   ELSE NULL
   END) AS cpr_projekt_bez,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 124
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_cz,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 108
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_sk,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 65
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_hr,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 90
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_pl,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 95
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_ro,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 24
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_en,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 18
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN PR_S.cpr_projekt_bez
    ELSE NULL
    END)) AS cpr_projekt_bez_bg,
 MAX(CASE
   WHEN PR_S.spr_id = 22
   THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
   ELSE NULL
   END) AS tech_platz_kbez,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 124
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_cz,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 108
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_sk,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 65
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_hr,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 90
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_pl,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 95
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_ro,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 24
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_en,
 COALESCE(MAX(CASE
    WHEN PR_S.spr_id = 18
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END), MAX(CASE
    WHEN PR_S.spr_id = 22
    THEN SUBSTR(PR_S.cpr_projekt_bez, 4, 80)
    ELSE NULL
    END)) AS tech_platz_kbez_bg,
 PR.mandant_id
FROM kfl_production_dbp_view.v_cpr_projekt_per_2 AS PR
 INNER JOIN kfl_production_dbp_view.v_cpr_projekt_spr_zu_per_2 AS PR_S ON PR.projekt_id = PR_S.projekt_id AND PR_S.dat_bis
    = DATE '9999-12-31'
WHERE PR.dat_bis = DATE '9999-12-31'
 AND (PR.techn_platz_id, PR.cpr_ext_id) IN (SELECT (techn_platz_id, MAX(cpr_ext_id))
   FROM kfl_production_dbp_view.v_cpr_projekt_per_2 AS PR1
   WHERE cpr_standort IS NOT NULL
    AND dat_bis = DATE '9999-12-31'
   GROUP BY techn_platz_id)
 AND PR.techn_platz_id NOT IN (SELECT TP_S0.techn_platz_id
   FROM kfl_production_dbp_view.v_techn_platz_spr_zu_per_2 AS TP_S0
    INNER JOIN kfl_production_dbp_view.v_techn_platz_per_2 AS TP0 ON TP_S0.techn_platz_id = TP0.techn_platz_id AND TP0.dat_bis
        = DATE '9999-12-31' AND TP0.wup_stadt IS NOT NULL
   WHERE TP_S0.dat_bis = DATE '9999-12-31')
GROUP BY PR.techn_platz_id,
 fg,
 PR.mandant_id;