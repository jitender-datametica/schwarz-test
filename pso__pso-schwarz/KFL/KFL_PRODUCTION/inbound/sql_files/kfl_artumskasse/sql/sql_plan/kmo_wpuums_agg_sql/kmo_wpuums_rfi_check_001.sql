/*
#------------------------------------------------------------------------------
# Skriptname   : kmo_wpuums_rfi_check.btq
# Erstelldatum : 14.10.2008
#------------------------------------------------------------------------------
# Projekt   : AIS KMO 
# Kommentar : RFI Ueberpruefung der Daten der Schnittstelle KMO_WPUUMS
#             (Kassen Direktentsorgung) fuer die Teiprojekte AIS und MIS
# Quelle    : TABLE dbp_etl.kmo_wpuums
# Ziel      : TABLE dbp_etl_rfi.kmo_wpuums
#------------------------------------------------------------------------------
# History:
#   14.10.2008  Michael Ueding   Ersterstellung  ...
#   16.05.2011  Michael Ueding   Erweiterung wegen Promotion, Entfernen des 
#                                Attributes quellkennzeichen
#   25.05.2010  Michael Ueding   Parameter RFI_FREIGABE entfernt, Mindestanzahl 
#                                Belege bei RFI Freigabe auf 1 in Cfg gesetzt
#   25.02.2016  Ulrike Hofmann   durch Abloesung TCURR ueber ABI entfaellt Process-Tabelle
#   12.11.2018  Dennis Bayraktar Umstellung auf "as is"-Sicht fuer WGs.
#------------------------------------------------------------------------------
# Processing Steps
#    1.) Logon auf der Datenbank
#    2.) Erzeugen der temporaeren Tabelle
#    3.) Kroatische Artikelnummer 989999 auf 980000 umsetzen.
#    4.) RFI Pruefung: Verarbeitung der taeglichen Kurs Datenlieferung erfolgreich
#    x.) Pruefung Eindeutigkeit der Datensaetze (herausgenommen, s. Kommentar unten)
#    5.) Pruefung mehrere Idocs fuer einen Markttag geliefert
#    6.) Datentypueberpruefung (erster Fehler wrid als RFI Grund gespeicher)
#    7.) Pruefung Mindestanzahl Datensaetze pro Markttag
#    8.) RFI: Summe Umsatz pro Markttag muss groesser als 0 sein.
#    9.) Anreichern der Ladetabelle mit den Lookupschluesseln
#        mandant_id, art_id, wup_id, nb_id, zek_id, wg_id
#   10.) Pruefung referentielle Integritaet: 
#        Mandant, Artikel, Markt, Umrechnungskurs, MWST, WG, ZEK
#   11.) Markttag ist schon geladen (nuer fuer Kassendaten relevant)
#   12.) Markttag aelter als Eroeffnungsdatum des Marktes
#   13.) Markttag liegt in der Zukunft
#   14.) Bteq beenden
#------------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 1.) Logon auf der Datenbank
#------------------------------------------------------------------------------
*/

/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabelle
#------------------------------------------------------------------------------
*/



DROP TABLE if exists dbp_etl.kmo_wpuums_dat;

CREATE  TABLE dbp_etl.kmo_wpuums_dat
(
  dat DATE NOT NULL
)
;

/*
#------------------------------------------------------------------------------
#  3.) Kroatische Artikelnummer 989999 auf 980000 umsetzen.
#      SAP Artikel 989999L ist nicht im DWH Artikelstamm und wird mit WG
#      Erfassartikel 980000 ersetzt.
#------------------------------------------------------------------------------
*/
/*
UPDATE dbp_etl.kmo_wpuums
SET artnr = '0000009800000'
WHERE landkz = 'HR'
  AND artnr = '0000000989999'
;


*/

/*
#------------------------------------------------------------------------------
# 4.) RFI Pruefung: Verarbeitung der taeglichen Kurs Datenlieferung erfolgreich
#     Diese Pruefung erfolgt vorab, da keine weitere Untersuchung der Daten
#     erforderlich ist wenn diese Bedingung nicht erfuellt wird.
#     Diese Pruefung nicht fuer die Slowakei anwenden da Slowakei seit 01.01.2009
#     die Waehrung Euro hat.
#------------------------------------------------------------------------------
*/

