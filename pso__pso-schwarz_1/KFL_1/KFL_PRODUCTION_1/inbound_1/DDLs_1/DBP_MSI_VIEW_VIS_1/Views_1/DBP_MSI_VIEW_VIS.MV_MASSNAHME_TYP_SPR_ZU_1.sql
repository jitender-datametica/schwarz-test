CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MASSNAHME_TYP_SPR_ZU_1 as
   -- 2009-01-20 (komplett neu)
   -- SPRACHZUORDNUNG Maßnahmen (cProjects)
   -- (=LOOKUP da nur eine_1 Sprache)
   -- verwendet in Reorga-Bericht
   -- 2011KW37: Internationalisierung (feste Sprache)
   -- 2013KW09: Komplett ueberarbeitet (CASE)
   -- 2015KW50: M.Gill: Umbau der Internationalisierung von Tabellen auf Spalten
   SELECT DISTINCT
   CASE
   WHEN mm.massnahme_id = 'NB_1'     THEN 1
   WHEN mm.massnahme_id = 'UE'     THEN 2
   WHEN mm.massnahme_id = 'ST'     THEN 3
   WHEN mm.massnahme_id IN ('RE_1','RN')   THEN 4
   WHEN mm.massnahme_id = 'RG'     THEN 5
   WHEN mm.massnahme_id = 'RX'     THEN 6
   WHEN mm.massnahme_id = 'RU'     THEN 7
   WHEN mm.massnahme_id = 'TK'     THEN 8
   WHEN mm.massnahme_id = 'SO'     THEN 9
   WHEN mm.massnahme_id = 'SL'     THEN 10
   ELSE 0
   END::BYTEINT AS massnahme_typ_id, CASE
   WHEN mm.massnahme_id = 'NB_1'     THEN 'Neubau'
   WHEN mm.massnahme_id = 'UE'     THEN 'Übernahme'
   WHEN mm.massnahme_id = 'ST'     THEN 'Standortoptimierung'
   WHEN mm.massnahme_id IN ('RE_1','RN')   THEN 'Reorga'
   WHEN mm.massnahme_id = 'RG'     THEN 'Rückfilialisierung'
   WHEN mm.massnahme_id = 'RX'     THEN 'Kleinmaßnahmen Landesgesellschaften'
   WHEN mm.massnahme_id = 'RU'     THEN 'Sonstige Rückfilialisierung'
   WHEN mm.massnahme_id = 'TK'     THEN 'Konzessionärsmaßnahme'
   WHEN mm.massnahme_id = 'SO'     THEN 'Sonstiges'
   WHEN mm.massnahme_id = 'SL'     THEN 'Schließung'
   ELSE ''
   END::VARCHAR(40) AS massnahme_typ_bez, CASE
   WHEN mm.massnahme_id = 'NB_1'     THEN 'Neubau'
   WHEN mm.massnahme_id = 'UE'     THEN 'Übernahme'
   WHEN mm.massnahme_id = 'ST'     THEN 'Standortoptimierung'
   WHEN mm.massnahme_id IN ('RE_1','RN')   THEN 'Reorga'
   WHEN mm.massnahme_id = 'RG'     THEN 'Rückfilialisierung'
   WHEN mm.massnahme_id = 'RX'     THEN 'Kleinmaßnahmen Landesgesellschaften'
   WHEN mm.massnahme_id = 'RU'     THEN 'Sonstige Rückfilialisierung'
   WHEN mm.massnahme_id = 'TK'     THEN 'Konzessionärsmaßnahme'
   WHEN mm.massnahme_id = 'SO'     THEN 'Sonstiges'
   WHEN mm.massnahme_id = 'SL'     THEN 'Schließung'
   ELSE ''
   END::VARCHAR(40) AS massnahme_typ_bez_de, CASE
   WHEN mm.massnahme_id = 'NB_1'     THEN 'Neubau'
   WHEN mm.massnahme_id = 'UE'     THEN 'Übernahme'
   WHEN mm.massnahme_id = 'ST'     THEN 'Standortoptimierung'
   WHEN mm.massnahme_id IN ('RE_1','RN')   THEN 'Reorga'
   WHEN mm.massnahme_id = 'RG'     THEN 'Rückfilialisierung'
   WHEN mm.massnahme_id = 'RX'     THEN 'Kleinmaßnahmen Landesgesellschaften'
   WHEN mm.massnahme_id = 'RU'     THEN 'Sonstige Rückfilialisierung'
   WHEN mm.massnahme_id = 'TK'     THEN 'Konzessionärsmaßnahme'
   WHEN mm.massnahme_id = 'SO'     THEN 'Sonstiges'
   WHEN mm.massnahme_id = 'SL'     THEN 'Schließung'
   ELSE ''
   END::VARCHAR(40) AS massnahme_typ_bez_cz, CASE
   WHEN mm.massnahme_id = 'NB_1'     THEN 'Neubau'
   WHEN mm.massnahme_id = 'UE'     THEN 'Übernahme'
   WHEN mm.massnahme_id = 'ST'     THEN 'Standortoptimierung'
   WHEN mm.massnahme_id IN ('RE_1','RN')   THEN 'Reorga'
   WHEN mm.massnahme_id = 'RG'     THEN 'Rückfilialisierung'
   WHEN mm.massnahme_id = 'RX'     THEN 'Kleinmaßnahmen Landesgesellschaften'
   WHEN mm.massnahme_id = 'RU'     THEN 'Sonstige Rückfilialisierung'
   WHEN mm.massnahme_id = 'TK'     THEN 'Konzessionärsmaßnahme'
   WHEN mm.massnahme_id = 'SO'     THEN 'Sonstiges'
   WHEN mm.massnahme_id = 'SL'     THEN 'Schließung'
   ELSE ''
   END::VARCHAR(40) AS massnahme_typ_bez_pl, CASE
   WHEN mm.massnahme_id = 'NB_1'     THEN 'Neubau'
   WHEN mm.massnahme_id = 'UE'     THEN 'Übernahme'
   WHEN mm.massnahme_id = 'ST'     THEN 'Standortoptimierung'
   WHEN mm.massnahme_id IN ('RE_1','RN')   THEN 'Reorga'
   WHEN mm.massnahme_id = 'RG'     THEN 'Rückfilialisierung'
   WHEN mm.massnahme_id = 'RX'     THEN 'Kleinmaßnahmen Landesgesellschaften'
   WHEN mm.massnahme_id = 'RU'     THEN 'Sonstige Rückfilialisierung'
   WHEN mm.massnahme_id = 'TK'     THEN 'Konzessionärsmaßnahme'
   WHEN mm.massnahme_id = 'SO'     THEN 'Sonstiges'
   WHEN mm.massnahme_id = 'SL'     THEN 'Schließung'
   ELSE ''
   END::VARCHAR(40) AS massnahme_typ_bez_sk, CASE
   WHEN mm.massnahme_id = 'NB_1'     THEN 'Neubau'
   WHEN mm.massnahme_id = 'UE'     THEN 'Übernahme'
   WHEN mm.massnahme_id = 'ST'     THEN 'Standortoptimierung'
   WHEN mm.massnahme_id IN ('RE_1','RN')   THEN 'Reorga'
   WHEN mm.massnahme_id = 'RG'     THEN 'Rückfilialisierung'
   WHEN mm.massnahme_id = 'RX'     THEN 'Kleinmaßnahmen Landesgesellschaften'
   WHEN mm.massnahme_id = 'RU'     THEN 'Sonstige Rückfilialisierung'
   WHEN mm.massnahme_id = 'TK'     THEN 'Konzessionärsmaßnahme'
   WHEN mm.massnahme_id = 'SO'     THEN 'Sonstiges'
   WHEN mm.massnahme_id = 'SL'     THEN 'Schließung'
   ELSE ''
   END::VARCHAR(40) AS massnahme_typ_bez_hr, CASE
   WHEN mm.massnahme_id = 'NB_1'     THEN 'Neubau'
   WHEN mm.massnahme_id = 'UE'     THEN 'Übernahme'
   WHEN mm.massnahme_id = 'ST'     THEN 'Standortoptimierung'
   WHEN mm.massnahme_id IN ('RE_1','RN')   THEN 'Reorga'
   WHEN mm.massnahme_id = 'RG'     THEN 'Rückfilialisierung'
   WHEN mm.massnahme_id = 'RX'     THEN 'Kleinmaßnahmen Landesgesellschaften'
   WHEN mm.massnahme_id = 'RU'     THEN 'Sonstige Rückfilialisierung'
   WHEN mm.massnahme_id = 'TK'     THEN 'Konzessionärsmaßnahme'
   WHEN mm.massnahme_id = 'SO'     THEN 'Sonstiges'
   WHEN mm.massnahme_id = 'SL'     THEN 'Schließung'
   ELSE ''
   END::VARCHAR(40) AS massnahme_typ_bez_ro, CASE
   WHEN mm.massnahme_id = 'NB_1'     THEN 'Neubau'
   WHEN mm.massnahme_id = 'UE'     THEN 'Übernahme'
   WHEN mm.massnahme_id = 'ST'     THEN 'Standortoptimierung'
   WHEN mm.massnahme_id IN ('RE_1','RN')   THEN 'Reorga'
   WHEN mm.massnahme_id = 'RG'     THEN 'Rückfilialisierung'
   WHEN mm.massnahme_id = 'RX'     THEN 'Kleinmaßnahmen Landesgesellschaften'
   WHEN mm.massnahme_id = 'RU'     THEN 'Sonstige Rückfilialisierung'
   WHEN mm.massnahme_id = 'TK'     THEN 'Konzessionärsmaßnahme'
   WHEN mm.massnahme_id = 'SO'   THEN 'Sonstiges'
   WHEN mm.massnahme_id = 'SL'     THEN 'Schließung'
   ELSE ''
   END::VARCHAR(40) AS massnahme_typ_bez_bg
   FROM dbp_view.v_l_massnahme_1 mm_1;