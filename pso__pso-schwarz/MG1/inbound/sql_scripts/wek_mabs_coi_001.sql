/* AW check 2021-05-17*/
DELETE FROM DBP_DATA.marktabschriften_coi;

INSERT INTO DBP_DATA.marktabschriften_coi (wup_id
                                                        ,wup_abschrift_id
                                                        ,positionsnummer_id
                                                        ,nb_id
                                                        ,dat
                                                        ,mandant_id
                                                        ,lastupd_dat
                                                        ,woche_id
                                                        ,menge_abschrift
                                                        ,abschriftart_id
                                                        ,art_id
                                                        ,abschriftbetrag_netto
                                                        ,abschriftbetrag_brutto
                                                        ,wrg_id
                                                        ,wv_kz
                                                        ,wv_grund_id
                                                        ,vk_aktion_brutto
                                                        ,vk_brutto)
SELECT wup_id
      ,wup_abschrift_id
      ,positionsnummer_id
      ,nb_id
      ,dat
      ,mandant_id
      ,lastupd_dat
      ,woche_id
      ,menge_abschrift
      ,abschriftart_id
      ,art_id
      ,abschriftbetrag_netto
      ,abschriftbetrag_brutto
      ,wrg_id
      ,wv_kz
      ,wv_grund_id
      ,vk_aktion_brutto
      ,vk_brutto
FROM DBP_DATA.marktabschriften
WHERE dat BETWEEN (SELECT MIN(dat)
                   FROM DBP_DATA.tag
                   WHERE akt_mo = -24) AND CURRENT_DATE-1 AND
      ((mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL ) OR 
       (mandant_id >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)))
;

INSERT INTO DBP_DATA.marktabschriften_coi (wup_id
                                                        ,wup_abschrift_id
                                                        ,positionsnummer_id
                                                        ,nb_id
                                                        ,dat
                                                        ,mandant_id
                                                        ,lastupd_dat
                                                        ,woche_id
                                                        ,menge_abschrift
                                                        ,abschriftart_id
                                                        ,art_id
                                                        ,abschriftbetrag_netto
                                                        ,abschriftbetrag_brutto
                                                        ,wrg_id
                                                        ,wv_kz
                                                        ,wv_grund_id
                                                        ,vk_aktion_brutto
                                                        ,vk_brutto)
SELECT a.wup_id,
       -1 AS wup_abschrift_id,
       -1 AS positionsnummer,
       a.nb_id,
       a.dat_umbew AS dat,
       a.mandant_id,
       '1900-01-01' AS lastupd_dat,
       999999 AS woche_id,
       SUM(0) AS menge_abschrift,
       a.preis_aend_grund_id AS abschriftart_id,
       a.art_id,
       SUM(a.diff_wert_bestand_netto) AS abschriftbetrag_netto,
       SUM(a.diff_wert_bestand_brutto) AS abschriftbetrag_brutto,
       a.wrg_id,
       '' AS wv_kz,
       0 AS wv_grund_id,
       0 AS vk_aktion_brutto,
       0 AS vk_aktion_netto
FROM DBP_DATA.art_umbewertung a
WHERE a.mandant_id > 1 AND
     ((a.mandant_id IN (2,5) AND
      a.preis_aend_grund_id IN (7,10)) OR
      (a.mandant_id IN (6) AND
      a.preis_aend_grund_id IN (2)) OR
      (a.mandant_id IN (3) AND
      a.preis_aend_grund_id IN (11)) OR
      (a.mandant_id IN (4,7,8) AND
      a.preis_aend_grund_id IN (7))) AND
      a.dat_umbew BETWEEN (SELECT MIN(dat)
                           FROM DBP_DATA.tag
                           WHERE akt_mo = -24) AND CURRENT_DATE-1
GROUP BY 1,2,3,4,5,6,7,8,10,11,14,15,16,17,18
;

DELETE FROM DBP_MSI_DATA.marktabschriften_coi_mo;

INSERT INTO DBP_MSI_DATA.marktabschriften_coi_mo (wup_id
                                                               ,nb_id
                                                               ,kjmo
                                                               ,mandant_id
                                                               ,abschriftart_id
                                                               ,art_id
                                                               ,abschriftbetrag_netto
                                                               ,abschriftbetrag_netto_vj
                                                               ,wrg_id
                                                               ,wup_bereinigt_fg)