--INSERT INTO dbp_etl_rfi.kmo_wpuums
--(
--   cycle_id
--  ,loop_id
--  ,rfi_id
--  ,rfi_feld
--  ,rfi_freigabe
--  ,rfi_datum
--  ,segnam
--  ,landkz
--  ,filnr
--  ,refnum
--  ,belegdatum
--  ,belegwaers
--  ,qualartnr
--  ,artnr
--  ,aktionsnr
--  ,vorzmenge
--  ,umsmenge
--  ,vorzwert
--  ,umswert
--  ,mwtax
--  ,wgr
--  ,vorzpromotion
--  ,umspromotion
--  ,promotionart
--)
--SELECT
--   $CYCLE_ID
--  ,$LOOP_ID
--  ,40038 AS rfi_id
--  ,'landkz, belegdatum' AS rfi_feld
--  ,'' AS rfi_freigabe
--  ,date AS rfi_datum
--  ,segnam
--  ,landkz
--  ,filnr
--  ,refnum
--  ,belegdatum
--  ,belegwaers
--  ,qualartnr
--  ,artnr
--  ,aktionsnr
--  ,vorzmenge
--  ,umsmenge
--  ,vorzwert
--  ,umswert
--  ,mwtax
--  ,wgr
--  ,vorzpromotion
--  ,umspromotion
--  ,promotionart
--FROM dbp_etl.kmo_wpuums
--
--WHERE (landkz, belegdatum) NOT IN 
--  (
--    SELECT
--       land_id
--      ,CAST(CAST(dat AS date FORMAT 'YYYYMMDD') AS VARCHAR(10)) AS belegdatum
--    FROM dbp_etl_process.load_log_kurs l
--    
--    INNER JOIN dbp_etl_process.land_mandant_zu lm
--    ON l.mandant_id = lm.mandant_id
--    
--    WHERE ok_fg = 1
--  )
--  AND landkz <> 'SK' /*SK hat Umrechnungkurs 1 und ist deshalb nicht in load_log_kurs enthalten */
--;
--
--
--
--DELETE FROM dbp_etl.kmo_wpuums
--WHERE (landkz, filnr, belegdatum) IN
--  (
--    SELECT
--      landkz, filnr, belegdatum
--    FROM dbp_etl_rfi.kmo_wpuums
--    
--    WHERE cycle_id = $CYCLE_ID
--      AND loop_id = $LOOP_ID
--      AND rfi_id = '40038'
--  )
--;
--
--
--
/*
#------------------------------------------------------------------------------
# x.) Pruefung Eindeutigkeit der Datensaetze
#
#     Pruefung am 07.05.2009 herausgenommen nachdem bei der Gegenpruefung der
#     entsprechenden Bondaten festgestellt wurde, dass die mehrfachen Positionen
#     auch mehrfach als Bonpositionen auftauchen und abgerechnet wurden. Somit
#     sind diese Positionen korrekt und werden zukuenftig weiterverarbeitet.
#     OP: Warum werden diese Positionen nicht auf dem Kassenserver voraggregiert?
#------------------------------------------------------------------------------
*/

-- Enfaellt bis auf weiteres, siehe Kommentar

