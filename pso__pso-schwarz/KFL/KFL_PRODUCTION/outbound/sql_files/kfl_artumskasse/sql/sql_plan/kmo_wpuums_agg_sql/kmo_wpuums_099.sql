CREATE OR REPLACE TABLE dbp_etl.kmo_wpuums_dat (
    dat DATE NOT NULL
);


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
           WHEN CAST(TRIM(artnr) AS INTEGER) > 2100000000 THEN 'artnr' -- Zahl groesser als Integer zulaesst
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
        (CAST(SUBSTR(umswert, 24, 12) AS NUMBER(29,2)) *
        (CASE WHEN vorzwert = '-' THEN -1 ELSE 1 END))
        +  --Promotionswert abziehen (negatives Vorzeichen deshalb addieren!!!)
        (CAST(SUBSTR(umspromotion, 24, 12) AS NUMBER(29,2)) *
        (CASE WHEN vorzpromotion = '-' THEN -1 ELSE 1 END))
      ) <= 0
  )


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


-- mandant_id
UPDATE dbp_etl.kmo_wpuums
FROM dbp_etl_process.land_mandant_zu m

SET lkp_mandant_id = m.mandant_id

WHERE dbp_etl.kmo_wpuums.landkz = m.land_id


-- wup_id, nb_id
UPDATE dbp_etl.kmo_wpuums
FROM dbp_data.wup w

SET lkp_wup_id = w.wup_id
  , lkp_nb_id = w.nb_id

WHERE dbp_etl.kmo_wpuums.lkp_mandant_id = w.mandant_id
  AND dbp_etl.kmo_wpuums.filnr_integer = w.wup_id


*/

-- art_id, zek_id, mwst_id, posten_id


UPDATE dbp_etl.kmo_wpuums SET
    lkp_posten_id = t0.posten_id FROM (SELECT
    mandant_id,
    kl_art_id,
    art_id,
    zek_id,
    mwst_id,
    posten_id
FROM dbp_data.art AS A
QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1) AS t0
WHERE kmo_wpuums.lkp_mandant_id = t0.mandant_id AND kmo_wpuums.artnr_integer = t0.kl_art_id;


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


-- Umrechnungskurs
UPDATE dbp_etl.kmo_wpuums
FROM dbp_data.kurs k

SET lkp_umrechnungskurs = k.umrechnungskurs

WHERE dbp_etl.kmo_wpuums.belegwaers = k.von_wrg_id
  AND dbp_etl.kmo_wpuums.belegdatum_dat BETWEEN k.dat_von ANd k.dat_bis
  AND k.kurstyp_id = 9
  AND k.nach_wrg_id = 'EUR'


-- MWST Satz
UPDATE dbp_etl.kmo_wpuums
FROM dbp_data.mwst_per m

SET lkp_mwst = m.mwst

WHERE dbp_etl.kmo_wpuums.lkp_mandant_id = m.mandant_id
  AND dbp_etl.kmo_wpuums.lkp_mwst_id = m.mwst_id
  AND dbp_etl.kmo_wpuums.belegdatum_dat BETWEEN m.dat_von AND m.dat_bis


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

*/


/*
#------------------------------------------------------------------------------
# 11.) Markttag ist schon geladen (nuer fuer Kassendaten relevant)
#      Die temp. Tabelle kmo_wpuums_dat wird im folgenden Beladescript benoetigt.
#------------------------------------------------------------------------------
*/

-- Hilfstabelle fuer Join auf artbew


INSERT INTO dbp_etl.kmo_wpuums_dat (dat)
(
    SELECT belegdatum_dat
    FROM dbp_etl.kmo_wpuums
    GROUP BY belegdatum_dat
);


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

WHERE belegdatum_dat > CURRENT_DATE("Europe/Berlin")


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

*/


