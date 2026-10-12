create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_QS.MV_CHECK_UMSATZ_KMO_2(
	MANDANT_ID,
	WUP_ID,
	DAT,
	COUNT_REFNUM,
	UMSATZ_RFI,
	UMSATZ_ARTBEW,
	""ARTBEW_2+RFI = MSEG"",
	UMSATZ_MSEG,
	TODO,
	""***UPDATE RFI <> ARTBEW_2***"",
	""***SHELL-AUFRUF***""
) as
SELECT
yy.mandant_id
, xx.wup_id
, TO_DATE(xx.dat)  AS dat
, xx.count_refnum
--, MENGE_RFI
, COALESCE(xx.UMSATZ_RFI,0) ::NUMBER(18,2) AS UMSATZ_RFI
--, MENGE_ARTBEW
, COALESCE(xx.UMSATZ_ARTBEW,0) ::NUMBER(18,2) AS UMSATZ_ARTBEW
, CASE WHEN CAST(COALESCE(xx.UMSATZ_RFI,0) AS DECIMAL(18,2)) + CAST(COALESCE(xx.UMSATZ_ARTBEW,0) AS DECIMAL(18,2)) = CAST(UMSATZ_MSEG AS DECIMAL(18,2)) THEN 'Ja' ELSE 'Nein' END AS ""artbew_2+RFI = MSEG""
--, MENGE_MSEG
, xx.UMSATZ_MSEG ::NUMBER(18,2) as UMSATZ_MSEG
--,( xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) (DECIMAL(18,2)) AS UMSATZ_DIFFERENZ
--, MENGE_ARTBEW - MENGE_RFI AS MENGE_DIFFERENZ

, CASE 
--kein artbew_2 Bestückung
WHEN (xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) IS NULL AND TRIM(xx.rfi_feld) = 'artnr' THEN 'Detailprüfung auf Artikel_2-Ebene (AlphaNumerisch oder Datentyp Integer ""gesprengt"") notwendig. Analyse-SQL (rechts) ausführen!'
WHEN (xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) IS NULL AND TRIM(xx.rfi_feld) = 'filnr' THEN 'Detailprüfung (keine Marktstamm) notwendig. Analyse-SQL (rechts) ausführen!'
WHEN xx.UMSATZ_ARTBEW IS NULL AND TRIM(xx.rfi_feld) = 'landkz, filnr, belegdatum' THEN 'Detailprüfung (Öffnungsdatum des Marktes liegt in der Zukunft) notwendig. Analyse-SQL (rechts) ausführen!'
WHEN xx.UMSATZ_ARTBEW =  xx.UMSATZ_MSEG THEN 'Umsatz ARTBEW_2 enstpricht Umsatz MSEG ==> RFI DELETE (rechts) ausführen!'
WHEN (xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) <> 0 AND (xx.UMSATZ_ARTBEW + xx.UMSATZ_RFI) <> xx.UMSATZ_MSEG AND xx.UMSATZ_RFI <= 1000 THEN 'Umsatz RFI <=1000 trotzdem additiv laden ==> RFI Update (rechts) ausführen!'
-- identische Doppellieferung: RFI-Prüfung
WHEN xx.count_refnum > 1 THEN 'Refnummer: '  || TRIM(xx.refnum) || ' * Mehrfachlieferung für Land_2, Markt, Tag_2 Kombination ==> MSEG-Wert beobachten!'
-- identische Lieferung bereits geladener Land_2, Markt, Tag_2 Kombination
WHEN (xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) = 0 THEN 'DELETE FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''');'
ELSE 'Differenz: ' || TRIM((xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) ::NUMBER(18,2)) || ' ==> manuelle Prüfung durchführen ggf. im Land_2 nachfragen. Bei Freigabe RFI UPDATE (rechts) ausführen!' 
END
AS ToDo

