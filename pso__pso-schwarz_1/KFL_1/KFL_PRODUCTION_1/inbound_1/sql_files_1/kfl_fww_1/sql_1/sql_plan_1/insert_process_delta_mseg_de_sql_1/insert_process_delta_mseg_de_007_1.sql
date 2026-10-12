--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.DE_MSEG_DELTA_1' does not exist or not authorized.
INSERT INTO DBP_ETL.kmo_mseg_dat_1
(
	 dat_buch
	,mandant_id
)
SELECT
	dat_buch,
	mandant_id
FROM  DBP_ETL.de_mseg_delta_1

WHERE mandant_id = 1 AND (dat_buch, mandant_id)
NOT IN
	(SELECT dat_buch, mandant_id
	 FROM  DBP_ETL.kmo_mseg_dat_1
	)
GROUP BY 1,2
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.DE_MSEG_DELTA_1' does not exist or not authorized.
INSERT INTO DBP_ETL.mseg_reichweite_1
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

FROM  DBP_ETL.de_mseg_delta_1

WHERE mandant_id = 1 
  AND (mandant_id, wup_id, nb_id,dat_buch) NOT IN
	(SELECT mandant_id, wup_id, nb_id,dat_buch
	 FROM  DBP_ETL.mseg_reichweite_1
        )
GROUP BY 1,2,3,4
;

