
INSERT INTO DBP_ETL.useg_agg_dat
(
   wup_id
  ,nb_id
  ,dat
  ,mandant_id
)
SELECT
   t2.wup_id
  ,t2.nb_id
  ,t2.dat_umbew
  ,t2.mandant_id
FROM DBP_ETL.kmo_idb_zmuseg t1

INNER JOIN DBP_DATA.art_umbewertung t2
ON   t1.mandant_id      = t2.mandant_id
AND  t1.umbew_beleg_id  = t2.umbew_beleg_id
AND  t1.umbew_beleg_pos_id= t2.umbew_beleg_pos_id
AND  t1.kj              = t2.kj

INNER JOIN DBP_DATA.abschriftart_abschriftgrp_zu t3
ON  t3.mandant_id         = t2.mandant_id
AND t3.abschriftart_id    = t2.preis_aend_grund_id
AND t3.abschriftgruppe_id = 400
GROUP BY 1,2,3,4
;


DELETE FROM DBP_DATA.marktabschriften_wg_sum
WHERE
(
         wup_id
        ,nb_id
        ,dat
        ,mandant_id
)
IN
(
        SELECT
        wup_id
        ,nb_id
        ,dat
        ,mandant_id
        FROM
        DBP_ETL.useg_agg_dat
)
AND mandant_id NOT IN (1)
AND (mandant_id,abschriftart_id) IN
        (SELECT
        mandant_id
        ,abschriftart_id
        FROM DBP_DATA.abschriftart_abschriftgrp_zu
        WHERE abschriftgruppe_id = 400
        )
;


INSERT INTO DBP_DATA.marktabschriften_wg_sum
(
wup_id
,nb_id
,dat
,mandant_id
,wg_id
,abschriftart_ID
,wrg_id
,arthiertyp_id
,abschriftbetrag_netto
,abschriftbetrag_brutto
)
SELECT
t1.wup_id
,t1.nb_id
,t1.dat_umbew
,t1.mandant_id
,t2.wg_id
,t1.preis_aend_grund_id
,t1.wrg_id
,t2.arthiertyp_id
,SUM(t1.diff_wert_bestand_netto)
,SUM(t1.diff_wert_bestand_brutto)
FROM  DBP_DATA.art_umbewertung t1
INNER JOIN  DBP_DATA.art_wg_zu_per t2
ON  t1.mandant_id = t2.mandant_id
AND t1.art_id     = t2.art_id
AND t1.dat_umbew BETWEEN t2.dat_von AND t2.dat_bis
AND t2.arthiertyp_id = 2

INNER JOIN DBP_DATA.abschriftart_abschriftgrp_zu t3
ON  t3.mandant_id      = t1.mandant_id
AND t3.abschriftart_id = t1.preis_aend_grund_id
AND t3.abschriftgruppe_id = 400
WHERE
(
t1.wup_id
,t1.nb_id
,t1.dat_umbew
,t1.mandant_id
)
IN
(
SELECT
wup_id
,nb_id
,dat
,mandant_id
FROM
DBP_ETL.useg_agg_dat
)

GROUP BY 1,2,3,4,5,6,7,8
;