, CASE 
--SQL für Detailanalyse
WHEN (xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) IS NULL AND TRIM(xx.rfi_feld) = 'artnr' THEN 'SELECT * FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''') AND (dbp_process.is_integer(artnr) = 0 OR dbp_process.is_integer(filnr) = 0 OR dbp_process.is_integer(artnr) = 0 OR dbp_process.is_num(umsmenge) = 0 OR dbp_process.is_num(umswert) = 0 OR dbp_process.is_num(umspromotion) = 0 OR CAST(TRIM(artnr) AS DECIMAL(18,0)) > 2100000000);'
WHEN (xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) IS NULL AND TRIM(xx.rfi_feld) = 'filnr' THEN 'SELECT * FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''');'
WHEN xx.UMSATZ_ARTBEW IS NULL AND TRIM(xx.rfi_feld) = 'landkz, filnr, belegdatum' THEN 'SELECT mandant_id, wup_id, dat_von FROM dbp_data.wup_2 WHERE mandant_id = ' || TRIM(xx.mandant_id) || ' AND wup_id = ' || TRIM(xx.wup_id) || ';
DELETE FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''');'
WHEN xx.UMSATZ_ARTBEW =  xx.UMSATZ_MSEG THEN 'DELETE FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''');'
--Delta-Lieferung für Sonderfälle aus RO
WHEN (xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) <> 0 AND (xx.UMSATZ_ARTBEW + xx.UMSATZ_RFI) = xx.UMSATZ_MSEG THEN 'UPDATE dbp_rfi.kmo_wpuums_2 SET rfi_freigabe = ''2'' WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''');'
--Delta-Lieferung mit Umsatz <= 1000 trotzdem laden
WHEN (xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) <> 0 AND (xx.UMSATZ_ARTBEW + xx.UMSATZ_RFI) <> xx.UMSATZ_MSEG AND xx.UMSATZ_RFI <= 1000 THEN 'UPDATE dbp_rfi.kmo_wpuums_2 SET rfi_freigabe = ''2'' WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''');'

