-- KMO

CREATE OR REPLACE VOLATILE TABLE _werbeartikel_1_kmo_neu AS (
SELECT x1.kjwo,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
	   CASE
         WHEN akt.mandant_id = 2 AND
              akt.dat_bis >= '2019-02-27'
         THEN 6
	     WHEN akt.mandant_id IN (4,7)
		 THEN 6
		 WHEN akt.mandant_id = 8
		 THEN 7
		 ELSE 5
       END AS werbetyp_id,
       akt.avq_relevant_fg
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = CASE
                    WHEN akt.mandant_id = 2 AND
                         akt.dat_bis >= '2019-02-27'
                    THEN 3
                    WHEN akt.mandant_id IN (4,7)
                    THEN 3
                    WHEN akt.mandant_id = 8
                    THEN 1
                    ELSE 4
                  END
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = CASE
                    WHEN akt.mandant_id = 2 AND
                         akt.dat_bis >= '2019-02-27'
                    THEN 2
                    WHEN akt.mandant_id IN (4,7)
                    THEN 2
                    WHEN akt.mandant_id = 8
                    THEN 7
                    ELSE 3
                  END AND
     x2.dat - 6 = x1.dat
WHERE ((akta.grund_sperrung IS NULL AND
        akt.mandant_id IN (2,5,6) AND
	
        x1.akt_wo = 0) OR
       (akta.grund_sperrung IS NULL AND
        akt.mandant_id IN (3) AND
	
	Substr(akt.aktion_id,9,2) NOT IN ('DN','DV','DP','DW','DS','DK') AND
        x1.akt_wo = 0) OR
       (akta.grund_sperrung IS NULL AND
        akt.mandant_id IN (4,7) AND
	
	Substr(akt.aktion_id,9,2) IN ('MM_1','HG','NF') AND
        x1.akt_wo = 0) OR
       (akta.grund_sperrung IS NULL AND
        akt.mandant_id IN (8) AND
	
	POSITION('D1' IN akt.aktion_id) = 0 AND
	POSITION('D2' IN akt.aktion_id) = 0 AND
	POSITION('DS' IN akt.aktion_id) = 0 AND
	POSITION('J' IN akt.aktion_id)  = 0 AND
        x1.akt_wo = 0)) AND 
     ((akt.mandant_id = 8 AND 2 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)) OR
      (akt.mandant_id = 2 AND 4 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)) OR
      (akt.mandant_id = 7 AND 4 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)) OR
      (akt.mandant_id = 3 AND 5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)) OR
      (akt.mandant_id = 5 AND 5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)) OR
      (akt.mandant_id = 6 AND 5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)))
GROUP BY 1,2,3,4,5,6,7,8,9
);


CREATE OR REPLACE VOLATILE TABLE _ff_mutter_art_kmo_neu AS (
SELECT a.mandant_id,
       a.art_id,
       Coalesce(a.mutter_wb_id,a.art_id) AS mutter_wb_id
FROM dbp_data.art_1 a
WHERE a.dat_bis = '9999-12-31' AND
     (a.mandant_id,a.art_id) IN (SELECT mandant_id,
	                                    art_id
	                             FROM _werbeartikel_1_kmo_neu
				                 GROUP BY 1,2)
GROUP BY 1,2,3
);

DELETE FROM dbp_process.werbung_kennzahlen_kopf_1
WHERE (mandant_id,kjwo) IN (SELECT mandant_id,kjwo FROM _werbeartikel_1_kmo_neu)
;

INSERT INTO dbp_process.werbung_kennzahlen_kopf_1 (kjwo
                                                ,wup_id
                                                ,nb_id
                                                ,mandant_id
                                                ,art_id
						,werbe_typ_id
                                                ,posten_id
                                                ,faktor_flaki
                                                ,mutter_wb_id
                                                ,wtag_id_start
                                                ,wtag_id_ende
                                                ,avq_relevant_fg)
