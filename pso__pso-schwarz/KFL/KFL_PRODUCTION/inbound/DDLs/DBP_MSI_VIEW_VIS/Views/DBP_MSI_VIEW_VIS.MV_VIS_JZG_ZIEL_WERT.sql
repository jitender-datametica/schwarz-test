CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_ZIEL_WERT (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	METRIK_ID,
	TYP_ID,
	LEVEL_ID,
	WERT_EINGABE,
	KOMMENTAR_EINGABE,
	ZEITSTEMPEL
) AS  
/* 
   FAKT JZG - Jahreszielgespräch - Eingabe Werte / Kommentare
   2023-02-15 ssch0611 : Setup inkl. Kommentare. AP0144461
*/
SELECT 
  jzg.mandant_id
, jzg.nb_id
, jzg.wup_id
, krs.nach_wrg_id AS wrg_id
, jzg.gj
, jzg.metrik_id
, jzg.typ_id
, jzg.level_id
, CASE /* Umrechnung 10 UMSATZ */
    WHEN jzg.metrik_id IN (10) THEN jzg.wert_eingabe * krs.umrechnungskurs
    ELSE jzg.wert_eingabe
  END AS wert_eingabe
, jzg.kommentar_eingabe 
, jzg.zeitstempel
FROM DBP_MSI_VIEW_VIS.TS_VIS_JZG_ZIEL_EINGABE  jzg
INNER JOIN ( 
	SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
	FROM DBP_DATA.KURS  krs1 
	WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
	AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
	UNION ALL 
	SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
	FROM DBP_DATA.KURS  krs2 
	WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
	AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = jzg.wrg_id
;
