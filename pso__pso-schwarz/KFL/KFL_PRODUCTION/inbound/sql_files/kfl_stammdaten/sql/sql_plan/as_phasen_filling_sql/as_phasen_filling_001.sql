DELETE FROM DBP_DATA.as_phasen;

INSERT INTO DBP_DATA.as_phasen
SELECT a.mandant_id
	,a.wg_id
	,a.posten_kz_sap
	,COALESCE(a.wtag_phasenbeginn, b.wtag_phasenbeginn) as wtag_phasenbeginn
        ,current_timestamp
        ,current_timestamp
FROM (
	SELECT wg.mandant_id
		,wg.wg_id
		,apt.posten_kz_sap
		,ap.wtag_phasenbeginn
	--get the wg from DWH
	FROM (
		SELECT DISTINCT mandant_id,wg_id
		FROM DBP_DATA.wg_per
		WHERE arthiertyp_id = 2
			AND current_date BETWEEN dat_von
				AND dat_bis
                UNION
		SELECT DISTINCT mandant_id,wg_id
		FROM DBP_ETL.as_phasen_tmp
		WHERE wg_id <> 0
		) wg
	--multiply with all available posten_kz
	CROSS JOIN (
		SELECT DISTINCT posten_kz_sap
		FROM DBP_ETL.as_phasen_tmp
		) apt
	--take weekday value for all wgs that exist in dbe_etl_bed.as_phasen_tmp, but keep wg entries with no weekday
	LEFT JOIN DBP_ETL.as_phasen_tmp ap 
	ON ap.mandant_id = wg.mandant_id
		AND ap.wg_id = wg.wg_id
		AND ap.posten_kz_sap = apt.posten_kz_sap
	) a
--add column with default weekday value
LEFT JOIN (SELECT DISTINCT mandant_id
		,posten_kz_sap
		,wtag_phasenbeginn
	FROM DBP_ETL.as_phasen_tmp
	--WHERE wg_id = 0
	) b 
ON b.mandant_id = a.mandant_id
AND b.posten_kz_sap = a.posten_kz_sap
WHERE COALESCE(a.wtag_phasenbeginn, b.wtag_phasenbeginn) IS NOT NULL;

COMMIT;