SELECT a.kjwo
      ,a.wup_id
      ,0 AS nb_id
      ,a.mandant_id
      ,a.art_id
      ,a.werbetyp_id AS werbe_typ_id
      ,'' AS posten_id
      ,1 AS faktor_flaki
      ,d.mutter_wb_id
      ,b.wtag_id AS wtag_id_start
      ,c.wtag_id AS wtag_id_ende
      ,a.avq_relevant_fg
FROM _werbeartikel_1_kmo_neu a
JOIN dbp_data.tag_1 b
  ON a.dat_von = b.dat
JOIN dbp_data.tag_1 c
  ON a.dat_bis = c.dat
JOIN _ff_mutter_art_kmo_neu d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id
;

DELETE FROM dbp_process.werbung_kennzahlen_kopf_1
WHERE (kjwo,wup_id,nb_id,mandant_id,art_id,werbe_typ_id) IN (SELECT a.kjwo,a.wup_id,a.nb_id,a.mandant_id,a.art_id,a.werbe_typ_id
                                                             FROM dbp_process.werbung_kennzahlen_kopf_1 a
                                                             JOIN dbp_data.art_wg_zu_per_1 b
                                                               ON a.mandant_id = b.mandant_id AND
                                                                  a.art_id = b.art_id AND
	                                                          b.arthiertyp_id = 2 AND
	                                                          b.dat_bis = '9999-12-31'
                                                             WHERE b.wg_id IN (260,292) AND
	                                                          (a.mandant_id,a.kjwo) IN (SELECT mandant_id,kjwo FROM _werbeartikel_1_kmo_neu))
;

-- DE

CREATE OR REPLACE VOLATILE TABLE _werbeartikel_1_neu AS (
SELECT x1.kjwo,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       1 AS werbetyp_id,
       akt.avq_relevant_fg
FROM (select a.*,
             case 
               when b.bonuskauf_id is not null
               then 0
               else 1
             end as avq_relevant_fg
      from dbp_data.aktion_1 a
      left join (select *
                 from dbp_data.l_bonuskauf_1
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
       where a.mandant_id = 1 and
             case
               when b.bonuskauf_id is not null
               then 1
               when b.bonuskauf_id is null and
                    a.preisaktiviert_fg = 1
               then 1
               else 0
             end = 1) akt
JOIN dbp_data.aktion_art_wup_zu_1 akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 7
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 6 = x1.dat
WHERE akta.dat_sperrung IS NULL AND
      akt.mandant_id = 1 AND
      x1.akt_wo = 0 AND
      5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)
GROUP BY 1,2,3,4,5,6,7,8,9
);

INSERT INTO _werbeartikel_1_neu
SELECT x1.kjwo,
       akt.dat_von-1,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       1 AS werbetyp_id,
       akt.avq_relevant_fg
FROM (select a.*,
             case 
               when b.bonuskauf_id is not null
               then 0
               else 1
             end as avq_relevant_fg
      from dbp_data.aktion_1 a
      left join (select *
                 from dbp_data.l_bonuskauf_1
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
       where a.mandant_id = 1 and
             case
               when b.bonuskauf_id is not null
               then 1
               when b.bonuskauf_id is null and
                    a.preisaktiviert_fg = 1
               then 1
               else 0
             end = 1) akt
JOIN dbp_data.aktion_art_wup_zu_1 akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 1
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 5 = x1.dat
WHERE akta.dat_sperrung IS NULL AND
      akt.mandant_id = 1 AND
      x1.akt_wo = 0 AND
      5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE) AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,1) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_neu)
GROUP BY 1,2,3,4,5,6,7,8,9
;

INSERT INTO _werbeartikel_1_neu
SELECT x1.kjwo,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       2 AS werbetyp_id,
       akt.avq_relevant_fg
