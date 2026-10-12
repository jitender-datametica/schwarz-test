CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_LEERGUT_DENORM(
	MANDANT_ID,
	WUP_ID,
  WUP_ID_EINLOESUNG,
	BARCODE_LEERGUT,
	BON_DAT,
	BON_ZEILE,
	WRG_ID,
	BON_TMSP,
  BON_TMSP_EINLOESUNG,
	KL_ART_ID,
	PLU_GRUPPE,
	LEERGUTTYP,
	MENGE_DENORM,
	BON_ZEILEN_WERT_DENORM,
	MIT_OHNE_BON,
	QUELLE_ERSTELLUNG,
	QUELLE_EINLOESUNG,
	STATUS_EINLOESUNG
) AS
  -- 2024-06-20 awolter : Filialumgliederung [P1760-DWH]
  -- 2024-10-16 muellerpatri : Filter auf wg_id <> 961 hinzugefügt [SPEC0276475]
  -- 2024-12-20 muellerpatri : Filter auf turnover_fg = 1

SELECT
  er.mandant_id
,wp_er.aktuell_wup_id AS wup_id                  -- wup_id Erstellung
,wp_ei.aktuell_wup_id AS wup_id_einloesung       -- wup_id Einloesung 
,er.BARCODE_LEERGUT 
,er.BON_DAT
,er.BON_ZEILE
,er.WRG_ID
,er.BON_TMSP AS BON_TMSP              -- Zeitstempel Erstellung
,ei.BON_TMSP AS BON_TMSP_EINLOESUNG   -- Zeitstempel Einloesung    
,er.KL_ART_ID
,er.PLU_GRUPPE
,er.LEERGUTTYP 
,er.menge
,er.BON_ZEILEN_WERT
,CASE WHEN er.quelle = 'INFO' THEN 'ohne Bon'
  ELSE 'mit Bon'
  END AS mit_ohne_BON
