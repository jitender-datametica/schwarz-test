CREATE TABLE IF NOT EXISTS DBP_ETL.kmo_mseg_dat_2  (
dat_buch DATE NOT NULL,
mandant_id BYTEINT NOT NULL
);

CREATE TABLE IF NOT EXISTS DBP_ETL.mseg_reichweite_2  (
mandant_id BYTEINT NOT NULL,
wup_id INTEGER NOT NULL,
nb_id SMALLINT NOT NULL,
dat_buch DATE NOT NULL)
;

INSERT INTO DBP_ETL.kmo_mseg_dat_2
(
	 dat_buch
	,mandant_id
)
SELECT
	dat_buch,
	mandant_id
FROM  DBP_ETL.de_mseg_delta_2

WHERE mandant_id = 1 AND (dat_buch, mandant_id)
NOT IN
	(SELECT dat_buch, mandant_id
	 FROM  DBP_ETL.kmo_mseg_dat_2
	)
GROUP BY 1,2
;

INSERT INTO DBP_ETL.mseg_reichweite_2
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

FROM  DBP_ETL.de_mseg_delta_2

WHERE mandant_id = 1 
  AND (mandant_id, wup_id, nb_id,dat_buch) NOT IN
	(SELECT mandant_id, wup_id, nb_id,dat_buch
	 FROM  DBP_ETL.mseg_reichweite_2
        )
GROUP BY 1,2,3,4
;
