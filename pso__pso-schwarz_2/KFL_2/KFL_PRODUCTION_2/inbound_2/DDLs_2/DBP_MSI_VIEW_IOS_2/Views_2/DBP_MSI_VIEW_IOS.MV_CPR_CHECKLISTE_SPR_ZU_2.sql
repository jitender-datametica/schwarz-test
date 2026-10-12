CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_CHECKLISTE_SPR_ZU_2 as

   SELECT
   pr.mandant_id, cl_s.cpr_checkliste_id, MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_langtext ELSE NULL END) AS cpr_checkliste_langtext                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN cl_s.cpr_checkliste_langtext ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_langtext ELSE NULL END)) AS cpr_checkliste_langtext_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN cl_s.cpr_checkliste_langtext ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_langtext ELSE NULL END)) AS cpr_checkliste_langtext_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN cl_s.cpr_checkliste_langtext ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_langtext ELSE NULL END)) AS cpr_checkliste_langtext_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN cl_s.cpr_checkliste_langtext ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_langtext ELSE NULL END)) AS cpr_checkliste_langtext_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN cl_s.cpr_checkliste_langtext ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_langtext ELSE NULL END)) AS cpr_checkliste_langtext_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN cl_s.cpr_checkliste_langtext ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_langtext ELSE NULL END)) AS cpr_checkliste_langtext_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN cl_s.cpr_checkliste_langtext ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_langtext ELSE NULL END)) AS cpr_checkliste_langtext_bg    -- BG
   , MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_bez ELSE NULL END) AS cpr_checkliste_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN spr_id = 124 THEN cl_s.cpr_checkliste_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_bez ELSE NULL END))  AS cpr_checkliste_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN spr_id = 108 THEN cl_s.cpr_checkliste_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_bez ELSE NULL END)) AS cpr_checkliste_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN spr_id = 65 THEN cl_s.cpr_checkliste_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_bez ELSE NULL END)) AS cpr_checkliste_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN spr_id = 90 THEN cl_s.cpr_checkliste_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_bez ELSE NULL END)) AS cpr_checkliste_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN spr_id = 95 THEN cl_s.cpr_checkliste_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_bez ELSE NULL END)) AS cpr_checkliste_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN spr_id = 24 THEN cl_s.cpr_checkliste_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_bez ELSE NULL END)) AS cpr_checkliste_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN spr_id = 18 THEN cl_s.cpr_checkliste_bez ELSE NULL END), MAX(CASE WHEN spr_id =  22 THEN cl_s.cpr_checkliste_bez ELSE NULL END)) AS cpr_checkliste_bez_bg    -- BG

   FROM dbp_view.v_cpr_checkliste_spr_zu_per_2  cl_s
   INNER JOIN dbp_view.v_cpr_checkliste_per_2    cl
   ON   cl_s.cpr_checkliste_id = cl.cpr_checkliste_id
   AND   cl.dat_bis = '9999-12-31'
   INNER JOIN dbp_view.v_cpr_phase_per_2     ph
   ON   cl.projekt_phase_id = ph.projekt_phase_id
   AND   ph.dat_bis = '9999-12-31'
   INNER JOIN dbp_view.v_cpr_projekt_per_2    pr
   ON   ph.projekt_id = pr.projekt_id
   AND   pr.dat_bis = '9999-12-31'

   WHERE
   cl_s.dat_bis = '9999-12-31'
   --AND  cl_s.spr_id = 22


   GROUP BY   1,2;