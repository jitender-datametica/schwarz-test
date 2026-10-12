--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_DATA_CLOUD_SYNC' does not exist or not authorized.
INSERT INTO DBP_DATA_CLOUD_SYNC.t_cdc_lagerbew_det
(mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id,dat_buch, log_operation,log_ts )

SELECT  mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id,dat_buch, 'X' as log_operation, CURRENT_TIMESTAMP as log_ts
FROM
(
SELECT
	d.mandant_id as mandant_id,
	d.lagerbew_beleg_id as lagerbew_beleg_id,
	d.lagerbew_beleg_pos_id as lagerbew_beleg_pos_id,
	l.dat_buch as dat_buch
	FROM DBP_DATA.lagerbew_det_delta_2 d

	INNER JOIN DBP_DATA.lagerbew_2 l
	ON 	d.mandant_id        = l.mandant_id
	AND 	d.lagerbew_beleg_id = l.lagerbew_beleg_id
	AND 	d.kj                = l.kj

	WHERE 	d.mandant_id = 1
MINUS

SELECT  mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id,dat_buch
FROM DBP_DATA.lagerbew_det_delta_2
WHERE mandant_id = 1

) q
GROUP BY 1,2,3,4,5,6;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.lagerbew_det_2
WHERE
(
	 mandant_id
	,lagerbew_beleg_id
	,lagerbew_beleg_pos_id
	,dat_buch
)
IN
(	SELECT
	d.mandant_id,
	d.lagerbew_beleg_id,
	d.lagerbew_beleg_pos_id,
	l.dat_buch
	FROM DBP_DATA.lagerbew_det_delta_2 d

	INNER JOIN DBP_DATA.lagerbew_2 l
	ON 	d.mandant_id        = l.mandant_id
	AND 	d.lagerbew_beleg_id = l.lagerbew_beleg_id
	AND 	d.kj                = l.kj

	WHERE 	d.mandant_id = 1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.lagerbew_det_wwc_2
WHERE
(
	 mandant_id
	,lagerbew_beleg_id
	,lagerbew_beleg_pos_id
	,dat_buch
)
IN
(	SELECT
	d.mandant_id,
	d.lagerbew_beleg_id,
	d.lagerbew_beleg_pos_id,
	l.dat_buch
	FROM DBP_DATA.lagerbew_det_delta_2 d

	INNER JOIN DBP_DATA.lagerbew_2 l
	ON 	d.mandant_id        = l.mandant_id
	AND 	d.lagerbew_beleg_id = l.lagerbew_beleg_id
	AND 	d.kj                = l.kj

	WHERE 	d.mandant_id = 1
);

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.lagerbew_2
WHERE
(
  mandant_id
, lagerbew_beleg_id
, dat_buch
)
IN
( 	SELECT
	d.mandant_id,
	d.lagerbew_beleg_id,
	l.dat_buch
	FROM DBP_DATA.lagerbew_delta_2 d

	INNER JOIN DBP_DATA.lagerbew_2 l
	ON 	d.mandant_id        = l.mandant_id
	AND 	d.lagerbew_beleg_id = l.lagerbew_beleg_id
	AND 	d.kj                = l.kj

	WHERE 	d.mandant_id = 1
);