,er.quelle AS quelle_erstellung
,COALESCE(ei.quelle,'') AS quelle_einloesung
,COALESCE(ei.eistatus,er.erstatus) status_einloesung

 FROM 
 (
-- Erstellung Leergutbon am Pfandautomat

SELECT 
       ek.BARCODE_LEERGUT
   , ek.MANDANT_ID
   , ek.WUP_ID
   , ek.BON_DAT
   , krs.nach_wrg_id AS WRG_ID
   , ek.BON_TMSP
   , ek.BON_NR
   , ek.SYSTEM_BEZ
   , ek.SYSTEM_TYP_BEZ
   , ek.SYSTEM_HERSTELLER_BEZ
   , ep.BON_ZEILE
   , CASE WHEN ep.KL_ART_ID BETWEEN 1 AND 9999 THEN -1 ELSE ep.KL_ART_ID END KL_ART_ID
   , ep.PLU_GRUPPE
   , CASE WHEN plu_gruppe IN ('0000000000100', '0000000000300') THEN 'MW' 
          WHEN plu_gruppe IN ('0000000000200', '0000000000400') THEN 'EW' 
          ELSE 'UNKNOWN'
          END AS LEERGUTTYP
   , '' AS ean_kasse	
   , ep.BON_ZEILEN_WERT / ep.menge AS pfand_ST
   , ep.MENGE
   , ep.BON_ZEILEN_WERT * krs.umrechnungskurs AS BON_ZEILEN_WERT
   , 'ELS' AS quelle
   , '0' AS erstatus
FROM DBP_V_ODS.V_ELS_LEERGUT_KOPF ek
JOIN DBP_V_ODS.V_ELS_LEERGUT_POSITION ep
ON ek.MANDANT_ID = ep.MANDANT_ID 
 AND ek.BARCODE_LEERGUT = ep.BARCODE_LEERGUT
INNER JOIN
   ( 
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
  ON krs.von_wrg_id = ek.WRG_ID

UNION ALL

-- Erstellung Leergutbon an Leergutkasse
SELECT 
     LE.BARCODE_LEERGUT
   , LE.MANDANT_ID
   , LE.WUP_ID
   , LE.BON_DAT
   , krs.nach_wrg_id AS WRG_ID
   , LE.start_bon_zeile AS BON_TMSP
   , LE.bon_nr_extern AS BON_NR
   , '' AS SYSTEM_BEZ
   , '' AS SYSTEM_TYP_BEZ
   , '' AS SYSTEM_HERSTELLER_BEZ
   , LE.BON_ZEILE
   , LE.KL_ART_ID
   , '' AS PLU_GRUPPE
   , CASE WHEN LE.ean_kasse IS NULL THEN 'frei'  WHEN (LE.umsatz_brutto / LE.menge) = -0.25 THEN 'EW' ELSE 'MW' END AS LEERGUTTYP
   , ean_kasse	
   , LE.umsatz_brutto / LE.menge AS pfand_ST
   , LE.MENGE
   , LE.umsatz_brutto * krs.umrechnungskurs AS BON_ZEILEN_WERT
   , CASE WHEN k.kasse_typ_id = 3 THEN 'EMPTIES'
          WHEN k.kasse_typ_id = 2 THEN 'INFO'
          ELSE 'NONE'
          END AS quelle
   , '0' AS erstatus
FROM DBP_V_ODS.V_ODS_BON_kopf k
JOIN DBP_V_ODS.V_ODS_BON_LEERGUT LE
ON k.BON_ID = LE.BON_ID 
 AND k.MANDANT_ID = LE.MANDANT_ID 
 AND k.BON_DAT = LE.BON_DAT 
 AND k.WUP_ID = LE.WUP_ID 
 INNER JOIN
  ( 
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
ON  krs.von_wrg_id = k.WRG_ID
) er

JOIN dbp_view.v_wup wp_er
ON er.mandant_id = wp_er.MANDANT_ID 
AND er.wup_id = wp_er.wup_id


LEFT JOIN

( 
 
 -- Einlösung Leergutbon an der Kasse
SELECT 
 t2.BARCODE_LEERGUT
   , t1.MANDANT_ID
   , t1.WUP_ID
   , t1.BON_DAT
   , t1.bon_nr
   , 'KPOS_Verkauf' AS quelle
   , '1' AS eistatus
   , MIN(t2.start_bon_zeile) AS BON_TMSP
FROM DBP_V_ODS.V_ODS_BON_kopf t1
JOIN DBP_V_ODS.V_ODS_BON_VERKAUF t2
ON t1.BON_ID = t2.BON_ID 
 AND t1.MANDANT_ID = t2.MANDANT_ID 
 AND t1.BON_DAT = t2.BON_DAT 
 AND t1.WUP_ID = t2.WUP_ID
 WHERE 1=1
AND t2.BARCODE_LEERGUT IS NOT NULL
AND t2.BARCODE_LEERGUT <> ''
AND t2.wg_id <> 961
AND t1.turnover_fg = 1
GROUP BY 1,2,3,4,5,6,7

 UNION ALL

  -- Einlösung Leergutbon als Zahlungsmittel
SELECT 
       z.BARCODE_LEERGUT
   , t1.MANDANT_ID
   , t1.WUP_ID
   , t1.BON_DAT
   , t1.bon_nr
   , 'KPOS_Zahlung_BBN' AS quelle
   , '1' AS eistatus
   , MIN(z.start_bon_zeile) AS BON_TMSP
FROM DBP_V_ODS.V_ODS_BON_kopf t1
JOIN DBP_V_ODS.V_ODS_BON_zahlung z
ON t1.BON_ID = z.BON_ID 
 AND t1.MANDANT_ID = z.MANDANT_ID 
 AND t1.BON_DAT = z.BON_DAT 
 AND t1.WUP_ID = z.WUP_ID
 WHERE 1=1
AND z.BARCODE_LEERGUT IS NOT NULL
AND z.BARCODE_LEERGUT <> ''
AND z.KPOS_ZAHLUNG_TYP_ID = 'BBN'
GROUP BY 1,2,3,4,5,6,7
) ei

JOIN dbp_view.v_wup wp_ei
ON ei.mandant_id = wp_ei.MANDANT_ID 
AND ei.wup_id = wp_ei.wup_id

 ON er.barcode_leergut = ei.barcode_leergut
 AND er.mandant_id = ei.mandant_id
;