/*
#------------------------------------------------------------------------------
# 5.) Pruefung mehrere Idocs fuer einen Markttag geliefert
#     Die bisherige Ausnahme in MIS fuer HR wg. Leergut wird hier nicht angewendet
#     weil ueber die Kasse direkt das Leergut zusammen mit den "echten" Umsaetzen
#     in einer Datei und einem Idoc geliefert wird.
#     OP: Soll diese Pruefung auch auf SAP Korrekturen Lieferungen angewendet werden?
#------------------------------------------------------------------------------
*/
/*
INSERT INTO dbp_etl_rfi.kmo_wpuums
(
   cycle_id
  ,loop_id
  ,rfi_id
  ,rfi_feld
  ,rfi_freigabe
  ,rfi_datum
  ,segnam
  ,landkz
  ,filnr
  ,refnum
  ,belegdatum
  ,belegwaers
  ,qualartnr
  ,artnr
  ,aktionsnr
  ,vorzmenge
  ,umsmenge
  ,vorzwert
  ,umswert
  ,mwtax
  ,wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
)
SELECT
   $CYCLE_ID
  ,$LOOP_ID
  ,40035 AS rfi_id
  ,'refnum' AS rfi_feld
  ,'' AS rfi_freigabe
  ,DATE AS rfi_datum
  ,l.segnam
  ,l.landkz
  ,l.filnr
  ,l.refnum
  ,l.belegdatum
  ,l.belegwaers
  ,l.qualartnr
  ,l.artnr
  ,l.aktionsnr
  ,l.vorzmenge
  ,l.umsmenge
  ,l.vorzwert
  ,l.umswert
  ,l.mwtax
  ,l.wgr
  ,l.vorzpromotion
  ,l.umspromotion
  ,l.promotionart
FROM dbp_etl.kmo_wpuums l

INNER JOIN
(
  SELECT
     filnr
    ,belegdatum
    ,landkz
  FROM
  (
    SELECT
       filnr
      ,refnum
      ,belegdatum
      ,landkz
    FROM dbp_etl.kmo_wpuums
    GROUP BY 1, 2, 3, 4
  ) a
  GROUP BY 1, 2, 3
  
  HAVING COUNT(*) > 1
) a
ON l.filnr = a.filnr
  AND l.belegdatum = a.belegdatum
  AND l.landkz = a.landkz
;



DELETE FROM dbp_etl.kmo_wpuums
WHERE (landkz, filnr, belegdatum, refnum) IN
  (
    SELECT
      landkz, filnr, belegdatum, refnum
    FROM dbp_etl_rfi.kmo_wpuums
    
    WHERE cycle_id = $CYCLE_ID
      AND loop_id = $LOOP_ID
      AND rfi_id = '40035'
  )
;
*/

/*
#------------------------------------------------------------------------------
# 6.) Datentypueberpruefung (erster Fehler wrid als RFI Grund gespeichert)
#------------------------------------------------------------------------------
*/
/*
INSERT INTO dbp_etl_rfi.kmo_wpuums
(
   cycle_id
  ,loop_id
  ,rfi_id
  ,rfi_feld
  ,rfi_freigabe
  ,rfi_datum
  ,segnam
  ,landkz
  ,filnr
  ,refnum
  ,belegdatum
  ,belegwaers
  ,qualartnr
  ,artnr
  ,aktionsnr
  ,vorzmenge
  ,umsmenge
  ,vorzwert
  ,umswert
  ,mwtax
  ,wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
)
SELECT
   $CYCLE_ID
  ,$LOOP_ID
  ,rfi_id
  ,rfi_feld
  ,'' AS rfi_freigabe
  ,date AS rfi_datum
  ,l.segnam
  ,l.landkz
  ,l.filnr
  ,l.refnum
  ,l.belegdatum
  ,l.belegwaers
  ,l.qualartnr
  ,l.artnr
  ,l.aktionsnr
  ,l.vorzmenge
  ,l.umsmenge
  ,l.vorzwert
  ,l.umswert
  ,l.mwtax
  ,l.wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
FROM dbp_etl.kmo_wpuums l
INNER JOIN
(
  SELECT
     landkz
    ,filnr
    ,belegdatum
    ,(CASE WHEN dbp_etl_process.is_integer(filnr) = 0 THEN 'filnr'
           WHEN NOT (($DATIC(belegdatum, 4))) THEN 'belegdatum'
           WHEN dbp_etl_process.is_integer(artnr) = 0 THEN 'artnr'
           WHEN dbp_etl_process.is_num(umsmenge) = 0 THEN 'umsmenge'
           WHEN dbp_etl_process.is_num(umswert) = 0 THEN 'umswert'
           WHEN dbp_etl_process.is_num(umspromotion) = 0 THEN 'umspromotion'
           WHEN CAST(TRIM(artnr) AS DECIMAL(18,0)) > 2100000000 THEN 'artnr' -- Zahl groesser als Integer zulaesst
           ELSE ''
      END)  AS rfi_feld
    ,(CASE WHEN rfi_feld = 'filnr' THEN 30001
           WHEN rfi_feld = 'belegdatum' THEN 30003
           WHEN rfi_feld = 'artnr' THEN 30001
           WHEN rfi_feld = 'umsmenge' THEN 30001
           WHEN rfi_feld = 'umswert' THEN 30001
           WHEN rfi_feld = 'umspromotion' THEN 30001
           ELSE 0
      END) AS rfi_id
  FROM dbp_etl.kmo_wpuums
  WHERE rfi_feld <> ''

  QUALIFY ROW_NUMBER() OVER(PARTITION BY landkz, filnr, belegdatum ORDER BY rfi_id desc) = 1
) rfi
ON l.landkz = rfi.landkz
  AND l.filnr = rfi.filnr
  AND l.belegdatum = rfi.belegdatum
;



DELETE FROM dbp_etl.kmo_wpuums
WHERE (landkz, filnr, belegdatum) IN
  (
    SELECT
      landkz, filnr, belegdatum
    FROM dbp_etl_rfi.kmo_wpuums
    
    WHERE cycle_id = $CYCLE_ID
      AND loop_id = $LOOP_ID
      AND rfi_id IN ('30001', '30003')
  )
;
*/


