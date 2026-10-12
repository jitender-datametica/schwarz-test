create or replace view DBP_ETL.VW_KRITISCHE_MHD_STEUERUNG_PRIO_2(
	FILIALE,
	MUTTER_ART_ID,
	FINAL_ART_ID,
	MANDANT_ID,
	VFDAT,
	LIEF_TYP_ID,
	KL_ART_ID,
	BASISMENGE_EINH_ID,
	ART_MHD,
	ART_LAGERPROZENT,
	MRLZ,
	WG_ID,
	WUG_ID,
	WGI_LOOKUP_KEY,
	OWG_ID,
	RLZ_IST,
	KRLZ,
	TAGE_BIS_KRITISCH,
	PRIO_STATUS
) as
WITH base_data AS (
    SELECT 
        CAST(ra.kunde_id AS NUMBER) AS filiale,
        ra.mutter_art_id,
        ra.final_art_id,
        ra.mandant_id,
        ra.dat_haltbarkeit AS vfdat,
        ra.lief_typ_id,
        t3.kl_art_id,
        t3.basismenge_einh_ID,
        t3.MHD_ZEITRAUM AS art_mhd,
        t3.LAGER_PROZENT AS art_lagerprozent,
        t3.MHD_ZEITRAUM * (t3.LAGER_PROZENT / 100.0) AS mrlz,
        t4.wg_id,
        t4.wug_id,
        LPAD(t4.wg_ID, 3, '0') || LPAD(t4.wug_id, 3, '0') AS wgi_lookup_key
    FROM dbp_etl.resolved_articles_2 AS ra_2
    JOIN dbp_data.art_2 AS t3 
        ON ra.mandant_id = t3.mandant_id 
        AND ra.final_art_id = t3.art_id
    JOIN dbp_data.art_wg_zu_per_2 AS t4 
        ON ra.mandant_id = t4.mandant_id 
        AND ra.final_art_id = t4.art_id 
        AND t4.dat_bis = '9999-12-31' 
        AND t4.arthiertyp_id = 2
    WHERE ra.dat_haltbarkeit IS NOT NULL
),
calculated_results AS (
    SELECT 
        b.*,
        t5.owg_id,
        final.rlz_ist,
        (b.vfdat - final.rlz_ist) AS KRLZ,
        DATEDIFF(day, CURRENT_DATE, (b.vfdat - final.rlz_ist)) AS tage_bis_kritisch
    FROM base_data b
    LEFT JOIN dbp_data.wg_per_2 AS t5 
        ON b.mandant_id = t5.mandant_id 
        AND b.wg_id = t5.wg_id 
        AND t5.arthiertyp_id = 2 
        AND t5.dat_bis = '9999-12-31'
    LEFT JOIN dbp_etl.RLZ_RANGE_2 AS specific 
        ON b.mandant_id = specific.mandant_id 
        AND b.wgi_lookup_key = specific.wgi
    LEFT JOIN dbp_etl.RLZ_RANGE_2 AS final 
        ON b.mandant_id = final.mandant_id 
        AND COALESCE(specific.wgi, -1) = final.wgi
    WHERE 
        (t5.owg_id <> 1047 AND t5.owg_id NOT BETWEEN 1011 AND 1014)
        AND b.mrlz BETWEEN final.rlz_ab AND final.rlz_bis
        AND (
            (b.lief_typ_id = 'NL' AND b.mandant_id IN (2, 3, 4, 5, 6, 7, 8))
            OR (b.lief_typ_id = 'ZLFI' AND b.mandant_id IN (2, 3, 5, 6, 7, 8))
            OR (b.lief_typ_id = 'ZLCC' AND b.mandant_id IN (4, 7))
        )
)
SELECT 
    *,
    CASE 
        WHEN tage_bis_kritisch <= 0 THEN '🔥 SOFORT HANDELN (KRLZ erreicht)'
        WHEN tage_bis_kritisch <= 2 THEN '⚠️ KRITISCH (Nächste 48h)'
        WHEN tage_bis_kritisch <= 5 THEN '📅 WARNUNG (Diese Woche_2)'
        ELSE '✅ OK'
    END AS prio_status
FROM calculated_results
WHERE KRLZ >= CURRENT_DATE - 1 -- Wir nehmen den gestrigen Tag_2 mit rein für späte Updates
GROUP BY ALL;