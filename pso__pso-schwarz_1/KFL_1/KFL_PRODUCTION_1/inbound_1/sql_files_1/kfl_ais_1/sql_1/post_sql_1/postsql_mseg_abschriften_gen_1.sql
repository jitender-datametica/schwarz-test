CREATE OR REPLACE TABLE DBP_ETL.rel_lagerbew_abschr_tmp_1  (
        mandant_id            BYTEINT NOT NULL,
        lagerbew_beleg_id     DECIMAL(18,0) NOT NULL,
        kj                    SMALLINT NOT NULL,
        dat_buch              DATE NOT NULL,
        ref_lagerbew_beleg_id VARCHAR(20) COLLATE 'en-ci'
        )
;

CREATE OR REPLACE TABLE DBP_ETL.rel_dat_buch_abschr_tmp_1  (
        dat_buch  DATE NOT NULL
        )
;

CREATE OR REPLACE TABLE DBP_ETL.abschriftart_char_tmp_1  (
        mandant_id        BYTEINT NOT NULL,
        abschriftart_id   CHAR(3) COLLATE 'en-ci'
        )
;

CREATE OR REPLACE TABLE DBP_ETL.marktabschriften_mseg_agg_dat_1  (
        wup_id              INTEGER NOT NULL,
        nb_id               SMALLINT NOT NULL,
        dat                 DATE,
        mandant_id          BYTEINT NOT NULL
        )
;

INSERT INTO DBP_ETL.rel_lagerbew_abschr_tmp_1
(
         mandant_id
        ,lagerbew_beleg_id
        ,kj
        ,dat_buch
        ,ref_lagerbew_beleg_id
)
SELECT
         mandant_id
        ,lagerbew_beleg_id
        ,kj
        ,dat_buch
        ,ref_lagerbew_beleg_id
FROM    DBP_DATA.lagerbew_1

WHERE   mandant_id > 1
  AND   dat_buch BETWEEN CURRENT_DATE - 365 AND CURRENT_DATE 
  AND   COALESCE(TRIM(ref_lagerbew_beleg_id), '') <> ''
  AND   LENGTH(TRIM(ref_lagerbew_beleg_id)) = 14
  AND   (mandant_id, kj, ref_lagerbew_beleg_id) IN          
                (SELECT  mandant_id
                        ,kj
                        ,ref_lagerbew_beleg_id
                 FROM DBP_ETL.mseg_abschriften_gen_1
                )
  AND (mandant_id, lagerbew_beleg_id, kj) NOT IN
                (SELECT  mandant_id
                        ,wup_abschrift_id
                        ,kj
                FROM DBP_ETL.mseg_abschriften_gen_1
                )
;

UPDATE DBP_ETL.mseg_abschriften_gen_1
SET ref_lagerbew_beleg_id = CAST(wup_id AS CHAR(4)) || TRIM(ref_lagerbew_beleg_id)
WHERE LENGTH(TRIM(ref_lagerbew_beleg_id)) = 10
;

INSERT INTO DBP_ETL.rel_dat_buch_abschr_tmp_1
        ( dat_buch )
SELECT	dat_buch
FROM 	DBP_ETL.rel_lagerbew_abschr_tmp_1
GROUP BY 1

UNION

SELECT	dat
FROM 	DBP_ETL.mseg_abschriften_gen_1
GROUP BY 1
;

INSERT INTO DBP_ETL.abschriftart_char_tmp_1
(
         mandant_id
        ,abschriftart_id
)
SELECT
         mandant_id
        ,TRIM(CAST(abschriftart_id AS CHAR(3)))
FROM DBP_DATA.l_abschriftart_1

WHERE mandant_id > 1
AND abschriftart_id < 1000
;