/*
#------------------------------------------------------------------------------
# 7.) Pruefung Mindestanzahl Datensaetze pro Markttag
#     Mindestanzahl Belege wird ueber CFG File im Aufruf mitgegeben.
#------------------------------------------------------------------------------
*/
/*
INSERT INTO dbp_etl_rfi.kmo_wpuums
(
   cycle_id
  ,loop_id
  ,rfi_id
  ,rfi_feld
  ,rfi_freigabe
  ,rfi_datum
  ,segnam
  ,landkz
  ,filnr
  ,refnum
  ,belegdatum
  ,belegwaers
  ,qualartnr
  ,artnr
  ,aktionsnr
  ,vorzmenge
  ,umsmenge
  ,vorzwert
  ,umswert
  ,mwtax
  ,wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
)
SELECT
   $CYCLE_ID
  ,$LOOP_ID
  ,40011 AS rfi_id
  ,'landkz, filnr, belegdatum' AS rfi_feld
  ,'' AS rfi_freigabe
  ,date AS rfi_datum
  ,l.segnam
  ,l.landkz
  ,l.filnr
  ,l.refnum
  ,l.belegdatum
  ,l.belegwaers
  ,l.qualartnr
  ,l.artnr
  ,l.aktionsnr
  ,l.vorzmenge
  ,l.umsmenge
  ,l.vorzwert
  ,l.umswert
  ,l.mwtax
  ,l.wgr
  ,l.vorzpromotion
  ,l.umspromotion
  ,l.promotionart
FROM dbp_etl.kmo_wpuums l

INNER JOIN
(
  SELECT
     landkz
    ,filnr
    ,belegdatum
  FROM dbp_etl.kmo_wpuums

  GROUP BY
     landkz
    ,filnr
    ,belegdatum

  HAVING COUNT(*) < $MIND_ANZ_BELEGE
) rfi
ON l.landkz = rfi.landkz
  AND l.filnr = rfi.filnr
  AND l.belegdatum = rfi.belegdatum
;



DELETE FROM dbp_etl.kmo_wpuums
WHERE (landkz, filnr, belegdatum) IN
  (
    SELECT
      landkz, filnr, belegdatum
    FROM dbp_etl_rfi.kmo_wpuums
    
    WHERE cycle_id = $CYCLE_ID
      AND loop_id = $LOOP_ID
      AND rfi_id IN ('40011')
  )
;

*/

