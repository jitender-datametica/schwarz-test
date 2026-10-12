CREATE  OR REPLACE volatile table _vkset_potentials_kopf as (
SELECT  mandant_id,
        lagerbew_beleg_id,
        dat_buch,
        lagerbew_beleg_parent_pos_sort_id
  FROM  dbp_etl.kmo_mseg_delta
 WHERE  lagerbew_beleg_parent_pos_sort_id <> 0 and
        lager_bewart_id in ('317','319')
 GROUP  BY 1,2,3,4
);

CREATE  OR REPLACE volatile table _vkset_potentials as (
SELECT  mandant_id,
        lagerbew_beleg_id,
        dat_buch,
        lagerbew_beleg_pos_sort_id
  FROM  dbp_etl.kmo_mseg_delta
 WHERE  (mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_pos_sort_id) in 
        (SELECT mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_parent_pos_sort_id 
        FROM _vkset_potentials_kopf
        )
 GROUP BY 1,2,3,4
);

CREATE  OR REPLACE volatile table _vkset_updates as (
SELECT  mandant_id,
        lagerbew_beleg_id,
        dat_buch,
        lagerbew_beleg_pos_sort_id,
        art_id
  FROM  dbp_etl.kmo_mseg_delta
 WHERE  (mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_pos_sort_id) in 
        (SELECT mandant_id,lagerbew_beleg_id,dat_buch,lagerbew_beleg_pos_sort_id 
        FROM _vkset_potentials
        )
 GROUP BY 1,2,3,4,5
);


UPDATE dbp_etl.kmo_mseg_delta SET display_art_id = -1
;

UPDATE  dbp_etl.kmo_mseg_delta 
  FROM  (SELECT * FROM _vkset_updates) b                                     
   SET  display_art_id = b.art_id
 WHERE  dbp_etl.kmo_mseg_delta.mandant_id = b.mandant_id and
        dbp_etl.kmo_mseg_delta.lagerbew_beleg_id = b.lagerbew_beleg_id and
        dbp_etl.kmo_mseg_delta.dat_buch = b.dat_buch and
        dbp_etl.kmo_mseg_delta.lagerbew_beleg_parent_pos_sort_id = b.lagerbew_beleg_pos_sort_id
;

UPDATE  dbp_etl.kmo_mseg_delta 
  FROM  (SELECT * FROM _vkset_updates) b                                     
   SET  display_art_id = b.art_id
 WHERE  dbp_etl.kmo_mseg_delta.mandant_id = b.mandant_id and
        dbp_etl.kmo_mseg_delta.lagerbew_beleg_id = b.lagerbew_beleg_id and
        dbp_etl.kmo_mseg_delta.dat_buch = b.dat_buch and
        dbp_etl.kmo_mseg_delta.lagerbew_beleg_pos_sort_id = b.lagerbew_beleg_pos_sort_id
;

CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_dat  (
        dat_buch DATE NOT NULL,
        mandant_id BYTEINT NOT NULL
)
;

CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_dat_wwc  (
        dat_buch    DATE NOT NULL,
        mandant_id  BYTEINT NOT NULL,
        kjmo        INTEGER ,
        kjwo        INTEGER
)
;

CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_reichweite  (
        mandant_id      BYTEINT NOT NULL,
        wup_id          INTEGER NOT NULL,
        nb_id           SMALLINT NOT NULL,
        dat_buch        DATE NOT NULL)
;

CREATE TABLE IF NOT EXISTS DBP_ETL.gld_dat (dat DATE)
;

INSERT INTO DBP_ETL.kmo_mseg_dat
(	 dat_buch
	,mandant_id
)
SELECT	dat_buch,
	mandant_id
FROM  DBP_ETL.kmo_mseg_delta

WHERE   mandant_id > 1 
  AND   (dat_buch, mandant_id) NOT IN
	(SELECT dat_buch, mandant_id
	 FROM  DBP_ETL.kmo_mseg_dat
	)
GROUP BY 1,2
;

INSERT INTO DBP_ETL.kmo_mseg_dat_wwc
(
	 dat_buch
	,mandant_id
	,kjmo
	,kjwo
)
SELECT
	 t1.dat_buch
	,t1.mandant_id
	,t2.kjmo
	,t2.kjwo

FROM  DBP_ETL.kmo_mseg_dat t1
INNER JOIN DBP_DATA.tag t2
	ON t1.dat_buch = t2.dat

WHERE   mandant_id = 1 
  AND   (dat_buch, mandant_id) NOT IN
	(SELECT dat_buch, mandant_id
	 FROM  DBP_ETL.kmo_mseg_dat_wwc
	)
GROUP BY 1,2,3,4
;

INSERT INTO DBP_ETL.kmo_mseg_dat_wwc
(	 dat_buch
	,mandant_id
	,kjmo
	,kjwo
)
SELECT 	 t1.dat_buch
	,t1.mandant_id
	,t2.kjmo
	,t2.kjwo
  FROM  DBP_ETL.kmo_mseg_dat t1
 INNER  JOIN DBP_DATA.tag t2
    ON  t1.dat_buch = t2.dat
 WHERE  mandant_id > 1 
   AND (dat_buch, mandant_id) NOT IN
	(SELECT dat_buch, mandant_id
	 FROM  DBP_ETL.kmo_mseg_dat_wwc
	)
GROUP BY 1,2,3,4
;

INSERT INTO DBP_ETL.kmo_mseg_reichweite
(	 mandant_id
	,wup_id
	,nb_id
	,dat_buch
)
SELECT	 mandant_id
	,wup_id
	,nb_id
	,dat_buch
  FROM  DBP_ETL.kmo_mseg_delta
 WHERE  ( mandant_id, wup_id, nb_id,dat_buch) NOT IN
	(SELECT mandant_id, wup_id, nb_id,dat_buch
	 FROM  DBP_ETL.kmo_mseg_reichweite
        )
 GROUP  BY 1,2,3,4
;

INSERT  INTO DBP_ETL.gld_dat (dat)
SELECT  dat_buch
  FROM 	DBP_ETL.kmo_mseg_delta
 WHERE 	lager_bewart_id IN ('251', '252')
   AND 	dat_buch >= CURRENT_DATE - 60
   AND 	dat_buch NOT IN (SELECT dat FROM  DBP_ETL.gld_dat)
 GROUP  BY 1
;

