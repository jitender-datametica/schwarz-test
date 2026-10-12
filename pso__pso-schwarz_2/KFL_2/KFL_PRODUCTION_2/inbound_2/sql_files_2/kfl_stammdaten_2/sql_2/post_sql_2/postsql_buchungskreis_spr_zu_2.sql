--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
DELETE FROM DBP_DATA.buchungskreis_spr_zu_2

WHERE (mandant_id, system_id, buchungskreis_id) IN
	(
	SELECT
	adr.mandant_id, s2.system_id, buchungskreis_id
	FROM ${TEMP_TABLE} /*DBP_ETL.buchungskreis_spr_zu_temp*/ adr

	INNER JOIN DBP_DATA.l_system_2 s
	ON adr.system_id = s.system_id

	INNER JOIN DBP_DATA.l_system_2 s2
	ON s.system_gruppe = s2.system_gruppe
	)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.buchungskreis_spr_zu_2
	(
	 mandant_id
	,buchungskreis_id
	,spr_id
	,system_id
	,buchungskreis_bez
	,strasse
	,plz
	,ort
	)
SELECT
	 mandant_id
	,buchungskreis_id
	,spr_id
	,system_id
	,buchungskreis_bez
	,strasse
	,plz
	,ort
FROM ${TEMP_TABLE} /*DBP_ETL.buchungskreis_spr_zu_temp*/
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.buchungskreis_spr_zu_2
	(
	 mandant_id
	,buchungskreis_id
	,spr_id
	,system_id
	,buchungskreis_bez
	,strasse
	,plz
	,ort
	)
SELECT
	 mandant_id
	,buchungskreis_id
	,22
	,system_id
	,buchungskreis_bez
	,strasse
	,plz
	,ort
FROM ${TEMP_TABLE} /*DBP_ETL.buchungskreis_spr_zu_temp*/
WHERE (mandant_id,buchungskreis_id,22,system_id) NOT IN
	(SELECT mandant_id,buchungskreis_id,spr_id,system_id
	 FROM DBP_DATA.buchungskreis_spr_zu_2)
;