INSERT INTO DBP_ETL.mseg_abschriften_gen_1
(
         mandant_id
        ,wup_id
        ,nb_id
        ,art_id
        ,wup_abschrift_id
        ,positionsnummer_id
        ,abschriftart_id
        ,dat
        ,lastupd_dat
        ,woche_id
        ,menge_abschrift
        ,abschriftbetrag_netto
        ,abschriftbetrag_brutto
        ,wrg_id
        ,ref_lagerbew_beleg_id
        ,kj
)
SELECT 
         mandant_id
        ,wup_id
        ,nb_id
        ,art_id
        ,wup_abschrift_id
        ,positionsnummer_id
        ,abschriftart_id
        ,dat
        ,lastupd_dat
        ,woche_id
       ,CASE    WHEN menge_abschrift_ >  999999999 THEN  CAST(  999999999 AS INTEGER)
                WHEN menge_abschrift_ < -999999999 THEN CAST ( -999999999 AS INTEGER)
                ELSE CAST(menge_abschrift_ AS INTEGER)
                END AS menge_abschrift
        ,abschriftbetrag_netto
        ,abschriftbetrag_brutto
        ,wrg_id
        ,ref_lagerbew_beleg_id_
        ,kj
        FROM
        (
        
SELECT
         d.mandant_id
        ,d.wup_id
        ,d.nb_id
        ,d.art_id
        ,d.lagerbew_beleg_id  AS wup_abschrift_id
        ,d.lagerbew_beleg_pos_id AS positionsnummer_id
        ,d.lager_bewart_id AS abschriftart_id
        ,d.dat_buch AS dat
        ,CURRENT_DATE AS lastupd_dat
        ,g.kjwo AS woche_id
        ,CASE   WHEN gewart_id = 'KG' THEN ABS(menge_lagerbew_bme) * (CASE WHEN d.soll_haben_kz = 'S' THEN (-1) ELSE 1 END) * 1000
                WHEN (ABS(menge_lagerbew_bme) * (CASE WHEN d.soll_haben_kz = 'S' THEN (-1) ELSE 1 END)) BETWEEN 0.001 AND 1   THEN  1
		WHEN (ABS(menge_lagerbew_bme) * (CASE WHEN d.soll_haben_kz = 'S' THEN (-1) ELSE 1 END)) BETWEEN -1 AND -0.001 THEN -1
		ELSE (ABS(menge_lagerbew_bme) * (CASE WHEN d.soll_haben_kz = 'S' THEN (-1) ELSE 1 END))
		END AS menge_abschrift_

        ,ABS(betrag_vk_netto)  * (CASE WHEN d.soll_haben_kz = 'S' THEN (-1) ELSE 1 END) AS abschriftbetrag_netto
        ,ABS(betrag_verkauf) * (CASE WHEN d.soll_haben_kz = 'S' THEN (-1) ELSE 1 END) AS abschriftbetrag_brutto
        ,d.wrg_id
        ,CASE   WHEN LENGTH(TRIM(k.ref_lagerbew_beleg_id)) = 10
                THEN CAST(d.wup_id AS CHAR(4)) || TRIM(k.ref_lagerbew_beleg_id)
                ELSE k.ref_lagerbew_beleg_id
                END AS ref_lagerbew_beleg_id_
        ,k.kj
FROM DBP_DATA.lagerbew_det_1 d

INNER JOIN DBP_ETL.rel_dat_buch_abschr_tmp_1 t
        ON d.dat_buch = t.dat_buch

INNER  JOIN DBP_ETL.rel_lagerbew_abschr_tmp_1 k
         ON d.mandant_id = k.mandant_id
        AND d.lagerbew_beleg_id = k.lagerbew_beleg_id
        AND d.kj = k.kj
        AND d.dat_buch = k.dat_buch

INNER  JOIN DBP_ETL.abschriftart_char_tmp_1 a
         ON d.mandant_id = a.mandant_id
        AND d.lager_bewart_id = a.abschriftart_id

INNER JOIN DBP_DATA.tag_1 g
        ON d.dat_buch = g.dat

INNER  JOIN DBP_DATA.art_1 r
         ON d.mandant_id = r.mandant_id
        AND d.art_id = r.art_id

WHERE   d.mandant_id > 1
  AND   d.dat_buch BETWEEN CURRENT_DATE - 365 AND CURRENT_DATE 
  AND  ( d.mandant_id
        ,d.kj
        ,CASE   WHEN LENGTH(TRIM(k.ref_lagerbew_beleg_id)) = 10
                THEN CAST(d.wup_id AS CHAR(4)) || TRIM(k.ref_lagerbew_beleg_id)
                ELSE k.ref_lagerbew_beleg_id
                END
        ) IN
        (SELECT
                 mandant_id
                ,kj
                ,ref_lagerbew_beleg_id
         FROM DBP_ETL.mseg_abschriften_gen_1
        )
)x
;