SELECT
fact.wup_id,
fact.nb_id,
tag.kjmo,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN (fact.abschriftbetrag_netto *-1)
WHEN mandant_id = 1 THEN (fact.abschriftbetrag_netto *-1)  ELSE fact.abschriftbetrag_netto END AS abschriftbetrag_netto,
CAST(0 AS DECIMAL(18,2)) AS abschriftbetrag_netto_vj,
fact.wrg_id,
0 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
WHERE ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
tag.kjmo,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs)
WHEN mandant_id = 1  THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs) ELSE (fact.abschriftbetrag_netto * ku.umrechnungskurs ) END AS abschriftbetrag_netto,
0 AS abschriftbetrag_netto_vj,
'EUR' AS wrg_id,
0 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.kurs ku
ON (ku.von_wrg_id = fact.wrg_id
AND ku.kurstyp_id = 3
AND ku.dat_bis = to_date('9999-12-31','YYYY-MM-DD'))
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
WHERE fact.wrg_id <> 'EUR'
AND ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
tag.kjmo,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN (fact.abschriftbetrag_netto *-1)
WHEN fact.mandant_id = 1 THEN (fact.abschriftbetrag_netto *-1)  ELSE fact.abschriftbetrag_netto END AS abschriftbetrag_netto,
0 AS abschriftbetrag_netto_vj,
fact.wrg_id,
1 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
JOIN DBP_DATA.wup wup
ON  (fact.mandant_id = wup.mandant_id AND
fact.nb_id = wup.nb_id AND
fact.wup_id = wup.wup_id)
WHERE ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.wo_dat_von > ADD_MONTHS(wup.dat_von,12)
AND tag.wo_dat_bis < wup.dat_bis

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
tag.kjmo,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs)
WHEN fact.mandant_id = 1  THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs) ELSE (fact.abschriftbetrag_netto * ku.umrechnungskurs ) END AS abschriftbetrag_netto,
0 AS abschriftbetrag_netto_vj,
'EUR' AS wrg_id,
1 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.kurs ku
ON (ku.von_wrg_id = fact.wrg_id
AND ku.kurstyp_id = 3
AND ku.dat_bis = to_date('9999-12-31','YYYY-MM-DD'))
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
JOIN DBP_DATA.wup wup
ON  (fact.mandant_id = wup.mandant_id AND
fact.nb_id = wup.nb_id AND
fact.wup_id = wup.wup_id)
WHERE fact.wrg_id <> 'EUR'
AND ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.wo_dat_von > ADD_MONTHS(wup.dat_von,12)
AND tag.wo_dat_bis < wup.dat_bis

UNION ALL

-- Vorjahr

SELECT
fact.wup_id,
fact.nb_id,
tag.kjmo + 100,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
0 AS abschriftbetrag_netto,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN (fact.abschriftbetrag_netto *-1)
WHEN mandant_id = 1 THEN (fact.abschriftbetrag_netto *-1)  ELSE fact.abschriftbetrag_netto END AS abschriftbetrag_netto_vj,
fact.wrg_id,
0 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
WHERE ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.akt_tag <= -365

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
tag.kjmo + 100,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
0 AS abschriftbetrag_netto,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs)
WHEN mandant_id = 1  THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs) ELSE (fact.abschriftbetrag_netto * ku.umrechnungskurs ) END AS abschriftbetrag_netto_vj,
'EUR' AS wrg_id,
0 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.kurs ku
ON (ku.von_wrg_id = fact.wrg_id
AND ku.kurstyp_id = 3
AND ku.dat_bis = to_date('9999-12-31','YYYY-MM-DD'))
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
WHERE fact.wrg_id <> 'EUR'
AND ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.akt_tag <= -365

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
tag.kjmo + 100,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
0 AS abschriftbetrag_netto,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN (fact.abschriftbetrag_netto *-1)
WHEN fact.mandant_id = 1 THEN (fact.abschriftbetrag_netto *-1)  ELSE fact.abschriftbetrag_netto END AS abschriftbetrag_netto_vj,
fact.wrg_id,
1 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
JOIN DBP_DATA.wup wup
ON  (fact.mandant_id = wup.mandant_id AND
fact.nb_id = wup.nb_id AND
fact.wup_id = wup.wup_id)
WHERE ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.wo_dat_von > ADD_MONTHS(wup.dat_von,12)
AND tag.wo_dat_bis < wup.dat_bis
AND tag.akt_tag <= -365

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
tag.kjmo + 100,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
0 AS abschriftbetrag_netto,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs)
WHEN fact.mandant_id = 1  THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs) ELSE (fact.abschriftbetrag_netto * ku.umrechnungskurs ) END AS abschriftbetrag_netto_vj,
'EUR' AS wrg_id,
1 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.kurs ku
ON (ku.von_wrg_id = fact.wrg_id
AND ku.kurstyp_id = 3
AND ku.dat_bis = to_date('9999-12-31','YYYY-MM-DD'))
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
JOIN DBP_DATA.wup wup
ON  (fact.mandant_id = wup.mandant_id AND
fact.nb_id = wup.nb_id AND
fact.wup_id = wup.wup_id)
WHERE fact.wrg_id <> 'EUR'
AND ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.wo_dat_von > ADD_MONTHS(wup.dat_von,12)
AND tag.wo_dat_bis < wup.dat_bis
AND tag.akt_tag <= -365
;

