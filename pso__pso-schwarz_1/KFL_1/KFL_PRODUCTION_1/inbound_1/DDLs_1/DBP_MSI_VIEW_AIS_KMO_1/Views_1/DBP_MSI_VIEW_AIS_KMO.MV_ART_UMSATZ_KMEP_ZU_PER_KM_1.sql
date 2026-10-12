create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_KMO.MV_ART_UMSATZ_KMEP_ZU_PER_KM_1(
	MANDANT_ID,
	ART_ID,
	DAT,
	WA_BONUS_KM
) as
SELECT 
    v01.mandant_id,
    v01.art_id,
    v01.dat,
    -- Wir rechnen nun mit der bereits vor-aggregierten Menge (sum_menge)
    SUM(v01.sum_menge * CAST(CASE 
        WHEN v200.wrg_typ_id = 0 THEN v02.betrag_kmep_einh_o_fwu * v300.umrechnungskurs 
        ELSE v02.betrag_kmep_einh_o_fwu 
    END AS DECIMAL(12,5))) AS wa_bonus_km
FROM (
    -- UNTERABFRAGE: Zusammenfassung Märkte pro Mandant_1, Artikel_1 und Tag_1, da sonst Vervielfältigungen
    SELECT 
        mandant_id, 
        art_id, 
        dat, 
        SUM(menge) AS sum_menge
    FROM dbp_data.artbew_1
    WHERE mandant_id > 1
    --  AND dat BETWEEN CURRENT_DATE() - 14 AND CURRENT_DATE() - 1
    GROUP BY mandant_id, art_id, dat
) v01
LEFT JOIN dbp_data.art_umsatz_kmep_zu_per_1 v02
    ON (v01.mandant_id = v02.mandant_id 
        AND v01.dat BETWEEN v02.dat_von AND v02.dat_bis
        AND v02.zeitraum_kz = 'KM' 
        AND v01.art_id = v02.art_id)

-- Berichtskursermittlung
JOIN DBP_DATA.MANDANT_1 v100
    ON v01.mandant_id = v100.mandant_id

CROSS JOIN DBP_MSI.AKT_MSI_USER_WRG_TYP_ZU_1 v200
    
-- aktueller Berichtskurs
JOIN DBP_DATA.KURS_1 v300
    ON  v300.dat_bis = '9999-12-31'
    AND v100.default_wrg = v300.von_wrg_id
    AND v300.kurstyp_id = 3
    AND v300.nach_wrg_id ='EUR'

WHERE 
    -- Filter E-Loading Artikel_1 (jetzt auf die aggregierten v01-Daten angewendet)
    NOT (v01.mandant_id = 5 AND v01.art_id = 206731500)
    AND NOT (v01.mandant_id = 2 AND v01.art_id = 208124500)
    AND NOT (v01.mandant_id = 3 AND v01.art_id = 208113690)
    AND NOT (v01.mandant_id = 6 AND v01.art_id = 208131570)
    AND NOT (v01.mandant_id IN (4,7) AND v01.art_id = 208114740)
    AND NOT (v01.mandant_id = 8 AND v01.art_id = 208131640)
GROUP BY 
    v01.mandant_id,
    v01.art_id,
    v01.dat;
