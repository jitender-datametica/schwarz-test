CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_SB_AGGREGAT_GRUND_SPR_ZU_2 as
   --SPRACHE Gruende fuer Filiale/Gesamt - Bereich - Detail
   --Denormaliserte Variante (= komplette Tabelle)
   --20120213 Initial
   --2014KW20: Performance Teil 1 (UNION fuer Dummywerte entfernt)
   --2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   SELECT
   v01.mandant_id, v01.sb_grund_id, MAX(CASE WHEN spr_id =  22 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez     --standard=deutsch
   , MAX(CASE WHEN spr_id =  22 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_de  --deutsch
   , MAX(CASE WHEN spr_id = 124 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_cz  --tschechisch
   , MAX(CASE WHEN spr_id =  90 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_pl  --polnisch
   , MAX(CASE WHEN spr_id = 108 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_sk  --slowakisch
   , MAX(CASE WHEN spr_id =  65 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_hr  --kroatisch
   , MAX(CASE WHEN spr_id =  95 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_ro  --rumänisch
   , MAX(CASE WHEN spr_id =  18 THEN sb_grund_bez ELSE NULL END) AS sb_grund_bez_bg  --bulgarisch
   FROM dbp_view.v_sb_grund_spr_zu_2 v01
   GROUP BY
   v01.mandant_id
   ,v01.sb_grund_id;