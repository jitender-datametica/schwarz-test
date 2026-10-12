--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM DBP_DATA.l_buchungskreis_1

WHERE (mandant_id,  system_id, buchungskreis_id) IN
	(
	 SELECT
	 adr.mandant_id, s2.system_id, buchungskreis_id
	 FROM ${TEMP_TABLE} /*DBP_ETL.l_buchungskreis_temp*/ adr
			
	 INNER JOIN DBP_DATA.l_system_1 s
	 ON adr.system_id = s.system_id
			
	 INNER JOIN DBP_DATA.l_system_1 s2
	 ON s.system_gruppe = s2.system_gruppe
	 )
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.l_buchungskreis_1
	(
	mandant_id
	,buchungskreis_id
	,gj_variante_id
	,land_id
	,wrg_id
	,system_id
	,kontenplan_id
	,buchungskreis_glob_id
	)
SELECT
	 t1.mandant_id
	,t1.buchungskreis_id
	,t1.gj_variante_id
	,t1.land_id
	,t1.wrg_id
	,t1.system_id
	,t1.kontenplan_id
	,t1.buchungskreis_glob_id
FROM ${TEMP_TABLE} /*DBP_ETL.l_buchungskreis_temp*/  t1_1
;