/*
#------------------------------------------------------------------------------
# Skriptname   : kmo_wpuums.btq
# Erstelldatum : 14.10.2008
#------------------------------------------------------------------------------
# Projekt   : AIS KMO
# Kommentar : Uebernahme der Daten der Schnittstelle WPUUMS Kasse fuer die
#             Teilproejekte AIS und KMO
# Quelle    : TABLE dbp_etl.kmo_wpuums
# Ziel      : TABLE $DBX_RFI.kmo_wpuums
#------------------------------------------------------------------------------
# History:
#   14.10.2008  Michael Ueding    Ersterstellung ...
#   17.05.2011  Michael Ueding    Erweiterung wg. Promotion
#   26.09.2011  Michael Ueding    Vorbelegung GLD Attribute mit 0
#   11.11.2011  Michael Ueding    Verschluesselung GLD Attribute entfernt
#   03.07.2012  Michael Ueding    Vorzeichen der Promotionsbetraege umgedreht
#                                 (Analog zur Poslog Verarbeitung)
#   15.08.2012  Torsten Bachmann  Protokollierung der Mandant-Tage fuer Aggregat art_bestand_vw_sum
#   06.03.2014  David Bandeira    COLLECT STATS im Step 10
#   04.06.2019  Dennis Bayraktar  Anreicherung fuer Aktionen jetzt ueber die neue
#                                 Tabelle dbp_etl_process.marktabschriften_stamm.
#------------------------------------------------------------------------------
# Processing Steps
#    1.) Logon auf der Datenbank
#    2.) Erzeugen der temporaeren Tabellen
#    3.) Befuellen der temporaeren Tabelle dbp_etl.kmo_wpuums_aktion_relevant
#    4.) Befuellen der temporaeren Tabelle dbp_etl.artbew_kmo_tmp
#    5.) Loeschen von bereits bestehenden Markttagen (die neue Version ersetzt die
#        bestehende Version)
#    6.) Aggregieren der neuen Datensaetze auf Tag, Art, Wup, GP Ebene
#    7.) Befuellen der Miniatur-Artbew zur Ablage der Promotionswerte
#    8.) Befuellen der Steuertabelle Artbew_agg_wt als Aufsetzpunkt zur Bildung
#        der Aggregate.
#    9.) Update Wupcal fuer gelieferte und verarbeitete Markttage
#   10.) Zwischenspeichern der Markttage die gerade geladen wurden zur spteren
#        Anreicherung mit EK Preisen
#   11.) Zwischenspeichern der Mandanttage die gerade geladen wurden zur spteren
#        Aggregation
#   12.) Protokollierung Anzahl Datensaetze pro Mandant
#   13.) Bereinigung der Load Umgebung
#   14.) Bteq beenden
#------------------------------------------------------------------------------
*/


-- GP nach Bezugsquellenfindung
-- Anzahl Infosaetze (1 wenn nur ungueltige vorhanden sind)

-- Ausstiegspunkt der Bezugsquellenfindung

-- VZ aus Kreisprozess fuer Bezugsweg 4 oder wup_id fuer Bezugsweg 1 fuer Zugriff auf EINA und EORD

-- Regel Ekorg aus Einkaufsinfosatz
-- Ekorg nach Bezugsquellenfindung
-- Anzahl Orderbuch gepflegt

-- VZ aus Kreisprozess fuer Bezugsweg 4 oder wup_id fuer Bezugsweg 1 fuer Zugriff auf EINA und EORD

-- Warengruppe fuer Zugriff auf vz_wup_wg_zu_per
-- Regel GP aus Einkaufsinfosatz
-- Kreistyp_gruppe aus Marktstamm.

-- Kurs fuer die Umrechnung von Landeswaehrung in Euro
CREATE OR REPLACE TABLE dbp_etl.kmo_wpuums_art_gp_wup_zu
(
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bezugsweg_id INTEGER,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER,
    ref_wup_id INTEGER,
    ref_nb_id INTEGER,
    kreistyp_gruppe_id STRING(4),
    wg_id INTEGER,
    umrechnungskurs FLOAT64
);