DELETE FROM DBP_MSI_DATA.marktabschriften_coi_dat;

INSERT INTO DBP_MSI_DATA.marktabschriften_coi_dat (wup_id
                                                                ,nb_id
                                                                ,dat
                                                                ,mandant_id
                                                                ,abschriftart_id
                                                                ,art_id
                                                                ,abschriftbetrag_netto
                                                                ,abschriftbetrag_netto_vj
                                                                ,wrg_id
                                                                ,wup_bereinigt_fg)
SELECT
fact.wup_id,
fact.nb_id,
fact.dat,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN (fact.abschriftbetrag_netto *-1)
WHEN mandant_id = 1 THEN (fact.abschriftbetrag_netto *-1)  ELSE fact.abschriftbetrag_netto END AS abschriftbetrag_netto,
CAST(0 AS DECIMAL(18,2)) AS abschriftbetrag_netto_vj,
fact.wrg_id,
0 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
WHERE ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
fact.dat,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs)
WHEN mandant_id = 1  THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs) ELSE (fact.abschriftbetrag_netto * ku.umrechnungskurs ) END AS abschriftbetrag_netto,
0 AS abschriftbetrag_netto_vj,
'EUR' AS wrg_id,
0 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.kurs ku
ON (ku.von_wrg_id = fact.wrg_id
AND ku.kurstyp_id = 3
AND ku.dat_bis = to_date('9999-12-31','YYYY-MM-DD'))
WHERE fact.wrg_id <> 'EUR'
AND ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
fact.dat,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN (fact.abschriftbetrag_netto *-1)
WHEN fact.mandant_id = 1 THEN (fact.abschriftbetrag_netto *-1)  ELSE fact.abschriftbetrag_netto END AS abschriftbetrag_netto,
0 AS abschriftbetrag_netto_vj,
fact.wrg_id,
1 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
JOIN DBP_DATA.wup wup
ON  (fact.mandant_id = wup.mandant_id AND
fact.nb_id = wup.nb_id AND
fact.wup_id = wup.wup_id)
WHERE ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.wo_dat_von > wup.dat_von + 364
AND tag.wo_dat_bis < wup.dat_bis

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
fact.dat,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs)
WHEN fact.mandant_id = 1  THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs) ELSE (fact.abschriftbetrag_netto * ku.umrechnungskurs ) END AS abschriftbetrag_netto,
0 AS abschriftbetrag_netto_vj,
'EUR' AS wrg_id,
1 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.kurs ku
ON (ku.von_wrg_id = fact.wrg_id
AND ku.kurstyp_id = 3
AND ku.dat_bis = to_date('9999-12-31','YYYY-MM-DD'))
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
JOIN DBP_DATA.wup wup
ON  (fact.mandant_id = wup.mandant_id AND
fact.nb_id = wup.nb_id AND
fact.wup_id = wup.wup_id)
WHERE fact.wrg_id <> 'EUR'
AND ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.wo_dat_von > wup.dat_von + 364
AND tag.wo_dat_bis < wup.dat_bis

