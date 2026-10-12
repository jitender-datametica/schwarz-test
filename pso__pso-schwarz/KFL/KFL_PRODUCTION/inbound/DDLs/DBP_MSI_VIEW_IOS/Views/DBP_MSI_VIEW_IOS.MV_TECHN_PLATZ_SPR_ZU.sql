CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_TECHN_PLATZ_SPR_ZU as
   SELECT
   tp_s.techn_platz_id, 1 AS FG, MAX(CASE WHEN spr_id =  22 THEN tp_s.tech_platz_bez ELSE NULL END) AS tech_platz_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN tp_s.tech_platz_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN tp_s.tech_platz_bez ELSE NULL END)) AS tech_platz_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN tp_s.tech_platz_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN tp_s.tech_platz_bez ELSE NULL END)) AS tech_platz_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN tp_s.tech_platz_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN tp_s.tech_platz_bez ELSE NULL END)) AS tech_platz_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN tp_s.tech_platz_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN tp_s.tech_platz_bez ELSE NULL END)) AS tech_platz_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN tp_s.tech_platz_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN tp_s.tech_platz_bez ELSE NULL END)) AS tech_platz_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN tp_s.tech_platz_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN tp_s.tech_platz_bez ELSE NULL END)) AS tech_platz_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN tp_s.tech_platz_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN tp_s.tech_platz_bez ELSE NULL END)) AS tech_platz_bez_bg    -- BG
   , MAX(CASE WHEN spr_id =  22 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END) AS tech_platz_kbez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80)) */ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80)) */ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80)) */ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(tp_s.tech_platz_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_bg    -- BG
   , tp.mandant_id

   FROM dbp_view.v_techn_platz_per  tp

   JOIN dbp_view.v_techn_platz_spr_zu_per tp_s
   ON   tp_s.techn_platz_id = tp.techn_platz_id
   AND tp_s.dat_bis = '9999-12-31'

   WHERE tp.wup_stadt IS NOT NULL
   --AND   tp_s.spr_id = 22
   AND  tp.dat_bis = '9999-12-31'
   GROUP BY
   tp_s.techn_platz_id
   ,FG
   ,tp.mandant_id

   UNION

   SELECT
   pr.techn_platz_id, 0 AS FG, MAX(CASE WHEN spr_id =  22 THEN pr_s.cpr_projekt_bez ELSE NULL END) AS cpr_projekt_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN pr_s.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN pr_s.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN pr_s.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN pr_s.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN pr_s.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN pr_s.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN pr_s.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN pr_s.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN pr_s.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN pr_s.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN pr_s.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN pr_s.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN pr_s.cpr_projekt_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN pr_s.cpr_projekt_bez ELSE NULL END)) AS cpr_projekt_bez_bg    -- BG
   , MAX(CASE WHEN spr_id =  22 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END) AS tech_platz_kbez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80)) */ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80)) */ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80)) */ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN SUBSTR(pr_s.cpr_projekt_bez,4,80) /*(VARCHAR(80))*/ ELSE NULL END)) AS tech_platz_kbez_bg    -- BG
   , pr.mandant_id

   FROM dbp_view.v_cpr_projekt_per pr

   JOIN dbp_view.v_cpr_projekt_spr_zu_per pr_s
   ON   pr.projekt_id = pr_s.projekt_id
   AND  pr_s.dat_bis = '9999-12-31'

   WHERE pr.dat_bis = '9999-12-31'
   --AND pr_s.spr_id = 22
   AND   pr.techn_platz_id NOT IN
   (
   SELECT tp_s0.techn_platz_id  techn_platz_id

   FROM dbp_view.v_techn_platz_spr_zu_per  tp_s0
   INNER JOIN dbp_view.v_techn_platz_per  tp0
   ON    tp_s0.techn_platz_id = tp0.techn_platz_id
   AND   tp0.wup_stadt IS NOT NULL
   AND   tp0.dat_bis = '9999-12-31'

   WHERE tp_s0.dat_bis = '9999-12-31'
   )
   AND  (techn_platz_id, pr.cpr_ext_id) IN
   (
   SELECT
   pr1.techn_platz_id  techn_platz_id, MAX(pr1.cpr_ext_id)  cpr_ext_id
   FROM dbp_view.v_cpr_projekt_per pr1

   WHERE pr1.cpr_standort IS NOT NULL
   AND pr1.dat_bis = '9999-12-31'

   GROUP BY techn_platz_id
   )
   GROUP BY
   pr.techn_platz_id
   ,FG
   ,pr.mandant_id;