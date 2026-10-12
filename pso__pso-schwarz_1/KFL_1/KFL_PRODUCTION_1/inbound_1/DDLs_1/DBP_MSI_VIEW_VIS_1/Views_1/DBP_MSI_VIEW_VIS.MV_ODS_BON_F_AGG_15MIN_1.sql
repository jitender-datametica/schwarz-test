CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_F_AGG_15MIN_1(
   DAT
 , ZEIT_STUNDE
 , ZEIT_15MIN
 , WUP_ID
 , MANDANT_ID
 , KASSE_NR
 , WRG_ID
 , UMSATZ_BRUTTO
 , UMSATZ_NETTO
 , ANZ_ARTIKEL
 , ANZ_KUNDEN
 , BONANZAHL_SUG_OKF
 , KASSIERZEIT
 , REGISTRIERZEIT
 , ZAHLZEIT
 , ANZ_ZEILENSTORNO
 , UMSATZ_BRUTTO_ZEILENSTORNO
 , UMSATZ_NETTO_ZEILENSTORNO
 , ANZ_BONSTORNO
 , UMSATZ_BRUTTO_BONSTORNO
 , UMSATZ_NETTO_BONSTORNO
 , ANZ_BONABBRUCH
 , UMSATZ_BRUTTO_BONABBRUCH
 , UMSATZ_NETTO_BONABBRUCH
 , ANZ_BON_ZEILENSTORNO
 , ANZ_BONABBRUCH_SUSPENDED
 , UMSATZ_NETTO_BONABBRUCH_SUSPENDED
 , UMSATZ_NETTO_KSCAN
 , ANZ_BON_KSCAN
 , ANZ_ZEILEN_KSCAN
) AS
 
	-- FAKT/AGGREGAT BONDATEN VERDICHTET AUF STUNDE/15 MIN
	-- 20151221 SSCH0611 : ZUSAETZLICHE SPALTEN REGISTRIER-/ZAHLZEIT 
	-- 2019.0507 AWOL2209: COALESCE KASSENTYP AUFGENOMMEN
	-- 20190625 SNIK1809 : ADDED BONANZAHL_SUG, REDIRECTED TO DBE_MIG_ODS_27.ODS_BON_AGG_15MIN_1
	-- 2020-11-20 SSCH0611 : NEW COLUMN BONANZAHL_SUG_OKF (OHNE KUNDENFAKTOR) 
	-- 2022-10-04 ssch0611 : New column wrg_id + Calculation EUR with new logic [P16167]
	-- 2023-07-20 staeblern: SPEC0196837 Neue Spalten 
	-- 2023-08-14 staeblern: SPEC0189820 entfernen des JOINS fuer Kassentyp
	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
    -- 2024-11-21 muellerpatri : 6 neue Spalten zu kscan und suspended aufgenommen
    
SELECT
 V01.DAT
 , V01.ZEIT_STUNDE
 , V01.ZEIT_15MIN
 , wup.aktuell_wup_id 																					                  AS wup_id
 , V01.MANDANT_ID
 , V01.KASSE_NR
 , krs.nach_wrg_id                              														      AS WRG_ID 
 , V01.UMSATZ_BRUTTO * krs.umrechnungskurs      														      AS UMSATZ_BRUTTO
 , V01.UMSATZ_NETTO * krs.umrechnungskurs       														      AS UMSATZ_NETTO
 , V01.ANZ_ARTIKEL
 , V01.ANZ_KUNDEN
 , V01.BONANZAHL_SUG_OKF
 , V01.KASSIERZEIT
 , V01.REGISTRIERZEIT
 , V01.ZAHLZEIT
 , V01.ANZ_ZEILENSTORNO
 , V01.UMSATZ_BRUTTO_ZEILENSTORNO * krs.umrechnungskurs     											AS UMSATZ_BRUTTO_ZEILENSTORNO
 , V01.UMSATZ_NETTO_ZEILENSTORNO  * krs.umrechnungskurs     											AS UMSATZ_NETTO_ZEILENSTORNO
 , V01.ANZ_BONSTORNO
 , V01.UMSATZ_BRUTTO_BONSTORNO    * krs.umrechnungskurs     											AS UMSATZ_BRUTTO_BONSTORNO
 , V01.UMSATZ_NETTO_BONSTORNO     * krs.umrechnungskurs     											AS UMSATZ_NETTO_BONSTORNO
 , V01.ANZ_BONABBRUCH
 , V01.UMSATZ_BRUTTO_BONABBRUCH   * krs.umrechnungskurs     											AS UMSATZ_BRUTTO_BONABBRUCH
 , V01.UMSATZ_NETTO_BONABBRUCH    * krs.umrechnungskurs     											AS UMSATZ_NETTO_BONABBRUCH
 , V01.ANZ_BON_ZEILENSTORNO
 , V01.ANZ_BONABBRUCH_SUSPENDED
 , V01.UMSATZ_NETTO_BONABBRUCH_SUSPENDED    * krs.umrechnungskurs                                       AS UMSATZ_NETTO_BONABBRUCH_SUSPENDED
 , V01.UMSATZ_NETTO_KSCAN                       * krs.umrechnungskurs                                   AS UMSATZ_NETTO_KSCAN
 , V01.ANZ_BON_KSCAN
 , V01.ANZ_ZEILEN_KSCAN

FROM DBP_V_ODS.V_ODS_BON_AGG_15MIN_1 V01
 
INNER JOIN ( 
  SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
  FROM dbp_data.kurs_1 krs1 
  WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
  AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
  UNION ALL 
  SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
  FROM dbp_data.kurs_1 krs2 
  WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
  AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = V01.WRG_ID

INNER JOIN dbp_view.v_wup_1 wup_1
ON v01.mandant_id = wup.mandant_id AND v01.wup_id = wup.wup_id
;