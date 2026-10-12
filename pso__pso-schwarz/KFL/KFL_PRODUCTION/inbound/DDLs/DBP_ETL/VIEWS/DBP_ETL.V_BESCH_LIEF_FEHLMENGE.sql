create or replace view DBP_ETL.V_BESCH_LIEF_FEHLMENGE(
	STARTDATUM,
	ENDEDATUM
) as
SELECT (CURRENT_DATE - 182) AS startdatum,
       CURRENT_DATE AS endedatum;