create or replace volatile table _zwischen as (
select *
from dbp_data.marktabschriften_1
where (mandant_id,wup_id,art_id,dat,wup_abschrift_id,positionsnummer_id) in (select mandant_id,wup_id,art_id,dat,wup_abschrift_id,positionsnummer_id from dbp_etl.mseg_abschriften_gen_1)
);

DELETE FROM DBP_DATA.marktabschriften_1
WHERE   (
         mandant_id
        ,wup_id
        ,art_id
        ,dat
        ,wup_abschrift_id
        ,positionsnummer_id
        )
IN
        (SELECT
                 mandant_id
                ,wup_id
                ,art_id
                ,dat
                ,wup_abschrift_id
                ,positionsnummer_id
         FROM DBP_ETL.mseg_abschriften_gen_1
         );


INSERT INTO DBP_DATA.marktabschriften_1
(
         mandant_id
        ,wup_id
        ,nb_id
        ,wup_abschrift_id
        ,positionsnummer_id
        ,art_id
        ,dat
        ,lastupd_dat
        ,woche_id
        ,menge_abschrift
        ,abschriftart_id
        ,abschriftbetrag_netto
        ,abschriftbetrag_brutto
        ,wrg_id
        ,td_insert
        ,td_update
)
SELECT
         mandant_id
        ,wup_id
        ,nb_id
        ,wup_abschrift_id
        ,positionsnummer_id
        ,art_id
        ,dat
        ,lastupd_dat
        ,woche_id
        ,menge_abschrift
        ,abschriftart_id
        ,abschriftbetrag_netto
        ,abschriftbetrag_brutto
        ,wrg_id
        ,current_timestamp as td_insert
        ,current_timestamp as td_update
FROM DBP_ETL.mseg_abschriften_gen_1
WHERE ref_lagerbew_beleg_id = '' or ref_lagerbew_beleg_id IS NULL
;

INSERT INTO DBP_DATA.marktabschriften_1
(
         mandant_id
        ,wup_id
        ,nb_id
        ,wup_abschrift_id
        ,positionsnummer_id
        ,art_id
        ,dat
        ,lastupd_dat
        ,woche_id
        ,menge_abschrift
        ,abschriftart_id
        ,abschriftbetrag_netto
        ,abschriftbetrag_brutto
        ,wrg_id
        ,td_insert
        ,td_update
)
SELECT
         mandant_id
        ,wup_id
        ,nb_id
        ,wup_abschrift_id
        ,positionsnummer_id
        ,art_id
        ,dat
        ,lastupd_dat
        ,woche_id
        ,menge_abschrift_
        ,abschriftart_id
        ,abschriftbetrag_netto_
        ,abschriftbetrag_brutto_
        ,wrg_id
        ,current_timestamp as td_insert
        ,current_timestamp as td_update
