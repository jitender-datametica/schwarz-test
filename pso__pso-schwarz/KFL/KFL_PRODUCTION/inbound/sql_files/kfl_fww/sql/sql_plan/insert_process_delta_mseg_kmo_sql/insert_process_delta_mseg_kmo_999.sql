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
mandant_id BYTEINT NOT NULL,
wup_id INTEGER NOT NULL,
nb_id SMALLINT NOT NULL,
dat_buch DATE NOT NULL)
;

CREATE TABLE IF NOT EXISTS DBP_ETL.gld_dat  (
dat DATE
)
;

INSERT INTO DBP_ETL.kmo_mseg_dat
(
	 dat_buch
	,mandant_id
)
SELECT
	dat_buch,
	mandant_id
FROM  DBP_ETL.kmo_mseg_delta

WHERE mandant_id > 1 AND (dat_buch, mandant_id)
NOT IN
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

WHERE mandant_id = 1 AND (dat_buch, mandant_id)
NOT IN
	(SELECT dat_buch, mandant_id
	 FROM  DBP_ETL.kmo_mseg_dat_wwc
	)
GROUP BY 1,2,3,4
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

WHERE mandant_id > 1 AND (dat_buch, mandant_id)
NOT IN
	(SELECT dat_buch, mandant_id
	 FROM  DBP_ETL.kmo_mseg_dat_wwc
	)
GROUP BY 1,2,3,4
;

INSERT INTO DBP_ETL.kmo_mseg_reichweite
(
	 mandant_id
	,wup_id
	,nb_id
	,dat_buch
)
	SELECT
	 mandant_id
	,wup_id
	,nb_id
	,dat_buch

FROM  DBP_ETL.kmo_mseg_delta

WHERE ( mandant_id, wup_id, nb_id,dat_buch) NOT IN
	(SELECT mandant_id, wup_id, nb_id,dat_buch
	 FROM  DBP_ETL.kmo_mseg_reichweite
        )
GROUP BY 1,2,3,4
;

INSERT INTO DBP_ETL.gld_dat
(
dat
)
SELECT
	dat_buch
FROM 	DBP_ETL.kmo_mseg_delta

WHERE 	lager_bewart_id IN ('251', '252')
AND 	dat_buch >= CURRENT_DATE - 60
AND 	dat_buch NOT IN (SELECT dat FROM  DBP_ETL.gld_dat)

GROUP BY 1
;
