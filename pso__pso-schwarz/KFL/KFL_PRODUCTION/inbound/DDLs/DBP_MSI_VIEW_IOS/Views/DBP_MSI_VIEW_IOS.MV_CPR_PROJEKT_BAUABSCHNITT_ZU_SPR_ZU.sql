CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_CPR_PROJEKT_BAUABSCHNITT_ZU_SPR_ZU as
   SELECT
   CAST( v01.bauabschnitt_id AS VARCHAR(64))  AS bauabschnitt_id, MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_bez ELSE NULL END) AS bauabschnitt_bez                 -- standard == DE
   , COALESCE(MAX(CASE WHEN sub01.spr_id = 124 THEN  sub01.bauabschnitt_bez ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN sub01.bauabschnitt_bez ELSE NULL END)) AS bauabschnitt_bez_cz    -- CZ
   , COALESCE(MAX(CASE WHEN sub01.spr_id = 108 THEN  sub01.bauabschnitt_bez ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_bez ELSE NULL END)) AS bauabschnitt_bez_sk    -- SK
   , COALESCE(MAX(CASE WHEN sub01.spr_id=  65 THEN  sub01.bauabschnitt_bez ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_bez ELSE NULL END)) AS bauabschnitt_bez_hr    -- HR
   , COALESCE(MAX(CASE WHEN sub01.spr_id =  90 THEN  sub01.bauabschnitt_bez ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_bez ELSE NULL END)) AS bauabschnitt_bez_pl    -- PL
   , COALESCE(MAX(CASE WHEN sub01.spr_id =  95 THEN  sub01.bauabschnitt_bez ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_bez ELSE NULL END)) AS bauabschnitt_bez_ro    -- RO
   , COALESCE(MAX(CASE WHEN sub01.spr_id =  24 THEN  sub01.bauabschnitt_bez ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_bez ELSE NULL END)) AS bauabschnitt_bez_en    -- EN
   , COALESCE(MAX(CASE WHEN sub01.spr_id =  18 THEN  sub01.bauabschnitt_bez ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_bez ELSE NULL END)) AS bauabschnitt_bez_bg    -- BG
   , MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_langtext ELSE NULL END) AS bauabschnitt_langtext                 -- standard == DE
   , COALESCE(MAX(CASE WHEN sub01.spr_id = 124 THEN  sub01.bauabschnitt_langtext ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN sub01.bauabschnitt_langtext ELSE NULL END)) AS bauabschnitt_langtext_cz    -- CZ
   , COALESCE(MAX(CASE WHEN sub01.spr_id = 108 THEN  sub01.bauabschnitt_langtext ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_langtext ELSE NULL END)) AS bauabschnitt_langtext_sk    -- SK
   , COALESCE(MAX(CASE WHEN sub01.spr_id=  65 THEN  sub01.bauabschnitt_langtext ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_langtext ELSE NULL END)) AS bauabschnitt_langtext_hr    -- HR
   , COALESCE(MAX(CASE WHEN sub01.spr_id =  90 THEN  sub01.bauabschnitt_langtext ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_langtext ELSE NULL END)) AS bauabschnitt_langtext_pl    -- PL
   , COALESCE(MAX(CASE WHEN sub01.spr_id =  95 THEN  sub01.bauabschnitt_langtext ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_langtext ELSE NULL END)) AS bauabschnitt_langtext_ro    -- RO
   , COALESCE(MAX(CASE WHEN sub01.spr_id =  24 THEN  sub01.bauabschnitt_langtext ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_langtext ELSE NULL END)) AS bauabschnitt_langtext_en    -- EN
   , COALESCE(MAX(CASE WHEN sub01.spr_id =  18 THEN  sub01.bauabschnitt_langtext ELSE NULL END), MAX(CASE WHEN sub01.spr_id =  22 THEN  sub01.bauabschnitt_langtext ELSE NULL END)) AS bauabschnitt_langtext_bg    -- BG


   FROM dbp_view.v_cpr_projekt_bauabschnitt_zu v01
   INNER JOIN  -- BauabschnittBezeichnung von Allen Projekten, Phasen und Aufgaben
   (
   SELECT v05.projekt_id AS bauabschnitt_id, v05.cpr_projekt_bez AS bauabschnitt_bez, v05.cpr_projekt_langtext AS bauabschnitt_langtext, v05.spr_id
   FROM dbp_view.v_cpr_projekt_spr_zu_per v05
   JOIN dbp_view.v_cpr_projekt_bauabschnitt_zu v01
   ON v05.projekt_id = v01.projekt_id
   WHERE v05.dat_bis = '9999-12-31'
   -- AND v05.spr_id = 22

   UNION

   SELECT v06.projekt_phase_id AS bauabschnitt_id, v06.cpr_phase_bez AS bauabschnitt_bez, v06.cpr_phase_langtext AS bauabschnitt_langtext, v06.spr_id
   FROM dbp_view.v_cpr_phase_spr_zu_per v06
   JOIN dbp_view.v_cpr_projekt_bauabschnitt_zu v01
   ON v06.projekt_phase_id = v01.bauabschnitt_id
   WHERE v06.dat_bis = '9999-12-31'
   --AND v06.spr_id = 22

   UNION

   SELECT v07.cpr_aufgabe_id AS bauabschnitt_id, v07.aufgabe_bez AS bauabschnitt_bez, v07.aufgabe_langtext AS bauabschnitt_langtext, v07.spr_id
   FROM dbp_view.v_cpr_aufgabe_spr_zu_per v07
   JOIN dbp_view.v_cpr_projekt_bauabschnitt_zu v01
   ON v07.cpr_aufgabe_id = v01.bauabschnitt_id
   WHERE v07.dat_bis = '9999-12-31'
   --AND v07.spr_id = 22
   ) sub01
   ON sub01.bauabschnitt_id = v01.bauabschnitt_id

   GROUP BY v01.bauabschnitt_id;