CREATE OR REPLACE TABLE dbp_etl.art_best_vw_sum_artbew_kmo_dat (
    mandant_id INTEGER NOT NULL,
    dat DATE
);


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_aktion_relevant;


DROP TABLE IF EXISTS dbp_etl.artbew_kmo_tmp;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_wpuums_aktion_relevant (
    mandant_id INTEGER NOT NULL,
    aktion_id STRING(10) NOT NULL,
    bewart_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    anz_aktion INTEGER NOT NULL
);


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_kmo_tmp LIKE dbp_data.artbew;


/*
#------------------------------------------------------------------------------
# 4.) Befuellen der temporaeren Tabelle dbp_etl.artbew_kmo_tmp
#------------------------------------------------------------------------------
*/

-- Bonuskauf Polska


-- AIS rechnet mit vier Nachkommastellen und erst beim Insert in die Zeiltabelle artbew_wg_sum wird auf zwei

-- Mai 2011: Umsatz Brutto = Belegbetrag minus Betrag Promotion (Promo mit negativen Vorzeichen deshalb addieren!!!)

-- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0

-- (MIS rechnet nur mit zwei Nachkommastellen -> deshalb ungenauer),

-- Nachkommastellen reduziert (s.o.), damit gibt es eine Abweichung zwischen der bestehenden MIS Verarbeitung

/* noch ohne Kursumrechnung */
-- ,CAST(CAST(umsatz_brutto AS NUMERIC(29,2))/ (mwst.mwst /100 + 1) AS NUMERIC(29,2)) AS umsatz_netto

-- im abschlieenden Insert in die Zieltabelle verschluesselt initialisiert (s.u.)

/* Kennzeichen ob in der Position ein Promotionsbetrag enthalten ist */
-- Fuer die KMO Laender ist die PostenID im Artikelstamm noch nicht vollstaendig gepflegt

-- Diese Umsatz_netto Berechnung wuerde das exakt gleiche Ergebnis liefern wie die "alte" MIS Verarbeitung

