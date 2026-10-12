CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CL_PUNKT_SPR_ZU_2 as
   -- 20080313  Checkliste_punkt_id + Langtext
   -- 20081216: cpr_suchfeld_id wurde aus Tabelle NULL gesetzt
   -- 20081216: Aktuellster Satz durch " dat_bis = '9999-12-31' " Einschränkung
   -- cpr_suchfeld_id NULL gesetzt
   -- 20090114: cpr_suchfeld wird wieder geliefert statt suchfeld_bez
   -- 20090205: Ausgabe von Mandant_id, dazu join der Hierachie bis cpr_projekt_per_2
   --20180223 nfis0811: Erweiterung für (Spalten)-Internationalisierung

   SELECT
   t01.checkliste_punkt_id, t03.cpr_suchfeld AS cpr_suchfeld_id, pr.mandant_id, MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_bez ELSE NULL END) AS cl_punkt_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN  t01.spr_id = 124 THEN t01.cl_punkt_bez END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_bez ELSE NULL END) ) AS cl_punkt_bez_cz  -- CZ
   , COALESCE(MAX(CASE WHEN  t01.spr_id = 108 THEN t01.cl_punkt_bez END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_bez ELSE NULL END) ) AS cl_punkt_bez_sk  -- SK
   , COALESCE(MAX(CASE WHEN t01.spr_id =  65 THEN t01.cl_punkt_bez END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_bez ELSE NULL END) ) AS cl_punkt_bez_hr  -- HR
   , COALESCE(MAX(CASE WHEN  t01.spr_id=  90 THEN t01.cl_punkt_bez END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_bez ELSE NULL END) ) AS cl_punkt_bez_pl  -- PL
   , COALESCE(MAX(CASE WHEN  t01.spr_id =  95 THEN t01.cl_punkt_bez END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_bez ELSE NULL END) ) AS cl_punkt_bez_ro  -- RO
   , COALESCE(MAX(CASE WHEN  t01.spr_id =  24 THEN t01.cl_punkt_bez END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_bez ELSE NULL END) ) AS cl_punkt_bez_en  -- EN
   , COALESCE(MAX(CASE WHEN  t01.spr_id =  18 THEN t01.cl_punkt_bez END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_bez ELSE NULL END) ) AS cl_punkt_bez_bg  -- BG
   , MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_langtext ELSE NULL END) AS cl_punkt_langtext                 -- standard == DE
   , COALESCE(MAX(CASE WHEN  t01.spr_id = 124 THEN t01.cl_punkt_langtext END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_langtext ELSE NULL END) ) AS cl_punkt_langtext_cz  -- CZ
   , COALESCE(MAX(CASE WHEN  t01.spr_id = 108 THEN t01.cl_punkt_langtext END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_langtext ELSE NULL END) ) AS cl_punkt_langtext_sk  -- SK
   , COALESCE(MAX(CASE WHEN t01.spr_id =  65 THEN t01.cl_punkt_langtext END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_langtext ELSE NULL END) ) AS cl_punkt_langtext_hr  -- HR
   , COALESCE(MAX(CASE WHEN  t01.spr_id=  90 THEN t01.cl_punkt_langtext END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_langtext ELSE NULL END) ) AS cl_punkt_langtext_pl  -- PL
   , COALESCE(MAX(CASE WHEN  t01.spr_id =  95 THEN t01.cl_punkt_langtext END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_langtext ELSE NULL END) ) AS cl_punkt_langtext_ro  -- RO
   , COALESCE(MAX(CASE WHEN  t01.spr_id =  24 THEN t01.cl_punkt_langtext END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_langtext ELSE NULL END) ) AS cl_punkt_langtext_en  -- EN
   , COALESCE(MAX(CASE WHEN  t01.spr_id =  18 THEN t01.cl_punkt_langtext END), MAX(CASE WHEN t01.spr_id =  22 THEN t01.cl_punkt_langtext ELSE NULL END) ) AS cl_punkt_langtext_bg  -- BG

   FROM dbp_view.v_cl_punkt_spr_zu_per_2 AS  t01

   JOIN dbp_view.v_cpr_cl_punkt_per_2 AS   t02
   ON t01.checkliste_punkt_id = t02.checkliste_punkt_id
   AND t02.dat_bis = '9999-12-31'
   INNER JOIN dbp_view.v_cpr_checkliste_per_2  cl
   ON  t02.cpr_checkliste_id = cl.cpr_checkliste_id
   AND  cl.dat_bis = '9999-12-31'
   INNER JOIN dbp_view.v_cpr_phase_per_2   ph
   ON  cl.projekt_phase_id = ph.projekt_phase_id
   AND  ph.dat_bis = '9999-12-31'
   INNER JOIN dbp_view.v_cpr_projekt_per_2  pr
   ON  ph.projekt_id = pr.projekt_id
   AND  pr.dat_bis = '9999-12-31'

   JOIN dbp_view.v_l_cpr_suchfeld_2 AS   t03
   ON t02.cpr_suchfeld_id = t03.cpr_suchfeld_id

   --join dbp_view.v_cpr_suchfeld_spr_zu_2 as  t04
   --on t02.cpr_suchfeld_id = t04.cpr_suchfeld_id
   --and t01.spr_id = t04.spr_id

   WHERE
   t01.dat_bis = '9999-12-31'

   GROUP BY
   t01.checkliste_punkt_id
   ,t03.cpr_suchfeld
   ,pr.mandant_id;