/*
#------------------------------------------------------------------------------
# 8.) RFI: Summe Umsatz pro Markttag muss groesser als 0 sein.
#------------------------------------------------------------------------------
*/
/*
INSERT INTO dbp_etl_rfi.kmo_wpuums
(
   cycle_id
  ,loop_id
  ,rfi_id
  ,rfi_feld
  ,rfi_freigabe
  ,rfi_datum
  ,segnam
  ,landkz
  ,filnr
  ,refnum
  ,belegdatum
  ,belegwaers
  ,qualartnr
  ,artnr
  ,aktionsnr
  ,vorzmenge
  ,umsmenge
  ,vorzwert
  ,umswert
  ,mwtax
  ,wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
)
SELECT
   $CYCLE_ID
  ,$LOOP_ID
  ,40036 AS rfi_id
  ,'refnum' AS rfi_feld
  ,'' AS rfi_freigabe
  ,DATE AS rfi_datum
  ,segnam
  ,landkz
  ,filnr
  ,refnum
  ,belegdatum
  ,belegwaers
  ,qualartnr
  ,artnr
  ,aktionsnr
  ,vorzmenge
  ,umsmenge
  ,vorzwert
  ,umswert
  ,mwtax
  ,wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
FROM dbp_etl.kmo_wpuums

WHERE (landkz, filnr, belegdatum) IN 
  (
    SELECT
       landkz
      ,filnr
      ,belegdatum
    FROM dbp_etl.kmo_wpuums
    
    GROUP BY
       landkz
      ,filnr
      ,belegdatum
      
    HAVING SUM
      (
        (CAST(SUBSTR(umswert, 24, 12) AS DECIMAL (12,2)) *
        (CASE WHEN vorzwert = '-' THEN -1 ELSE 1 END)) 
        +  --Promotionswert abziehen (negatives Vorzeichen deshalb addieren!!!)
        (CAST(SUBSTR(umspromotion, 24, 12) AS DECIMAL (12,2)) *
        (CASE WHEN vorzpromotion = '-' THEN -1 ELSE 1 END))
      ) <= 0
  ) 
;



DELETE FROM dbp_etl.kmo_wpuums
WHERE (landkz, filnr, belegdatum) IN
  (
    SELECT
      landkz, filnr, belegdatum
    FROM dbp_etl_rfi.kmo_wpuums
    
    WHERE cycle_id = $CYCLE_ID
      AND loop_id = $LOOP_ID
      AND rfi_id = '40036'
  )
;
*/


/*
#------------------------------------------------------------------------------
# 9.) Anreichern der Ladetabelle mit den Lookupschluesseln
#     mandant_id, art_id, wup_id, nb_id, zek_id, wg_id
#------------------------------------------------------------------------------
*/
/*
-- Datentypen sind im vorgehenden Schritt geprueft
UPDATE dbp_etl.kmo_wpuums

SET belegdatum_dat = TO_DATE(belegdatum,'YYYYMMDD')
  , filnr_integer  = filnr 
  , artnr_integer  = artnr
;


	
-- mandant_id
UPDATE dbp_etl.kmo_wpuums
FROM dbp_etl_process.land_mandant_zu m

SET lkp_mandant_id = m.mandant_id

WHERE dbp_etl.kmo_wpuums.landkz = m.land_id
;



-- wup_id, nb_id
UPDATE dbp_etl.kmo_wpuums
FROM dbp_data.wup w

SET lkp_wup_id = w.wup_id
  , lkp_nb_id = w.nb_id

WHERE dbp_etl.kmo_wpuums.lkp_mandant_id = w.mandant_id
  AND dbp_etl.kmo_wpuums.filnr_integer = w.wup_id
;

*/

-- art_id, zek_id, mwst_id, posten_id
UPDATE dbp_etl.kmo_wpuums
FROM
(
  SELECT
     mandant_id
    ,kl_art_id
    ,art_id
    ,zek_id
    ,mwst_id
    ,posten_id 
  FROM dbp_data.art a
  
 /* GROUP BY
     mandant_id
    ,kl_art_id    
  QUALIFY CSUM(1, art_id DESC) = 1*/
  QUALIFY ROW_NUMBER() OVER(PARTITION BY mandant_id, kl_art_id ORDER BY art_id desc) = 1
) dt
SET 
/*lkp_art_id = dt.art_id
  , lkp_zek_id = dt.zek_id
  , lkp_mwst_id = dt.mwst_id 
  , */
