DELETE  FROM DBP_ETL.zeitraum_mseg
WHERE (mandant_id,ranking)
IN (	SELECT mandant_id ,ranking
	FROM DBP_ETL.zeitraum_mseg_anr
   )
;
