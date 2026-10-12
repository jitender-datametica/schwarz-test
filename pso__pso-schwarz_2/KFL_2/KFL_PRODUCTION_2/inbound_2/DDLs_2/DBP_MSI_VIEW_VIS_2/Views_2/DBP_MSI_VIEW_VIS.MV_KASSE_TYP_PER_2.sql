CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KASSE_TYP_PER_2 (
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT,
	KASSE_NR,
	KASSE_TYP_ID,
	SCO,
	DAT_VON,
	DAT_BIS
) AS 
 
/*
	ZUORDNUNG Kasse/Kassentyp pro Filiale und Tag_2 (denormalisert)
	dsim0608 20190307 SPEC0048808 SCO - count  (kasse_nr)
	snik1809 27042023 AP0163999 - update SCO, including 10,11
	staeblern 08082023 AP0163999 SPEC0189820 - View mit Tag_2 erweitern
	muellerpatri INC8011086 - Anpassung Logik mit last_value
	2024-09-10 ssch0611 : Filialumgliederung + Review [P1760]
	2024-09-19 ssch0611 : Fix Filialumgliederung : Gültigkeit Kasse <= Schließung Filiale!
*/
 
SELECT
  wup.mandant_id
, wup.wup_id
, wup.nb_id
, sub.dat
, sub.kasse_nr
, sub.kasse_typ_id
, LAST_VALUE(CASE WHEN kasse_typ_id IN (8,9,10,11) THEN 'Ja' ELSE 'Nein' END) 
	OVER (PARTITION BY sub.mandant_id, sub.wup_id, sub.kasse_nr ORDER BY sub.dat) 
  AS SCO
, sub.dat_von AS dat_von
, sub.fixed_dat_bis AS dat_bis
FROM dbp_view.v_wup_2 wup_2
 
LEFT OUTER JOIN (
	SELECT 
	  ktp.mandant_id
	, ktp.nb_id
	, wup.aktuell_wup_id AS wup_id
	, zeit.dat
	, ktp.kasse_nr
	, ktp.kasse_typ_id
	, ktp.dat_von
	, ktp.dat_bis AS ktp_dat_bis /* Gültigkeit Kasse */
	, wup.dat_bis AS wup_dat_bis /* Schließung Filiale */
	, CASE WHEN ktp.dat_bis <= wup.dat_bis THEN ktp.dat_bis ELSE wup.dat_bis END AS fixed_dat_bis
FROM DBP_VIEW.V_KASSE_TYP_PER_2 ktp
 
INNER JOIN DBP_VIEW.V_WUP_2 wup_2
ON wup.mandant_id=ktp.mandant_id AND wup.wup_id=ktp.wup_id
 
INNER JOIN DBP_VIEW.V_TAG_2 zeit_2
ON zeit.dat BETWEEN ktp.dat_von AND fixed_dat_bis
AND zeit.dat BETWEEN ADD_MONTHS(CURRENT_DATE(),-36) AND CURRENT_DATE()
) sub 
ON sub.mandant_id = wup.mandant_id AND sub.wup_id = wup.wup_id
 
WHERE wup.wup_id = aktuell_wup_id
AND wup.umzugsfiliale_fg = 0 
;