lkp_posten_id = dt.posten_id 

WHERE dbp_etl.kmo_wpuums.lkp_mandant_id = dt.mandant_id
  AND dbp_etl.kmo_wpuums.artnr_integer = dt.kl_art_id
;

/*

-- wg_id, arthiertyp_id 

UPDATE dbp_etl.kmo_wpuums
FROM dbp_data.art_wg_zu_per w

SET lkp_wg_id = w.wg_id
  , lkp_arthiertyp_id = w.arthiertyp_id

WHERE dbp_etl.kmo_wpuums.lkp_mandant_id = w.mandant_id
  AND dbp_etl.kmo_wpuums.lkp_art_id = w.art_id
  AND w.dat_bis = TO_DATE('99991231','YYYYMMDD')
  AND w.arthiertyp_id = 2
;



-- Umrechnungskurs 
UPDATE dbp_etl.kmo_wpuums
FROM dbp_data.kurs k

SET lkp_umrechnungskurs = k.umrechnungskurs 

WHERE dbp_etl.kmo_wpuums.belegwaers = k.von_wrg_id 
  AND dbp_etl.kmo_wpuums.belegdatum_dat BETWEEN k.dat_von ANd k.dat_bis 
  AND k.kurstyp_id = 9
  AND k.nach_wrg_id = 'EUR'
; 



-- MWST Satz
UPDATE dbp_etl.kmo_wpuums 
FROM dbp_data.mwst_per m

SET lkp_mwst = m.mwst

WHERE dbp_etl.kmo_wpuums.lkp_mandant_id = m.mandant_id
  AND dbp_etl.kmo_wpuums.lkp_mwst_id = m.mwst_id
  AND dbp_etl.kmo_wpuums.belegdatum_dat BETWEEN m.dat_von AND m.dat_bis
; 

*/

/*
#------------------------------------------------------------------------------
# 10.) Pruefung referentielle Integritaet: 
#      Mandant, Artikel, Markt, Umrechnungskurs, MWST, WG, ZEK
#------------------------------------------------------------------------------
*/
/*
INSERT INTO dbp_etl_rfi.kmo_wpuums
(
   cycle_id
  ,loop_id
  ,rfi_id
  ,rfi_feld
  ,rfi_freigabe
  ,rfi_datum
  ,segnam
  ,landkz
  ,filnr
  ,refnum
  ,belegdatum
  ,belegwaers
  ,qualartnr
  ,artnr
  ,aktionsnr
  ,vorzmenge
  ,umsmenge
  ,vorzwert
  ,umswert
  ,mwtax
  ,wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
)
SELECT
   $CYCLE_ID
  ,$LOOP_ID
  ,rfi_id
  ,rfi_feld
  ,'' AS rfi_freigabe
  ,DATE AS rfi_datum
  ,l.segnam
  ,l.landkz
  ,l.filnr
  ,l.refnum
  ,l.belegdatum
  ,l.belegwaers
  ,l.qualartnr
  ,l.artnr
  ,l.aktionsnr
  ,l.vorzmenge
  ,l.umsmenge
  ,l.vorzwert
  ,l.umswert
  ,l.mwtax
  ,l.wgr
  ,l.vorzpromotion
  ,l.umspromotion
  ,l.promotionart
FROM dbp_etl.kmo_wpuums l

INNER JOIN
(
  SELECT
     l.landkz
    ,l.filnr
    ,l.belegdatum
    ,(CASE WHEN lkp_mandant_id IS NULL THEN 10197
           WHEN lkp_art_id IS NULL THEN 10001
           WHEN lkp_wup_id IS NULL THEN 10003
           WHEN lkp_zek_id IS NULL THEN 10148
           WHEN lkp_wg_id IS NULL THEN 10016
           WHEN lkp_mwst IS NULL THEN 10196
           WHEN lkp_umrechnungskurs IS NULL THEN 10023
           ELSE 0
      END)  AS rfi_id
    ,(CASE WHEN lkp_mandant_id IS NULL THEN 'landkz'
           WHEN lkp_art_id IS NULL THEN 'artnr'
           WHEN lkp_wup_id IS NULL THEN 'filnr'
           WHEN lkp_zek_id IS NULL THEN 'zek'
           WHEN lkp_wg_id IS NULL THEN 'artnr, wg'
           WHEN lkp_mwst IS NULL THEN 'mwtax'
           WHEN lkp_umrechnungskurs IS NULL THEN 'belegwaers'
           ELSE ''
      END) AS rfi_feld
  FROM dbp_etl.kmo_wpuums l

  WHERE rfi_id > 0
  
  QUALIFY ROW_NUMBER() OVER(PARTITION BY landkz, filnr, belegdatum ORDER BY rfi_id desc) = 1
) rfi
ON l.landkz = rfi.landkz
  AND l.filnr = rfi.filnr
  AND l.belegdatum = rfi.belegdatum
;



DELETE FROM dbp_etl.kmo_wpuums
WHERE (landkz, filnr, belegdatum) IN
  (
    SELECT
      landkz, filnr, belegdatum
    FROM dbp_etl_rfi.kmo_wpuums
    
    WHERE cycle_id = $CYCLE_ID
      AND loop_id = $LOOP_ID
      AND rfi_id IN ('10197', '10001', '10003', '10196', '10023', '10016', '10148')
  )
;
*/


