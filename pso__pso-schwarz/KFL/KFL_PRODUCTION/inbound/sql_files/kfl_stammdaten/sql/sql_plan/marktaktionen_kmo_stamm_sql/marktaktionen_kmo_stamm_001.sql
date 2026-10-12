--use database kfl_quality;

CREATE or replace VOLATILE TABLE _tage AS (
SELECT dat
FROM DBP_DATA.tag
WHERE dat BETWEEN CURRENT_DATE-45 AND CURRENT_DATE
GROUP BY 1
);

CREATE or replace VOLATILE TABLE _x1 AS (
SELECT  b.wup_id,
        b.nb_id,
        b.aktion_id,
        b.mandant_id,
        a.dat,
        b.art_id,
        b.vk_aktion_brutto,
        b.vk_vor_aktion_brutto,
        c.mwst_id,
        b.wrg_id AS wrg_id,                                                                                        
        b.dat_preisaktiviert
FROM _tage a
JOIN (SELECT a.mandant_id,
             a.aktion_id,
             a.dat_von,
             a.dat_bis,
             b.wup_id,
             b.nb_id,
             b.art_id,
             b.vk_aktion_brutto,
             b.vk_vor_aktion_brutto,
             b.dat_preisaktiviert,
             b.wrg_id                                                                                        
      FROM DBP_DATA.aktion a
      JOIN DBP_DATA.aktion_art_wup_zu b
        ON a.mandant_id = b.mandant_id AND
           a.aktion_id = b.aktion_id
      WHERE (UPPER(b.grund_sperrung) <> 'X' OR 
             b.grund_sperrung IS NULL) AND
             a.mandant_id > 1
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11) b
  ON a.dat BETWEEN b.dat_von AND b.dat_bis
JOIN DBP_DATA.art c
  ON b.mandant_id = c.mandant_id AND
     b.art_id = c.art_id
JOIN DBP_DATA.mandant d
  ON b.mandant_id = d.mandant_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
);

DELETE FROM _x1
WHERE mandant_id IN (7) AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

DELETE FROM _x1
WHERE mandant_id IN (2) AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

DELETE FROM _x1
WHERE mandant_id IN (4) AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

DELETE FROM _x1
WHERE mandant_id IN (3) AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

DELETE FROM _x1
WHERE mandant_id IN (6) AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

DELETE FROM _x1
WHERE mandant_id IN (5) AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

DELETE FROM _x1
WHERE mandant_id IN (8) AND
     (mandant_id,aktion_id) IN (SELECT mandant_id,aktion_id FROM DBP_DATA.l_bonuskauf)
;

CREATE or replace VOLATILE TABLE _x2 LIKE _x1;

INSERT INTO _x2
SELECT a.*
FROM _x1 a
JOIN (SELECT wup_id,
             nb_id,
             mandant_id,
             dat,
             art_id
      FROM _x1
      GROUP BY 1,2,3,4,5
      HAVING COUNT(*) = 1) b
ON a.mandant_id = b.mandant_id AND
    a.wup_id = b.wup_id AND
    a.nb_id = b.nb_id AND
    a.dat = b.dat AND
    a.art_id = b.art_id
;

DELETE FROM _x1
WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
                                               FROM _x2)
;

INSERT INTO _x2
SELECT a.*
FROM _x1 a
JOIN (SELECT x.wup_id,
             x.nb_id,
             x.mandant_id,
             x.dat,
             x.art_id,
             y.aktion_id
      FROM (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id
            FROM _x1
            WHERE dat_preisaktiviert <> '1900-01-01'
            GROUP BY 1,2,3,4,5) x
      JOIN (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id,
                   MAX(aktion_id) AS aktion_id
            FROM _x1
            WHERE dat_preisaktiviert <> '1900-01-01'
            GROUP BY 1,2,3,4,5
            HAVING COUNT(*) = 1) y
        ON x.mandant_id = y.mandant_id AND
           x.wup_id = y.wup_id AND
           x.nb_id = y.nb_id AND
           x.art_id = y.art_id AND
           x.dat = y.dat) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.dat = b.dat AND
     a.art_id = b.art_id AND
     a.aktion_id = b.aktion_id
;

DELETE FROM _x1
WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
                                               FROM _x2)
;