-- lt. Hr. Ferber 31.10.2008
-- und der neuen AIS Verarbeitung.
INSERT INTO dbp_etl.artbew_kmo_tmp (
    mandant_id,
    wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id, promo_fg, einkaufsorganisation_id, herst_id, mwst_id, menge,
    wrg, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, bezugsweg_id, posten_id
)
(
    SELECT
        L.lkp_mandant_id AS mandant_id,
        L.lkp_wup_id AS wup_id,
        L.lkp_nb_id AS nb_id,
        L.belegdatum_dat AS dat,
        CASE
            WHEN L.lkp_mandant_id = 3 AND L.promotionart = 'RB19'
                THEN 1002
            ELSE COALESCE(R.bewart_id, 1001)
        END AS bewart_id,
        -1 AS gp_id,
        L.lkp_art_id AS art_id,
        CASE
            WHEN L.lkp_mandant_id = 3 AND L.promotionart = 'RB19'
                THEN ''
            ELSE COALESCE(R.aktion_id, '')
        END AS aktion_id,
        CASE
            WHEN
                CASE
                    WHEN L.vorzmenge = '+' AND L.vorzpromotion = '-' AND L.promotionart = 'RB19'
                        THEN ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4)
                    ELSE ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
                        WHEN L.vorzpromotion = '-'
                            THEN -1
                        ELSE 1
                    END
                END <> 0
                THEN 1
            ELSE 0
        END AS promo_fg,
        -1 AS einkaufsorganisation_id,
        -1 AS herst_id,
        L.lkp_mwst_id AS mwst_id,
        CAST(ROUND(CAST(SUBSTR(L.umsmenge, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzmenge = '-'
                THEN -1
            ELSE 1
        END * -1 AS NUMERIC) AS menge,
        L.belegwaers AS wrg,
        CAST((ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + CASE
            WHEN L.vorzmenge = '+' AND L.vorzpromotion = '-' AND L.promotionart = 'RB19'
                THEN ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4)
            ELSE ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
                WHEN L.vorzpromotion = '-'
                    THEN -1
                ELSE 1
            END
        END) / (1 + L.lkp_mwst / 100) AS NUMERIC) AS umsatz_netto,
        CAST((ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + CASE
            WHEN L.vorzmenge = '+' AND L.vorzpromotion = '-' AND L.promotionart = 'RB19'
                THEN ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4)
            ELSE ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
                WHEN L.vorzpromotion = '-'
                    THEN -1
                ELSE 1
            END
        END) / (1 + L.lkp_mwst / 100) * L.lkp_umrechnungskurs AS NUMERIC) AS diff_umsatz_netto_konz,
        CAST(ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + CASE
            WHEN L.vorzmenge = '+' AND L.vorzpromotion = '-' AND L.promotionart = 'RB19'
                THEN ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4)
            ELSE ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
                WHEN L.vorzpromotion = '-'
                    THEN -1
                ELSE 1
            END
        END - CAST((ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + CASE
            WHEN L.vorzmenge = '+' AND L.vorzpromotion = '-' AND L.promotionart = 'RB19'
                THEN ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4)
            ELSE ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
                WHEN L.vorzpromotion = '-'
                    THEN -1
                ELSE 1
            END
        END) / (1 + L.lkp_mwst / 100) AS NUMERIC) AS NUMERIC) AS umsatz_mwst_betrag,
        CAST((ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + CASE
            WHEN L.vorzmenge = '+' AND L.vorzpromotion = '-' AND L.promotionart = 'RB19'
                THEN ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4)
            ELSE ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
                WHEN L.vorzpromotion = '-'
                    THEN -1
                ELSE 1
            END
        END - CAST((ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + CASE
            WHEN L.vorzmenge = '+' AND L.vorzpromotion = '-' AND L.promotionart = 'RB19'
                THEN ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4)
            ELSE ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
                WHEN L.vorzpromotion = '-'
                    THEN -1
                ELSE 1
            END
        END) / (1 + L.lkp_mwst / 100) AS NUMERIC)) * L.lkp_umrechnungskurs AS INT64) AS diff_umsatz_mwst_betrag_konz,
        0 AS bezugsweg_id,
        COALESCE(L.lkp_posten_id, ' ') AS posten_id
    FROM dbp_etl.kmo_wpuums AS L
    LEFT JOIN dbp_etl_process.marktabschriften_stamm AS R
        ON
            L.lkp_mandant_id = R.mandant_id AND L.lkp_art_id
            = R.art_id AND L.lkp_wup_id = R.wup_id AND L.lkp_nb_id = R.nb_id AND L.belegdatum_dat = R.dat
    LEFT JOIN dbp_data.aktion AS S
        ON
            L.lkp_mandant_id = S.mandant_id AND R.aktion_id = S.aktion_id AND L.belegdatum_dat
            BETWEEN S.dat_von AND S.dat_bis
    LEFT JOIN (
        SELECT
            mandant_id,
            aktion_id,
            MAX(konditionsart_id) AS konditionsart_id
        FROM dbp_data.l_bonuskauf
        GROUP BY
            mandant_id,
            aktion_id
    ) AS t ON L.lkp_mandant_id = t.mandant_id AND R.aktion_id = t.aktion_id
    WHERE L.lkp_mandant_id = 3
);


-- Bonuskauf normal


-- AIS rechnet mit vier Nachkommastellen und erst beim Insert in die Zeiltabelle artbew_wg_sum wird auf zwei

-- ,CAST(CAST(umsatz_brutto AS NUMERIC(29,2))/ (mwst.mwst /100 + 1) AS NUMERIC(29,2)) AS umsatz_netto

-- lt. Hr. Ferber 31.10.2008
-- (MIS rechnet nur mit zwei Nachkommastellen -> deshalb ungenauer),

-- Nachkommastellen reduziert (s.o.), damit gibt es eine Abweichung zwischen der bestehenden MIS Verarbeitung

-- und der neuen AIS Verarbeitung.