FROM (select a.*,
             case 
               when b.bonuskauf_id is not null
               then 0
               else 1
             end as avq_relevant_fg
      from dbp_data.aktion_1 a
      left join (select *
                 from dbp_data.l_bonuskauf_1
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
       where a.mandant_id = 1 and
             case
               when b.bonuskauf_id is not null
               then 1
               when b.bonuskauf_id is null and
                    a.preisaktiviert_fg = 1
               then 1
               else 0
             end = 1) akt
JOIN dbp_data.aktion_art_wup_zu_1 akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 4
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 3 AND
     x2.dat - 6 = x1.dat
WHERE akta.dat_sperrung IS NULL AND
      akt.mandant_id = 1 AND
      x1.akt_wo = 0 AND
      5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)
GROUP BY 1,2,3,4,5,6,7,8,9
;

INSERT INTO _werbeartikel_1_neu
SELECT x1.kjwo,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       3 AS werbetyp_id,
       akt.avq_relevant_fg
FROM (select a.*,
             case 
               when b.bonuskauf_id is not null
               then 0
               else 1
             end as avq_relevant_fg
      from dbp_data.aktion_1 a
      left join (select *
                 from dbp_data.l_bonuskauf_1
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
       where a.mandant_id = 1 and
             case
               when b.bonuskauf_id is not null
               then 1
               when b.bonuskauf_id is null and
                    a.preisaktiviert_fg = 1
               then 1
               else 0
             end = 1) akt
JOIN dbp_data.aktion_art_wup_zu_1 akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat+7 AND
     x1.wtag_id = 1
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat+7 AND
     x2.wtag_id = 3 AND
     x2.dat - 2 = x1.dat
WHERE akta.dat_sperrung IS NULL AND
      akt.mandant_id = 1 AND
      x1.akt_wo = 0 AND
      5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)
GROUP BY 1,2,3,4,5,6,7,8,9
;

INSERT INTO _werbeartikel_1_neu
SELECT x1.kjwo,
       akt.dat_von+1,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       3 AS werbetyp_id,
       akt.avq_relevant_fg
FROM (select a.*,
             case 
               when b.bonuskauf_id is not null
               then 0
               else 1
             end as avq_relevant_fg
      from dbp_data.aktion_1 a
      left join (select *
                 from dbp_data.l_bonuskauf_1
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
       where a.mandant_id = 1 and
             case
               when b.bonuskauf_id is not null
               then 1
               when b.bonuskauf_id is null and
                    a.preisaktiviert_fg = 1
               then 1
               else 0
             end = 1) akt
JOIN dbp_data.aktion_art_wup_zu_1 akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 7
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 3 AND
     x2.dat - 3 = x1.dat
WHERE akta.dat_sperrung IS NULL AND
      akt.mandant_id = 1 AND
      x1.akt_wo = 0 AND
      5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE) AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,3) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_neu)
GROUP BY 1,2,3,4,5,6,7,8,9
;

INSERT INTO _werbeartikel_1_neu
SELECT x1.kjwo,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       4 AS werbetyp_id,
       akt.avq_relevant_fg
FROM (select a.*,
             case 
               when b.bonuskauf_id is not null
               then 0
               else 1
             end as avq_relevant_fg
      from dbp_data.aktion_1 a
      left join (select *
                 from dbp_data.l_bonuskauf_1
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
       where a.mandant_id = 1 and
             case
               when b.bonuskauf_id is not null
               then 1
               when b.bonuskauf_id is null and
                    a.preisaktiviert_fg = 1
               then 1
               else 0
             end = 1) akt
JOIN dbp_data.aktion_art_wup_zu_1 akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 4
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 2 = x1.dat
WHERE akta.dat_sperrung IS NULL AND
      akt.mandant_id = 1 AND
      x1.akt_wo = 0 AND
      5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)
GROUP BY 1,2,3,4,5,6,7,8,9
;

INSERT INTO _werbeartikel_1_neu (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,avq_relevant_fg)
SELECT x1.kjwo,
       4 AS werbetyp_id,
       akt.dat_von,
       akt.dat_bis-1,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       akt.avq_relevant_fg