INSERT INTO _x2
SELECT a.*
FROM _x1 a
JOIN (SELECT x.wup_id,
             x.nb_id,
             x.mandant_id,
             x.dat,
             x.art_id,
             y.aktion_id
      FROM (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id
            FROM _x1
            WHERE LENGTH(TRIM(aktion_id)) = 8
            GROUP BY 1,2,3,4,5) x
      JOIN (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id,
                   MAX(aktion_id) AS aktion_id
            FROM _x1
            WHERE LENGTH(TRIM(aktion_id)) = 8
            GROUP BY 1,2,3,4,5
            HAVING COUNT(*) = 1) y
        ON x.mandant_id = y.mandant_id AND
           x.wup_id = y.wup_id AND
           x.nb_id = y.nb_id AND
           x.art_id = y.art_id AND
           x.dat = y.dat) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.dat = b.dat AND
     a.art_id = b.art_id AND
     a.aktion_id = b.aktion_id
;

DELETE FROM _x1
WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
                                               FROM _x2)
;

INSERT INTO _x2
SELECT a.*
FROM _x1 a
JOIN (SELECT x.wup_id,
             x.nb_id,
             x.mandant_id,
             x.dat,
             x.art_id,
             x.dat_preisaktiviert,
             y.aktion_id
      FROM (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id,
                   MAX(dat_preisaktiviert) AS dat_preisaktiviert
                   FROM _x1
            GROUP BY 1,2,3,4,5) x
      JOIN (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id,
                   dat_preisaktiviert,
                   MAX(aktion_id) AS aktion_id
            FROM _x1
            GROUP BY 1,2,3,4,5,6
            HAVING COUNT(*) = 1) y
        ON x.mandant_id = y.mandant_id AND
           x.wup_id = y.wup_id AND
           x.nb_id = y.nb_id AND
           x.dat = y.dat AND
           x.art_id = y.art_id AND
           x.dat_preisaktiviert = y.dat_preisaktiviert
      GROUP BY 1,2,3,4,5,6,7) b
ON a.mandant_id = b.mandant_id AND
   a.wup_id = b.wup_id AND
   a.nb_id = b.nb_id AND
   a.dat = b.dat AND
   a.art_id = b.art_id AND
   a.aktion_id = b.aktion_id AND
   a.dat_preisaktiviert = b.dat_preisaktiviert
;

DELETE FROM _x1
WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
                                               FROM _x2)
;

INSERT INTO _x2
SELECT a.*
FROM _x1 a
JOIN (SELECT x.wup_id,
             x.nb_id,
             x.mandant_id,
             x.dat,
             x.art_id,
             x.aktion_id
      FROM _x1 x
      JOIN (SELECT wup_id,
                   nb_id,
                   mandant_id,
                   dat,
                   art_id,
                   MAX(aktion_id) AS aktion_id
            FROM _x1
            GROUP BY 1,2,3,4,5) y
        ON x.mandant_id = y.mandant_id AND
           x.wup_id = y.wup_id AND
           x.nb_id = y.nb_id AND
           x.dat = y.dat AND
           x.art_id = y.art_id AND
           x.aktion_id = y.aktion_id
      GROUP BY 1,2,3,4,5,6) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.dat = b.dat AND
     a.art_id = b.art_id AND
     a.aktion_id = b.aktion_id
;

DELETE FROM _x1
WHERE (mandant_id,wup_id,nb_id,dat,art_id) IN (SELECT mandant_id,wup_id,nb_id,dat,art_id
                                               FROM _x2)
;



DELETE FROM DBP_ETL_PROCESS.marktabschriften_stamm
WHERE dat IN (SELECT dat FROM _tage)
;

INSERT INTO DBP_ETL_PROCESS.marktabschriften_stamm (wup_id
                                                   ,nb_id
                                                   ,aktion_id
                                                   ,mandant_id
                                                   ,dat
                                                   ,art_id
                                                   ,bewart_id
                                                   ,vk_aktion_brutto
                                                   ,vk_vor_aktion_brutto
                                                   ,mwst_id
                                                   ,wrg_id
                                                   ,dat_preisaktiviert
                                                   ,aktion_relevant_fg)
SELECT wup_id
      ,nb_id
      ,aktion_id
      ,mandant_id
      ,dat
      ,art_id
      ,1002 as bewart_id
      ,vk_aktion_brutto
      ,vk_vor_aktion_brutto
      ,mwst_id
      ,wrg_id
      ,dat_preisaktiviert
      ,1 AS aktion_relevant_fg
FROM _x2
;

