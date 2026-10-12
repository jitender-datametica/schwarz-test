 --[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_ETL.nils_auflage_2
FROM DBP_DATA.vaus_wup_2 z

SET wup_id = z.wup_id

WHERE DBP_ETL.nils_auflage.mandant_id = z.mandant_id
AND SUBSTRING(markt_id, 1, 4)  = z.wup_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Date and/or time operations might need to be implemented differently. Snowflake's DATEDIFF and TIMEDIFF functions might be useful.
UPDATE DBP_DATA.vaus_wup_2

SET auflage_wup_verteilgebiet = u.anteil_anz_verteilgebiet_
	, auflage_wup_auslage       = u.anz_marktauslage_
	, nils_verteilgebiet_id     = u.verteilgebiet_id_

FROM
(
	SELECT
		mandant_id
		,wup_id
		,MAX(verteilgebiet_id) AS verteilgebiet_id_ /*falls mehrere Verteilgebiete zugeordnet waeren*/
		,SUM(anz_marktauslage) AS anz_marktauslage_ /*falls mehrere Zeitungen vorhanden waeren*/
		,SUM(anteil_anz_verteilgebiet) AS anteil_anz_verteilgebiet_
	FROM
			(
			SELECT
				n.mandant_id
				,n.wup_id
				,n.verteilgebiet_id
				,CAST(n.anz_marktauslage AS INTEGER) AS anz_marktauslage
				,SUM(ums_netto_plan) OVER (PARTITION BY n.mandant_id, n.verteilgebiet_id) AS sum_ums_netto_plan
				,CASE WHEN COALESCE(sum_ums_netto_plan, 0) <> 0
							THEN CAST(ums_netto_plan AS DECIMAL(18,4))/CAST(sum_ums_netto_plan AS DECIMAL(18,4))
							ELSE 1.0000
							END AS anteil
				,COALESCE(CAST(anteil * anz_verteilgebiet AS INTEGER), 0) AS anteil_anz_verteilgebiet
			FROM
			(
				SELECT
					 mandant_id
					,wup_id
					,CAST(verteilgebiet_id AS DECIMAL(18,0)) AS verteilgebiet_id
					,CAST(anz_marktauslage AS INTEGER) AS anz_marktauslage
					,CAST(anz_verteilgebiet AS INTEGER) AS anz_verteilgebiet
				FROM DBP_ETL.nils_auflage_2 n				
				WHERE mandant_id <> 6			
			) n
	
			LEFT OUTER JOIN
			(
				SELECT
				mandant_id
				,wup_id
				,SUM(umsatz_netto_plan) AS ums_netto_plan
				FROM DBP_DATA.wup_plan_tag_2 u
				
				-- Ermittlung Tage des aktuellen Monats
				INNER JOIN DBP_DATA.tag_2 t
				ON u.dat = t.dat
				AND (EXTRACT(YEAR FROM CURRENT_DATE) * 100) + EXTRACT(MONTH FROM CURRENT_DATE) = t.kjmo
				
				GROUP BY
				mandant_id
				,wup_id
			) v
			ON n.mandant_id = v.mandant_id
			AND n.wup_id = v.wup_id
	  ) a
	
	GROUP BY
	mandant_id
	,wup_id
) u WHERE DBP_DATA.vaus_wup.mandant_id = u.mandant_id
AND DBP_DATA.vaus_wup.wup_id     = u.wup_id
;