FROM (select a.*,
             case 
               when b.bonuskauf_id is not null
               then 0
               else 1
             end as avq_relevant_fg
      from dbp_data.aktion_1 a
      left join (select *
                 from dbp_data.l_bonuskauf_1
                 where mandant_id = 1) b
        on a.mandant_id = b.mandant_id and
           a.aktion_id = b.aktion_id
       where a.mandant_id = 1 and
             case
               when b.bonuskauf_id is not null
               then 1
               when b.bonuskauf_id is null and
                    a.preisaktiviert_fg = 1
               then 1
               else 0
             end = 1) akt
JOIN dbp_data.aktion_art_wup_zu_1 akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 4
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 7 AND
     x2.dat - 3 = x1.dat
WHERE akta.dat_sperrung IS NULL AND
      akt.mandant_id = 1 AND
      x1.akt_wo = 0 AND
      5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE) AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,4) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_neu)
GROUP BY 1,2,3,4,5,6,7,8,9
;

CREATE OR REPLACE VOLATILE TABLE _ff_mutter_art_neu AS (
SELECT a.mandant_id,
       a.art_id,
       COALESCE(a.mutter_wb_id,a.art_id) AS mutter_wb_id
FROM dbp_data.art_1 a
WHERE a.dat_bis = '9999-12-31' AND
     (a.mandant_id,a.art_id) IN (SELECT mandant_id,
	                                    art_id
	                             FROM _werbeartikel_1_neu
				                 GROUP BY 1,2)
GROUP BY 1,2,3
);

DELETE FROM dbp_process.werbung_kennzahlen_kopf_1
WHERE (mandant_id,kjwo) IN (SELECT mandant_id,kjwo FROM _werbeartikel_1_neu)
;

INSERT INTO dbp_process.werbung_kennzahlen_kopf_1 (kjwo
,wup_id
,nb_id
,mandant_id
,art_id
,werbe_typ_id
,posten_id
,faktor_flaki
,mutter_wb_id
,wtag_id_start
,wtag_id_ende
,avq_relevant_fg)
SELECT a.kjwo
      ,a.wup_id
      ,0 AS nb_id
      ,a.mandant_id
      ,a.art_id
      ,a.werbetyp_id AS werbe_typ_id
      ,'' AS posten_id
      ,1 AS faktor_flaki
      ,d.mutter_wb_id
      ,b.wtag_id AS wtag_id_start
      ,c.wtag_id AS wtag_id_ende
      ,a.avq_relevant_fg
FROM _werbeartikel_1_neu a
JOIN dbp_data.tag_1 b
  ON CASE
       WHEN a.werbetyp_id = 1
       THEN a.dat_von+1
       ELSE a.dat_von
     END = b.dat
JOIN dbp_data.tag_1 c
  ON a.dat_bis = c.dat
JOIN _ff_mutter_art_neu d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id
WHERE 5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)
;

-- 06.12.2016, -dbay-
--
-- Warengruppe 260 fuer DE komplett raus

DELETE FROM dbp_process.werbung_kennzahlen_kopf_1
WHERE (kjwo,wup_id,nb_id,mandant_id,art_id,werbe_typ_id) IN (SELECT a.kjwo,a.wup_id,a.nb_id,a.mandant_id,a.art_id,a.werbe_typ_id
                                                             FROM dbp_process.werbung_kennzahlen_kopf_1 a
                                                             JOIN dbp_data.art_wg_zu_per_1 b
                                                               ON a.mandant_id = b.mandant_id AND
                                                                  a.art_id = b.art_id AND
	                                                              b.arthiertyp_id = 2 AND
	                                                              b.dat_bis = '9999-12-31'
                                                             WHERE a.mandant_id = 1 AND
                                                                   b.wg_id IN (260) AND
	                                                               a.kjwo IN (SELECT kjwo FROM dbp_data.tag_1 WHERE akt_wo = 0)) AND
       5 IN (SELECT wtag_id FROM dbp_data.tag_1 WHERE dat = CURRENT_DATE)
;