UNION ALL

-- Vorjahr

SELECT
fact.wup_id,
fact.nb_id,
fact.dat + 364,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
0 AS abschriftbetrag_netto,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN (fact.abschriftbetrag_netto *-1)
WHEN mandant_id = 1 THEN (fact.abschriftbetrag_netto *-1)  ELSE fact.abschriftbetrag_netto END AS abschriftbetrag_netto_vj,
fact.wrg_id,
0 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
WHERE ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.akt_tag <= -364

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
fact.dat + 364,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
0 AS abschriftbetrag_netto,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs)
WHEN mandant_id = 1  THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs) ELSE (fact.abschriftbetrag_netto * ku.umrechnungskurs ) END AS abschriftbetrag_netto_vj,
'EUR' AS wrg_id,
0 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.kurs ku
ON (ku.von_wrg_id = fact.wrg_id
AND ku.kurstyp_id = 3
AND ku.dat_bis = to_date('9999-12-31','YYYY-MM-DD'))
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
WHERE fact.wrg_id <> 'EUR'
AND ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.akt_tag <= -364

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
fact.dat + 364,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
0 AS abschriftbetrag_netto,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN (fact.abschriftbetrag_netto *-1)
WHEN fact.mandant_id = 1 THEN (fact.abschriftbetrag_netto *-1)  ELSE fact.abschriftbetrag_netto END AS abschriftbetrag_netto_vj,
fact.wrg_id,
1 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
JOIN DBP_DATA.wup wup
ON  (fact.mandant_id = wup.mandant_id AND
fact.nb_id = wup.nb_id AND
fact.wup_id = wup.wup_id)
WHERE ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.wo_dat_von > wup.dat_von + 364
AND tag.wo_dat_bis < wup.dat_bis
AND tag.akt_tag <= -364

UNION ALL

SELECT
fact.wup_id,
fact.nb_id,
fact.dat + 364,
fact.mandant_id,
fact.abschriftart_id,
fact.art_id,
0 AS abschriftbetrag_netto,
CASE WHEN (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988)) THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs)
WHEN fact.mandant_id = 1  THEN ((fact.abschriftbetrag_netto *-1) * ku.umrechnungskurs) ELSE (fact.abschriftbetrag_netto * ku.umrechnungskurs ) END AS abschriftbetrag_netto_vj,
'EUR' AS wrg_id,
1 AS wup_bereinigt_fg
FROM DBP_DATA.marktabschriften_coi fact
JOIN DBP_DATA.kurs ku
ON (ku.von_wrg_id = fact.wrg_id
AND ku.kurstyp_id = 3
AND ku.dat_bis = to_date('9999-12-31','YYYY-MM-DD'))
JOIN DBP_DATA.tag tag
ON  (fact.dat = tag.dat)
JOIN DBP_DATA.wup wup
ON  (fact.mandant_id = wup.mandant_id AND
fact.nb_id = wup.nb_id AND
fact.wup_id = wup.wup_id)
WHERE fact.wrg_id <> 'EUR'
AND ((fact.mandant_id =  1 AND abschriftart_id IN(5,7,9,10,23,32,100,101,102,103,104,105,107,120,121,122,151,152,153,154,155,156,157,158) OR abschriftart_id IS NULL )
OR  (fact.mandant_id  >  1 AND abschriftart_id IN (905,906,917,918,919,920,935,936,947,948,949,950,953,954,963,964,971,972,973,974,975,976,981,982,983,984,985,986,987,988))
OR  (fact.mandant_id  =  2 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  3 AND abschriftart_id IN (11))
OR  (fact.mandant_id  =  4 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  5 AND abschriftart_id IN (7,10))
OR  (fact.mandant_id  =  6 AND abschriftart_id IN (2))
OR  (fact.mandant_id  =  7 AND abschriftart_id IN (7))
OR  (fact.mandant_id  =  8 AND abschriftart_id IN (7)))
AND tag.wo_dat_von > wup.dat_von + 364
AND tag.wo_dat_bis < wup.dat_bis
AND tag.akt_tag <= -364
;