FROM
(       SELECT  
         mandant_id
        ,wup_id
        ,nb_id
        ,wup_abschrift_id
        ,positionsnummer_id
        ,art_id
        ,dat
        ,lastupd_dat
        ,woche_id
        ,EXTRACT(YEAR FROM dat) AS kj
        ,abschriftart_id
        ,CASE   WHEN MOD(abschriftart_id,2) = 0
                THEN abschriftart_id - 1
                ELSE abschriftart_id
                END AS abschriftartgruppe_id
        ,SUM(menge_abschrift) OVER (PARTITION BY mandant_id, art_id, kj, abschriftartgruppe_id, dat, ref_lagerbew_beleg_id ORDER BY 1) AS menge_abschrift_
        ,SUM(abschriftbetrag_netto) OVER (PARTITION BY mandant_id, art_id, kj, abschriftartgruppe_id, dat, ref_lagerbew_beleg_id ORDER BY 1) AS abschriftbetrag_netto_
        ,SUM(abschriftbetrag_brutto) OVER (PARTITION BY mandant_id, art_id, kj, abschriftartgruppe_id, dat, ref_lagerbew_beleg_id ORDER BY 1) AS abschriftbetrag_brutto_
        ,wrg_id
        ,ref_lagerbew_beleg_id
        FROM DBP_ETL.mseg_abschriften_gen_1
        WHERE ref_lagerbew_beleg_id <> ''
) a

WHERE COALESCE(menge_abschrift_, 0) <> 0
   OR COALESCE(abschriftbetrag_netto_, 0) <> 0
   OR COALESCE(abschriftbetrag_brutto_, 0) <> 0

QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id,art_id,dat,abschriftartgruppe_id,kj,ref_lagerbew_beleg_id ORDER BY wup_abschrift_id ASC, positionsnummer_id ASC) = 1
;

CREATE OR REPLACE VOLATILE TABLE _marktabs_ro_md AS
SELECT   d.mandant_id
        ,d.wup_id
        ,d.nb_id
        ,d.art_id
        ,d.lagerbew_beleg_id  AS wup_abschrift_id
        ,d.lagerbew_beleg_pos_id AS positionsnummer_id
        ,d.lager_bewart_id AS abschriftart_id
        ,d.dat_buch AS dat
        ,CURRENT_DATE AS lastupd_dat
        ,g.kjwo AS woche_id
        ,ABS(d.menge_lagerbew_bme) * (CASE WHEN d.soll_haben_kz = 'S' THEN (-1) ELSE 1 END) AS menge_abschrift
        ,ABS(d.betrag_vk_netto)  * (CASE WHEN d.soll_haben_kz = 'S' THEN (-1) ELSE 1 END) AS abschriftbetrag_netto
        ,ABS(d.betrag_verkauf) * (CASE WHEN d.soll_haben_kz = 'S' THEN (-1) ELSE 1 END) AS abschriftbetrag_brutto
        ,d.wrg_id
        ,r.gewart_id
        ,a.ref_lagerbew_beleg_id
        ,d.kj
FROM    DBP_DATA.lagerbew_1 a

JOIN    DBP_DATA.lagerbew_det_1 d
  ON    a.mandant_id = d.mandant_id AND
        a.lagerbew_beleg_id = d.lagerbew_beleg_id AND
        a.dat_buch = d.dat_buch

JOIN    DBP_DATA.tag_1 g
  ON    d.dat_buch = g.dat

JOIN    DBP_DATA.art_1 r
  ON    d.mandant_id = r.mandant_id AND
        d.art_id = r.art_id
WHERE   d.mandant_id IN (4,7) AND
        d.auto_fg <> '' AND
        d.dat_buch BETWEEN (SELECT MIN(dat) AS dat_buch
	                    FROM DBP_DATA.marktabschriften_1
	  		    WHERE mandant_id IN (4,7)) AND CURRENT_DATE AND
        a.ref_lagerbew_beleg_id = 'SC' AND
        d.lager_bewart_id IN ('343','344')
;

UPDATE _marktabs_ro_md 

SET menge_abschrift = menge_abschrift_