-- Mai 2011: Umsatz Brutto = Belegbetrag minus Betrag Promotion (Promo mit negativen Vorzeichen deshalb addieren!!!)

/* noch ohne Kursumrechnung */ -- im abschlieenden Insert in die Zieltabelle verschluesselt initialisiert (s.u.)

/* Kennzeichen ob in der Position ein Promotionsbetrag enthalten ist */
-- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0

-- Fuer die KMO Laender ist die PostenID im Artikelstamm noch nicht vollstaendig gepflegt

-- Diese Umsatz_netto Berechnung wuerde das exakt gleiche Ergebnis liefern wie die "alte" MIS Verarbeitung
INSERT INTO
dbp_etl.artbew_kmo_tmp (
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id, promo_fg,
    einkaufsorganisation_id, herst_id, mwst_id, menge, wrg, umsatz_netto, diff_umsatz_netto_konz, umsatz_mwst_betrag,
    diff_umsatz_mwst_betrag_konz, bezugsweg_id, posten_id
)
(
    SELECT
        L.lkp_mandant_id AS mandant_id,
        L.lkp_wup_id AS wup_id,
        L.lkp_nb_id AS nb_id,
        L.belegdatum_dat AS dat,
        COALESCE(R.bewart_id, 1001) AS bewart_id,
        -1 AS gp_id,
        L.lkp_art_id AS art_id,
        COALESCE(R.aktion_id, '') AS aktion_id,
        CASE
            WHEN
                ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
                    WHEN L.vorzpromotion = '-'
                        THEN -1
                    ELSE 1
                END <> 0
                THEN 1
            ELSE 0
        END AS promo_fg,
        -1 AS einkaufsorganisation_id,
        -1 AS herst_id,
        L.lkp_mwst_id AS mwst_id,
        CAST(ROUND(CAST(SUBSTR(L.umsmenge, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzmenge = '-'
                THEN -1
            ELSE 1
        END * -1 AS NUMERIC) AS menge,
        L.belegwaers AS wrg,
        CAST((ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzpromotion = '-'
                THEN -1
            ELSE 1
        END) / (1 + L.lkp_mwst / 100) AS NUMERIC) AS umsatz_netto,
        CAST((ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzpromotion = '-'
                THEN -1
            ELSE 1
        END) / (1 + L.lkp_mwst / 100) * L.lkp_umrechnungskurs AS NUMERIC) AS diff_umsatz_netto_konz,
        CAST(ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzpromotion = '-'
                THEN -1
            ELSE 1
        END - CAST((ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzpromotion = '-'
                THEN -1
            ELSE 1
        END) / (1 + L.lkp_mwst / 100) AS NUMERIC) AS NUMERIC) AS umsatz_mwst_betrag,
        CAST((ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzpromotion = '-'
                THEN -1
            ELSE 1
        END - CAST((ROUND(CAST(SUBSTR(L.umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzwert = '-'
                THEN -1
            ELSE 1
        END + ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzpromotion = '-'
                THEN -1
            ELSE 1
        END) / (1 + L.lkp_mwst / 100) AS NUMERIC)) * L.lkp_umrechnungskurs AS INT64) AS diff_umsatz_mwst_betrag_konz,
        0 AS bezugsweg_id,
        COALESCE(L.lkp_posten_id, ' ') AS posten_id
    FROM dbp_etl.kmo_wpuums AS L
    LEFT JOIN dbp_etl_process.marktabschriften_stamm AS R
        ON
            L.lkp_mandant_id = R.mandant_id AND L.lkp_art_id
            = R.art_id AND L.lkp_wup_id = R.wup_id AND L.lkp_nb_id = R.nb_id AND L.belegdatum_dat = R.dat
    WHERE L.lkp_mandant_id <> 3
);


/*
#------------------------------------------------------------------------------
# 5.) Loeschen von bereits bestehenden Markttagen (die neue Version ersetzt die
#     bestehende Version)
#------------------------------------------------------------------------------
*/


DELETE FROM dbp_data.artbew AS A
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.kmo_wpuums_dat
    WHERE A.dat = dat
)
AND (
    A.mandant_id, A.wup_id, A.dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_kmo_tmp
)
AND A.bewart_id <> 1010;


DELETE FROM dbp_data.artbew_promotion_zu AS A
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.kmo_wpuums_dat
    WHERE A.dat = dat
)
AND (
    A.mandant_id, A.wup_id, A.dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_kmo_tmp
    WHERE promo_fg = 1
)
AND A.konditionsart_id = 'RB19';


/*
#------------------------------------------------------------------------------
# 6.) Aggregieren der neuen Datensaetze auf Tag, Art, Wup, GP Ebene
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_data.artbew (
    mandant_id, wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id,
    promo_fg, einkaufsorganisation_id, herst_id, mwst_id, menge, wrg, umsatz_netto, diff_umsatz_netto_konz,
    umsatz_mwst_betrag, diff_umsatz_mwst_betrag_konz, ek_brutto, diff_ek_brutto_konz, ek_netto, diff_ek_netto_konz,
    ek_nettonetto, diff_ek_nettonetto_konz, ek_kal_basis, diff_ek_kal_basis_konz, ek_mep, diff_ek_mep_konz, einstandspreis,
    diff_einstandspreis_konz, logkostenzuschlag, diff_logkostenzuschlag_konz, bezugsweg_id, ek_netto_bnk,
    diff_ek_netto_bnk_konz, ek_netto_bnk_sachk, diff_ek_netto_bnk_sachk_konz, posten_id, ek_gld, diff_ek_gld_konz,
    td_update, td_insert
)
(SELECT
    mandant_id,
    wup_id,
    nb_id,
    dat,
    bewart_id,
    gp_id,
    art_id,
    aktion_id,
    promo_fg,
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge_sum,
    wrg,
    umsatz_netto_sum,
    diff_umsatz_netto_konz_sum,
    umsatz_mwst_betrag_sum,
    diff_umsatz_mwst_betrag_konz_s,
    zero_enc AS ek_brutto,
    zero_enc AS diff_ek_brutto_konz,
    zero_enc AS ek_netto,
    zero_enc AS diff_ek_netto_konz,
    zero_enc AS ek_nettonetto,
    zero_enc AS diff_ek_nettonetto_konz,
    zero_enc AS ek_kal_basis,
    zero_enc AS diff_ek_kal_basis_konz,
    zero_enc AS ek_mep,
    zero_enc AS diff_ek_mep_konz,
    zero_enc AS einstandspreis,
    zero_enc AS diff_einstandspreis_konz,
    0 AS logkostenzuschlag,
    0 AS diff_logkostenzuschlag_konz,
    bezugsweg_id,
    zero_enc AS ek_netto_bnk,
    zero_enc AS diff_ek_netto_bnk_konz,
    zero_enc AS ek_netto_bnk_sachk,
    zero_enc AS diff_ek_netto_bnk_sachk_konz,
    posten_id,
    0 AS ek_gld,
    0 AS diff_ek_gld_konz,
    CURRENT_TIMESTAMP() AS td_update,
    CURRENT_TIMESTAMP() AS td_insert
FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        promo_fg,
        gp_id,
        einkaufsorganisation_id,
        bewart_id,
        dat,
        aktion_id,
        herst_id,
        mwst_id,
        wrg,
        posten_id,
        bezugsweg_id,
        0 AS zero_enc,
        SUM(menge) AS menge_sum,
        SUM(umsatz_netto) AS umsatz_netto_sum,
        SUM(diff_umsatz_netto_konz) AS diff_umsatz_netto_konz_sum,
        SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum,
        SUM(diff_umsatz_mwst_betrag_konz) AS diff_umsatz_mwst_betrag_konz_s
    FROM dbp_etl.artbew_kmo_tmp
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        promo_fg,
        gp_id,
        einkaufsorganisation_id,
        bewart_id,
        dat,
        aktion_id,
        herst_id,
        mwst_id,
        wrg,
        posten_id,
        bezugsweg_id,
        zero_enc
) AS t0);


/*
#------------------------------------------------------------------------------
# 7.) Befuellen der Miniatur-Artbew zur Ablage der Promotionswerte
#------------------------------------------------------------------------------
*/


/* Positives Vorzeichen */ /* Positives Vorzeichen */ /* noch ohne Kursumrechnung */
-- eigentlich Inner Join, muss aber nochmal geklaert werden.
INSERT INTO dbp_data.artbew_promotion_zu (
    art_id,
    mandant_id, wup_id, nb_id, dat, bonuskauf_id, konditionsart_id, wrg_id, betrag_promo_netto, betrag_mwst,
    umrechnungskurs, system_id
)
(
    SELECT
        L.lkp_art_id AS art_id,
        L.lkp_mandant_id AS mandant_id,
        L.lkp_wup_id AS wup_id,
        L.lkp_nb_id AS nb_id,
        L.belegdatum_dat AS dat,
        '' AS bonuskauf_id,
        COALESCE(TRIM(L.promotionart), '') AS konditionsart_id,
        L.belegwaers AS wrg_id,
        SUM(CAST(ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzpromotion = '-'
                THEN -1
            ELSE 1
        END / (1 + L.lkp_mwst / 100) AS NUMERIC)) * -1.0000,
        CAST(SUM(ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzpromotion = '-'
                THEN -1
            ELSE 1
        END - CAST(ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzpromotion = '-'
                THEN -1
            ELSE 1
        END / (1 + L.lkp_mwst / 100) AS NUMERIC)) * -1.0000 AS NUMERIC),
        ROUND(CAST(L.lkp_umrechnungskurs AS NUMERIC), 5) AS umrechnungskurs,
        COALESCE(K.system_id, 0) AS system_id
    FROM dbp_etl.kmo_wpuums AS L
    LEFT JOIN dbp_data.l_konditionsart AS K
        ON
            L.lkp_mandant_id = K.mandant_id AND TRIM(L.promotionart) = K.konditionsart_id
    WHERE
        ROUND(CAST(SUBSTR(L.umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN L.vorzpromotion = '-'
                THEN -1
            ELSE 1
        END <> 0
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        dat,
        bonuskauf_id,
        konditionsart_id,
        wrg_id,
        umrechnungskurs,
        system_id
);


/*
#------------------------------------------------------------------------------
# 8.) Befuellein der Steuertabelle Artbew_agg_wt als Aufsetzpunkt zur Bildung
#     der Aggregate.
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_data.artbew_agg_wt (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_etl.artbew_kmo_tmp
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_data.artbew_agg_wt
    )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
);


/*
#------------------------------------------------------------------------------
# 9.) Update Wupcal fuer gelieferte und verarbeitete Markttage
#------------------------------------------------------------------------------
*/


UPDATE dbp_data.wupcal SET
    datenlieferung_artbew = 1,
    dat_extrakt_umsatz = CURRENT_DATE("Europe/Berlin"),
    td_update = CURRENT_TIMESTAMP()
WHERE (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.artbew_kmo_tmp
);


/*
#------------------------------------------------------------------------------
# 10.) Zwischenspeichern der Markttage die gerade geladen wurden zur spteren
#     Anreicherung mit EK Preisen
#------------------------------------------------------------------------------
*/

-- nur noch nicht vorhandene Kombinationen speichern


INSERT INTO dbp_etl.kmo_wpuums_art_gp_wup_zu (
    mandant_id, art_id, wup_id, nb_id, dat, bezugsweg_id,
    anz_ek_infosatz, anz_ek_orderbuch, bq_gp_id, bq_ekorg, bq_findung_id, regel_gp_id, regel_ekorg, ref_wup_id, ref_nb_id,
    kreistyp_gruppe_id, wg_id, umrechnungskurs
)
(
    SELECT
        lkp_mandant_id,
        lkp_art_id,
        lkp_wup_id,
        lkp_nb_id,
        belegdatum_dat,
        0 AS bezugsweg_id,
        0 AS anz_ek_infosatz,
        0 AS anz_ek_orderbuch,
        0 AS bq_gp_id,
        0 AS bq_ekorg,
        0 AS bq_findung_id,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        0 AS ref_wup_id,
        0 AS ref_nb_id,
        '' AS kreistyp_gruppe_id,
        0 AS wg_id,
        lkp_umrechnungskurs
    FROM dbp_etl.kmo_wpuums AS A
    WHERE (lkp_mandant_id, lkp_wup_id, lkp_nb_id, lkp_art_id, belegdatum_dat) NOT IN (SELECT (
        mandant_id, wup_id, nb_id,
        art_id, dat
    )
    FROM dbp_etl.kmo_wpuums_art_gp_wup_zu)
    GROUP BY
        lkp_mandant_id,
        lkp_art_id,
        lkp_wup_id,
        lkp_nb_id,
        lkp_umrechnungskurs,
        belegdatum_dat
);


/*
#------------------------------------------------------------------------------
# 11.) Zwischenspeichern der Mandanttage die gerade geladen wurden zur spaeteren
#      Aggregation
#------------------------------------------------------------------------------
*/

-- nur noch nicht vorhandene Kombinationen speichern


INSERT INTO dbp_etl.art_best_vw_sum_artbew_kmo_dat (mandant_id, dat)
(
    SELECT
        mandant_id,
        dat
    FROM dbp_etl.kmo_wpuums_art_gp_wup_zu
    WHERE (
        mandant_id, dat) NOT IN (
        SELECT (mandant_id, dat)
        FROM dbp_etl.art_best_vw_sum_artbew_kmo_dat
    )
    GROUP BY
        mandant_id,
        dat
);


/*
#------------------------------------------------------------------------------
# 12.) Protokollierung Anzahl Datensaetze pro Mandant
#------------------------------------------------------------------------------
*/

---CONTROLL_STEP
/*INSERT INTO dbp_etl_process.load_chk_figures
(
   cycle_id
  ,sql_name
  ,sql_type
  ,record_count
  ,durationsec
  ,err_count
  ,job_name
  ,scr_name
  ,loop_id
  ,proc_type
)
SELECT
   $CYCLE_ID
  ,CASE WHEN mandant_id = 2 THEN 'CONTRL:kmo_wpuumskasse_CZ'
        WHEN mandant_id = 3 THEN 'CONTRL:kmo_wpuumskasse_PL'
        WHEN mandant_id = 5 THEN 'CONTRL:kmo_wpuumskasse_SK'
        WHEN mandant_id = 6 THEN 'CONTRL:kmo_wpuumskasse_HR'
        WHEN mandant_id = 7 THEN 'CONTRL:kmo_wpuumskasse_RO'
        WHEN mandant_id = 8 THEN 'CONTRL:kmo_wpuumskasse_BG'
        ELSE 'N/A' END   AS sql_name
  ,'CONTRL'  AS sql_type
  ,COUNT(*)
  ,0 AS durationsec
  ,0 AS err_count
  ,CASE WHEN SUBSTRING('$JOB_NAME' FROM 1 FOR 1) = '$' THEN '' ELSE '$JOB_NAME' END   AS job_name
  ,CASE WHEN SUBSTRING('$PROC_NAME' FROM 1 FOR 1) = '$' THEN '' ELSE '$PROC_NAME' END AS scr_name
  ,$LOOP_ID AS loop_id
  ,CASE WHEN SUBSTRING('$PROC_TYPE' FROM 1 FOR 1) = '$' THEN '' ELSE '$PROC_TYPE' END
FROM dbp_etl.artbew_kmo_tmp
GROUP BY 1,2,3,5,6,7,8,9,10


*/
/*
#------------------------------------------------------------------------------
# 13.) Bereinigung der Load Umgebung
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.artbew_kmo_tmp;


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_aktion_relevant;


/*
#------------------------------------------------------------------------------
# 14.) Bteq beenden
#------------------------------------------------------------------------------
*/