-- identische Doppellieferung: RFI-Prüfung
WHEN xx.count_refnum > 1 THEN TRIM('SELECT 
  t01.landkz
, t01.rfi_feld
, t01.filnr
, t01.belegdatum
, t01.refnum
, SUM((CAST(SUBSTRING(t01.umswert FROM 16 FOR 20) AS DECIMAL(18,4)) * (CASE WHEN t01.vorzwert = ''-'' THEN (-1) ELSE 1 END)) + (CAST(SUBSTRING(t01.umspromotion FROM 16 FOR 20) AS DECIMAL(18,4)) * (CASE WHEN t01.vorzpromotion = ''-'' THEN (-1) ELSE 1 END))) AS umsatz_brutto_rfi
FROM dbp_rfi.kmo_wpuums_2 t01
WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''')
GROUP BY 1,2,3,4,5
ERST KONTROLLIEREN ... DANN ""FEUERN"" ;-)
UPDATE dbp_rfi.kmo_wpuums_2 SET rfi_freigabe = ''2'' WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''')' || ' AND refnum = ' || TRIM(xx.max_refnum) || ';
DELETE FROM dbp_rfi.kmo_wpuums_2 WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''')' || ' AND refnum = ' || TRIM(xx.min_refnum) || ';
DELETE FROM dbp_data.artbew_wg_sum_2 WHERE bewart_id <> 1010 AND mandant_id = ''' || TRIM(yy.mandant_id) || ''' AND wup_id = ' || TRIM(xx.wup_id) || ' AND dat IN (''' || TRIM(dat) || ''');
')
--Standardfälle
WHEN (xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) <> 0 THEN 'UPDATE dbp_rfi.kmo_wpuums_2 SET rfi_freigabe = ''2'' WHERE landkz = ''' || TRIM(yy.mandant_kbez) || ''' AND filnr = ' || TRIM(xx.wup_id) || ' AND belegdatum IN (''' || TRIM(xx.belegdatum) || ''');
DELETE FROM dbp_data.artbew_2 WHERE bewart_id <> 1010 AND mandant_id = ''' || TRIM(yy.mandant_id) || ''' AND wup_id = ' || TRIM(xx.wup_id) || ' AND dat IN (''' || TRIM(dat) || '''); 
DELETE FROM dbp_data.artbew_wg_sum_2 WHERE bewart_id <> 1010 AND mandant_id = ''' || TRIM(yy.mandant_id) || ''' AND wup_id = ' || TRIM(xx.wup_id) || ' AND dat IN (''' || TRIM(dat) || ''');'
ELSE 'keine Aktion_2 !!!' END
AS ""***UPDATE RFI <> ARTBEW_2***""

, CASE 
--Delta-Lieferung für Sonderfälle aus RO
WHEN (xx.UMSATZ_ARTBEW - xx.UMSATZ_RFI) <> 0 OR (xx.count_refnum > 1)
THEN 'sudo /bin/su - u_ve_p 
cd /dwh/dwhprod/projekt/ARTUMSKASSE/job
./job_dwh_kmo_ArtUms_mit_VIS.sh'
ELSE 'keine Aktion_2 !!!' END
AS ""***Shell-Aufruf***""

FROM 
(
SELECT
  COALESCE(rfi.wup_id, artbew.wup_id) AS wup_id
, COALESCE(rfi.dat, artbew.dat) AS dat
, COALESCE(rfi.mandant_id, artbew.mandant_id) AS mandant_id
, rfi.belegdatum
, rfi.rfi_feld
, rfi.refnum
, rfi.count_refnum
, rfi.min_refnum
, rfi.max_refnum
, SUM(rfi.menge_rfi) AS MENGE_RFI
, SUM(rfi.umsatz_brutto_rfi) AS UMSATZ_RFI
, SUM(artbew.menge) AS MENGE_ARTBEW
, SUM(artbew.umsatz) AS UMSATZ_ARTBEW
, SUM(mseg.menge_lagerbew_bme) AS MENGE_MSEG
, SUM(mseg.betrag_verkauf_ist) AS UMSATZ_MSEG
FROM
(
SELECT
t02.mandant_id
, t01.landkz
, t01.rfi_feld
, CAST(t01.filnr AS INTEGER) AS wup_id
, TO_DATE(t01.belegdatum, 'YYYYMMDD') AS dat
, t01.belegdatum
, t01.refnum
, MIN(t01.refnum) OVER (PARTITION BY t02.mandant_id, wup_id, dat) AS min_refnum
, MAX(t01.refnum) OVER (PARTITION BY t02.mandant_id, wup_id, dat) AS max_refnum
, COUNT(*) OVER (PARTITION BY t02.mandant_id, wup_id, dat) AS count_refnum
, SUM((CAST(SUBSTRING(umswert, 16, 20) AS NUMBER(18,4)) * (CASE WHEN vorzwert = '-' THEN (-1) ELSE 1 END)) + (CAST(SUBSTRING(umspromotion , 16 , 20) AS NUMBER(18,4)) * (CASE WHEN vorzpromotion = '-' THEN (-1) ELSE 1 END))) AS umsatz_brutto_rfi    /*noch ohne Kursumrechnung*/
, SUM(CAST(SUBSTRING(umsmenge , 16 , 20) AS NUMBER(18,4)) * (CASE WHEN vorzmenge = '-' THEN (-1) ELSE 1 END) * (-1)) AS menge_rfi
FROM dbp_rfi.kmo_wpuums_2 t01
JOIN dbp_view.v_mandant_2 t02
ON t01.landkz = t02.mandant_kbez
GROUP BY 1,2,3,4,5,6,7
) rfi

LEFT OUTER JOIN
(
SELECT 
a.wup_id
, a.dat
, a.mandant_id
, SUM(a.menge) AS menge
, SUM(a.umsatz_netto + a.umsatz_mwst_betrag) AS umsatz
FROM dbp_view.v_artbew_2 a
WHERE a.bewart_id <> 1010 
AND a.mandant_id <> 1
AND a.dat BETWEEN CURRENT_DATE-30 AND CURRENT_DATE-1
--AND a.dat IN ('2014-03-06', '2014-03-11', '2014-03-07')
--AND a.wup_id IN (2900,4760)
GROUP BY 1,2,3
) artbew_2

ON artbew.dat= rfi.dat
AND artbew.wup_id = rfi.wup_id
AND artbew.mandant_id = rfi.mandant_id

--MSEG-Vergleich
LEFT OUTER JOIN 
(
SELECT 
lbd.wup_id
, lbd.dat_buch
, lbd.mandant_id
, SUM(lbd.menge_lagerbew_bme) * -1 AS menge_lagerbew_bme
, SUM(lbd.betrag_verkauf_ist) * -1 AS betrag_verkauf_ist

FROM dbp_view.v_lagerbew_det_2 lbd
WHERE lbd.mandant_id <> 1
AND lbd.lager_bewart_id IN ('251', '252')
AND lbd.dat_buch BETWEEN CURRENT_DATE-30 AND CURRENT_DATE-1
--AND lbd.dat_buch IN ('2014-03-06', '2014-03-11', '2014-03-07')
--AND lbd.wup_id IN (2900,4760)
GROUP BY 1,2,3
) mseg

ON mseg.dat_buch = rfi.dat
AND mseg.wup_id = rfi.wup_id
AND mseg.mandant_id = rfi.mandant_id

GROUP BY 1,2,3,4,5,6,7,8,9
) xx

JOIN dbp_view.v_mandant_2 yy
ON XX.mandant_id = YY.mandant_id

GROUP BY 1,2,3,4,5,6,7,8,9,10,11;