/*
#------------------------------------------------------------------------------
# 11.) Markttag ist schon geladen (nuer fuer Kassendaten relevant)
#      Die temp. Tabelle kmo_wpuums_dat wird im folgenden Beladescript benoetigt.
#------------------------------------------------------------------------------
*/

-- Hilfstabelle fuer Join auf artbew
INSERT INTO dbp_etl.kmo_wpuums_dat
(
  dat
)
SELECT
  belegdatum_dat
FROM dbp_etl.kmo_wpuums

GROUP BY belegdatum_dat
;

/*
INSERT INTO dbp_etl_rfi.kmo_wpuums
(
   cycle_id
  ,loop_id
  ,rfi_id
  ,rfi_feld
  ,rfi_freigabe
  ,rfi_datum
  ,segnam
  ,landkz
  ,filnr
  ,refnum
  ,belegdatum
  ,belegwaers
  ,qualartnr
  ,artnr
  ,aktionsnr
  ,vorzmenge
  ,umsmenge
  ,vorzwert
  ,umswert
  ,mwtax
  ,wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
)
SELECT
   $CYCLE_ID
  ,$LOOP_ID
  ,40033 AS rfi_id
  ,'landkz, filnr, belegdatum' AS rfi_feld
  ,'' AS rfi_freigabe
  ,DATE AS rfi_datum
  ,l.segnam
  ,l.landkz
  ,l.filnr
  ,l.refnum
  ,l.belegdatum
  ,l.belegwaers
  ,l.qualartnr
  ,l.artnr
  ,l.aktionsnr
  ,l.vorzmenge
  ,l.umsmenge
  ,l.vorzwert
  ,l.umswert
  ,l.mwtax
  ,l.wgr
  ,l.vorzpromotion
  ,l.umspromotion
  ,l.promotionart
FROM dbp_etl.kmo_wpuums l

WHERE (lkp_mandant_id, lkp_wup_id, belegdatum_dat) IN
  (
    SELECT 
       a.mandant_id
      ,a.wup_id
      ,a.dat
    FROM dbp_data.artbew a,
    dbp_etl.kmo_wpuums_dat t

    WHERE a.dat = t.dat
      AND a.mandant_id > 1 
  )
;



DELETE FROM dbp_etl.kmo_wpuums
WHERE (landkz, filnr, belegdatum) IN
  (
    SELECT
      landkz, filnr, belegdatum
    FROM dbp_etl_rfi.kmo_wpuums
    
    WHERE cycle_id = $CYCLE_ID
      AND loop_id = $LOOP_ID
      AND rfi_id = '40033'
  )
;
*/


