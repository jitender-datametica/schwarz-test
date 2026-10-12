CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_KASSE(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT,
	KASSE_NR,
	ANZ_ARTIKEL,
	REGISTRIERZEIT,
	KASSIERVORGANGSZEIT,
	KASSIERZEIT,
	ANZ_KUNDEN,
	UMSATZ_NETTO,
	WRG_ID,
    ANZ_ZEILENSTORNO,
    UMSATZ_NETTO_ZEILENSTORNO,
    ANZ_BONSTORNO,
    UMSATZ_NETTO_BONSTORNO,
    ANZ_BONABBRUCH,
    UMSATZ_NETTO_BONABBRUCH,
    ANZ_BON_ZEILENSTORNO,
    ANZ_BONABBRUCH_SUSPENDED,
    UMSATZ_NETTO_BONABBRUCH_SUSPENDED,
    UMSATZ_NETTO_KSCAN,
    ANZ_BON_KSCAN,
    ANZ_ZEILEN_KSCAN
) AS 
	
	-- FAKT AGGREGATION
	-- 2022-10-06 ssch0611 : Calculation EUR with new logic [P16167] 
	-- 2022-11-25 ssch0611 : bugfix column order
	-- 2023-07-20 staeblern: SPEC0196837 Neue Spalten 
	-- 2023-08-14 staeblern: SPEC0189820 entfernen des JOINS fuer Kassentyp
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
    -- 2024-11-21 muellerpatri : 6 neue Spalten zu kscan und suspended aufgenommen
 
SELECT
 vtk.mandant_id
 , vtk.nb_id
 , wup.aktuell_wup_id 																	AS wup_id
 , vtk.dat
 , vtk.kasse_nr
 , vtk.anz_artikel         																								-- Anzahl Scans/Bonzeilen
 , vtk.registrierzeit      																								-- Zeit der Scans
 , vtk.kassiervorgangszeit 																								-- Zeit der Scans inkl. Bezahlvorgang
 , vtk.kassierzeit         																								-- Zeit in der Kasse am System angemeldet
 , vtk.anz_kunden
 , vtk.umsatz_netto * krs.umrechnungskurs 												AS umsatz_netto
 , krs.nach_wrg_id 																		AS wrg_id
 , vtk.anz_zeilenstorno
 , vtk.umsatz_netto_zeilenstorno  * krs.umrechnungskurs 								AS umsatz_netto_zeilenstorno
 , vtk.anz_bonstorno
 , vtk.umsatz_netto_bonstorno     * krs.umrechnungskurs 								AS umsatz_netto_bonstorno
 , vtk.anz_bonabbruch
 , vtk.umsatz_netto_bonabbruch    * krs.umrechnungskurs 								AS umsatz_netto_bonabbruch
 , vtk.anz_bon_zeilenstorno
 , vtk.anz_bonabbruch_suspended
 , vtk.umsatz_netto_bonabbruch_suspended    * krs.umrechnungskurs                       AS umsatz_netto_bonabbruch_suspended
 , vtk.umsatz_netto_kscan                       * krs.umrechnungskurs                   AS umsatz_netto_kscan
 , vtk.anz_bon_kscan
 , vtk.anz_zeilen_kscan
FROM dbp_view.v_vis_tag_kasse vtk
 
INNER JOIN ( 
	SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
	FROM dbp_data.kurs krs1 
	WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
	AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
	UNION ALL 
	SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
	FROM dbp_data.kurs krs2 
	WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
	AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
	) krs
ON krs.von_wrg_id = vtk.wrg_id

INNER JOIN dbp_view.v_wup wup
ON vtk.mandant_id = wup.mandant_id AND vtk.wup_id = wup.wup_id
;