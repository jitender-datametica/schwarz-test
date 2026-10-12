CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_KASSENABSCHLUSS_2(
    MANDANT_ID,
	WUP_ID,
	DAT,
    WRG_ID,
    UMSATZ_BRUTTO,
    ANZ_KUNDEN,
    ANZ_KUNDEN_IMBISS,
    ANZ_SCANS,
    SUM_SCAN_SEK,
    SUM_SCAN_MIN
) AS 
/* 
   2024-10-25 muellerpatri : Initiale Erstellung der View, AP0232301
   2025-03-19 muellerpatri : Erweiterung um wrg_id
*/
SELECT 
    k.mandant_id
    , wup.aktuell_wup_id                            AS wup_id
    , k.bon_dat                                     AS dat
    , krs.nach_wrg_id                               AS wrg_id
    , SUM(k.umsatz_brutto* krs.umrechnungskurs)     AS umsatz_brutto
    , SUM(k.anz_kunden)                             AS anz_kunden
    , SUM(k.anz_kunden_imbiss)                      AS anz_kunden_imbiss
    , SUM(k.anz_scans)                              AS anz_scans
    , SUM(k.sum_scan_sek)                           AS sum_scan_sek                       
    , SUM(k.sum_scan_sek / 60)                      AS sum_scan_min
FROM 
DBP_V_ODS.V_ODS_BON_KASSENABSCHLUSS_2 k

INNER JOIN dbp_view.V_MANDANT_WRG_ZU_PER_2 wrg_2
ON k.mandant_id = wrg.mandant_id AND k.bon_dat BETWEEN wrg.DAT_VON AND wrg.DAT_BIS

INNER JOIN (
		SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs
		FROM dbp_data.kurs_2 krs1
		WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31'
		AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
		UNION ALL
		SELECT krs2.von_wrg_id, krs2.von_wrg_id AS nach_wrg_id, 1.00000 AS umrechnungskurs
		FROM dbp_data.kurs_2 krs2
		WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31' 
		AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')
	) krs
ON krs.von_wrg_id = wrg.wrg_id 
    
INNER JOIN dbp_view.v_wup_2 wup_2
ON k.mandant_id = wup.mandant_id AND k.wup_id = wup.wup_id

GROUP BY ALL;