/*
#------------------------------------------------------------------------------
# 12.) Markttag aelter als Eroeffnungsdatum des Marktes
#------------------------------------------------------------------------------
*/
/*
INSERT INTO dbp_etl_rfi.kmo_wpuums
(
   cycle_id
  ,loop_id
  ,rfi_id
  ,rfi_feld
  ,rfi_freigabe
  ,rfi_datum
  ,segnam
  ,landkz
  ,filnr
  ,refnum
  ,belegdatum
  ,belegwaers
  ,qualartnr
  ,artnr
  ,aktionsnr
  ,vorzmenge
  ,umsmenge
  ,vorzwert
  ,umswert
  ,mwtax
  ,wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
)
SELECT
   $CYCLE_ID
  ,$LOOP_ID
  ,40031 AS rfi_id
  ,'belegdatum' AS rfi_feld
  ,'' AS rfi_freigabe
  ,DATE AS rfi_datum
  ,l.segnam
  ,l.landkz
  ,l.filnr
  ,l.refnum
  ,l.belegdatum
  ,l.belegwaers
  ,l.qualartnr
  ,l.artnr
  ,l.aktionsnr
  ,l.vorzmenge
  ,l.umsmenge
  ,l.vorzwert
  ,l.umswert
  ,l.mwtax
  ,l.wgr
  ,l.vorzpromotion
  ,l.umspromotion
  ,l.promotionart
FROM dbp_etl.kmo_wpuums l

INNER JOIN dbp_data.wup w
ON l.lkp_mandant_id = w.mandant_id
  AND l.lkp_wup_id = w.wup_id
  AND l.belegdatum_dat < w.dat_von
;



DELETE FROM dbp_etl.kmo_wpuums
WHERE (landkz, filnr, belegdatum) IN
  (
    SELECT
      landkz, filnr, belegdatum
    FROM dbp_etl_rfi.kmo_wpuums
    
    WHERE cycle_id = $CYCLE_ID
      AND loop_id = $LOOP_ID
      AND rfi_id = '40031'
  )
;
*/


/*
#------------------------------------------------------------------------------
# 13.) Markttag liegt in der Zukunft
#------------------------------------------------------------------------------
*/
/*
INSERT INTO dbp_etl_rfi.kmo_wpuums
(
   cycle_id
  ,loop_id
  ,rfi_id
  ,rfi_feld
  ,rfi_freigabe
  ,rfi_datum
  ,segnam
  ,landkz
  ,filnr
  ,refnum
  ,belegdatum
  ,belegwaers
  ,qualartnr
  ,artnr
  ,aktionsnr
  ,vorzmenge
  ,umsmenge
  ,vorzwert
  ,umswert
  ,mwtax
  ,wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
)
SELECT
   $CYCLE_ID
  ,$LOOP_ID
  ,40032 AS rfi_id
  ,'belegdatum' AS rfi_feld
  ,'' AS rfi_freigabe
  ,DATE AS rfi_datum
  ,segnam
  ,landkz
  ,filnr
  ,refnum
  ,belegdatum
  ,belegwaers
  ,qualartnr
  ,artnr
  ,aktionsnr
  ,vorzmenge
  ,umsmenge
  ,vorzwert
  ,umswert
  ,mwtax
  ,wgr
  ,vorzpromotion
  ,umspromotion
  ,promotionart
FROM dbp_etl.kmo_wpuums

WHERE belegdatum_dat > CURRENT_DATE
;



DELETE FROM dbp_etl.kmo_wpuums
WHERE (landkz, filnr, belegdatum) IN
  (
    SELECT
      landkz, filnr, belegdatum
    FROM dbp_etl_rfi.kmo_wpuums
    WHERE cycle_id = $CYCLE_ID
      AND loop_id = $LOOP_ID
      AND rfi_id = '40032'
  )
;
*/