FROM 
        (SELECT  mandant_id
                ,wup_id
                ,art_id
                ,dat
                ,wup_abschrift_id
                ,positionsnummer_id
                ,CASE   WHEN gewart_id = 'KG'
                        THEN menge_abschrift * 1000
                        ELSE menge_abschrift
                        END AS menge_abschrift_g
                ,CASE   WHEN menge_abschrift_g BETWEEN 0.001 AND 1 THEN 1
                        WHEN menge_abschrift_g BETWEEN -1 AND -0.001 THEN -1
                        ELSE menge_abschrift_g
                        END AS menge_abschrift_
        FROM _marktabs_ro_md
        ) u
 WHERE _marktabs_ro_md.mandant_id         = u.mandant_id         
  AND _marktabs_ro_md.wup_id             = u.wup_id             
  AND _marktabs_ro_md.art_id             = u.art_id             
  AND _marktabs_ro_md.dat                = u.dat                
  AND _marktabs_ro_md.wup_abschrift_id   = u.wup_abschrift_id   
  AND _marktabs_ro_md.positionsnummer_id = u.positionsnummer_id
;

UPDATE  _marktabs_ro_md 
SET     menge_abschrift = CASE  WHEN menge_abschrift >  999999999
                                THEN CAST( 999999999 AS INTEGER)
                                WHEN menge_abschrift < -999999999
                                THEN CAST ( -999999999 AS INTEGER)
                                ELSE CAST(menge_abschrift AS INTEGER)
                                END
;

insert into _zwischen
select *
from dbp_data.marktabschriften_1
where dat in (select dat from _marktabs_ro_md) and 
      mandant_id in (4,7) and 
      abschriftart_id IN (343,344)
;

DELETE  FROM DBP_DATA.marktabschriften_1
WHERE   dat IN (SELECT dat FROM _marktabs_ro_md)
  AND   mandant_id IN (4,7) 
  AND   abschriftart_id IN (343,344)
;

INSERT INTO DBP_DATA.marktabschriften_1 
        (mandant_id
        ,wup_id
        ,nb_id
        ,wup_abschrift_id
        ,positionsnummer_id
        ,art_id
        ,dat
        ,lastupd_dat
        ,woche_id
        ,menge_abschrift
        ,abschriftart_id
        ,abschriftbetrag_netto
        ,abschriftbetrag_brutto
        ,wrg_id
        ,td_insert
        ,td_update
)
SELECT   mandant_id
        ,wup_id
        ,nb_id
        ,wup_abschrift_id
        ,positionsnummer_id
        ,art_id
        ,dat
        ,lastupd_dat
        ,woche_id
        ,menge_abschrift_
        ,abschriftart_id
        ,abschriftbetrag_netto_
        ,abschriftbetrag_brutto_
        ,wrg_id
        ,current_timestamp as td_insert
        ,current_timestamp as td_update
FROM (
        SELECT   mandant_id
                ,wup_id
                ,nb_id
                ,wup_abschrift_id
                ,positionsnummer_id
                ,art_id
                ,dat
                ,lastupd_dat
                ,woche_id
                ,EXTRACT(YEAR FROM dat) AS kj
                ,abschriftart_id
                ,CASE WHEN MOD(abschriftart_id,2) = 0 THEN abschriftart_id - 1 ELSE abschriftart_id END AS abschriftartgruppe_id
                ,SUM(menge_abschrift) OVER (PARTITION BY mandant_id,art_id,dat,abschriftart_id ORDER BY 1) AS menge_abschrift_
                ,SUM(abschriftbetrag_netto) OVER (PARTITION BY mandant_id,art_id,dat,abschriftart_id ORDER BY 1) abschriftbetrag_netto_
                ,SUM(abschriftbetrag_brutto) OVER (PARTITION BY mandant_id,art_id,dat,abschriftart_id ORDER BY 1) AS abschriftbetrag_brutto_
                ,wrg_id
                ,ref_lagerbew_beleg_id
        FROM _marktabs_ro_md
     ) a

WHERE   COALESCE(menge_abschrift_, 0) <> 0 
   OR   COALESCE(abschriftbetrag_netto_, 0) <> 0 
   OR   COALESCE(abschriftbetrag_brutto_, 0) <> 0
;

insert into dbp_etl_process.uapc_marktabschriften_deletion_1 (mandant_id
                                                           ,wup_id
                                                           ,art_id
                                                           ,dat
                                                           ,wup_abschrift_id
                                                           ,positionsnummer_id
                                                           ,row_id
                                                           ,td_insert
                                                           ,td_update)
select mandant_id,
       wup_id,
       art_id,
       dat,
       wup_abschrift_id,
       positionsnummer_id,
      (row_number() over (order by mandant_id,wup_id,art_id,dat,wup_abschrift_id,positionsnummer_id) + coalesce((select max(row_id) from dbp_etl_process.uapc_marktabschriften_deletion_1),0)) as row_id,
       current_timestamp as td_insert,
       current_timestamp as td_update
from _zwischen
where (mandant_id,wup_id,art_id,dat,wup_abschrift_id,positionsnummer_id) not in (select mandant_id,wup_id,art_id,dat,wup_abschrift_id,positionsnummer_id from dbp_data.marktabschriften_1)
group by 1,2,3,4,5,6
;

INSERT INTO DBP_ETL.marktabschriften_mseg_agg_dat_1
(        wup_id
        ,nb_id
        ,dat
        ,mandant_id
)
SELECT
         wup_id
        ,nb_id
        ,dat
        ,mandant_id
FROM    DBP_ETL.mseg_abschriften_gen_1
GROUP BY 1,2,3,4
;

DELETE FROM DBP_DATA.marktabschriften_wg_sum_1
WHERE
(        wup_id
        ,nb_id
        ,dat
        ,mandant_id
)
IN
(SELECT  wup_id
        ,nb_id
        ,dat
        ,mandant_id
 FROM DBP_ETL.marktabschriften_mseg_agg_dat_1
)
AND (mandant_id,abschriftart_id) NOT IN
        (SELECT
                 mandant_id
                ,abschriftart_id
        FROM DBP_DATA.abschriftart_abschriftgrp_zu_1
        WHERE abschriftgruppe_id = 400
        )
;

INSERT INTO DBP_DATA.marktabschriften_wg_sum_1
(        wup_id
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
SELECT   t1.wup_id
        ,t1.nb_id
        ,t1.dat
        ,t1.mandant_id
        ,t2.wg_id
        ,t1.abschriftart_ID
        ,t1.wrg_id
        ,t2.arthiertyp_id
        ,SUM(t1.abschriftbetrag_netto)
        ,SUM(t1.abschriftbetrag_brutto)
FROM DBP_DATA.marktabschriften_1 t1_1

INNER  JOIN DBP_ETL.marktabschriften_mseg_agg_dat_1 d
         ON t1.wup_id = d.wup_id
        AND t1.nb_id = d.nb_id
        AND t1.dat = d.dat
        AND t1.mandant_id = d.mandant_id

INNER  JOIN DBP_DATA.art_wg_zu_per_1 t2
         ON t1.mandant_id=t2.mandant_id
        AND t1.art_id=t2.art_id
        AND t1.dat BETWEEN t2.dat_von AND t2.dat_bis
        AND t2.arthiertyp_id = 2

GROUP BY 1,2,3,4,5,6,7,8
;

DROP TABLE IF EXISTS DBP_ETL.rel_lagerbew_abschr_tmp_1;
DROP TABLE IF EXISTS DBP_ETL.rel_dat_buch_abschr_tmp_1;
DROP TABLE IF EXISTS DBP_ETL.abschriftart_char_tmp_1;

