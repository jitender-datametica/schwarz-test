/*
#----------------------------------------------------------------------------
# Source Safe Info
#----------------------------------------------------------------------------
# Skriptname             : kmo_wpuums_rfi_freigabe.btq
# Aktuelle Version       : 1.0
# Check-Out Datum        : 06.11.2008
# Version-erstellt Datum : 06.11.2008
#----------------------------------------------------------------------------
# Projekt : TP2_AIS/TP1_MIS
# Comment : automatische RFI_Freigabe, wenn fehlende Stammdaten zwischenzeitlich
#           vorhanden sind
# Source  : dbp_etl_rfi.kmo_wpuums_1
# Target  : dbp_etl.kmo_wpuums_1
#----------------------------------------------------------------------------
# History:
# 06.11.2008  Michael Ueding   Ersterstellung
# 19.08.2009  Michael Ueding   Automatische Freigabe RFI Fehler 40031 wenn
#                              Eroeffnungsdatum Markt vor dem Belegdatum liegt.
# ...
# 18.05.2011  Michael Ueding   Entfernen der Selektion nach Quellkennzeichen
# 25.02.2016  Ulrike Hofmann   durch Abloesung TCURR ueber ABI entfaellt Process-Tabelle
# 12.11.2018  Dennis Bayraktar Umstellung auf "as is"-Sicht fuer WGs.
#----------------------------------------------------------------------------
# Processing Steps
#    1.) Logon auf Datenbank
#    2.) Hilfstabellen fuer Join auf Artikel_1 und Markt anlegen
#    3.) Hilfstabellen fuellen
#    4.) Kroatische Artikelnummer 989999 auf 980000 umsetzen.
#    5.) Freigabe, wenn referentielle Integritaet zwischenzeitlich gegeben ist.
#    6.) Hilfstabellen loeschen
#    7.) BTEQ beenden
#----------------------------------------------------------------------------
*/

/*
#------------------------------------------------------------------------------
# 1.) Logon auf Datenbank
#------------------------------------------------------------------------------
*/


/*
#-------------------------------------------------------------------------------
# 2.) Hilfstabellen fuer Join auf Artikel_1 und Markt anlegen
#-------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_art_map_1;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_wpuums_art_map_1 (
    landkz STRING(3) NOT NULL,
    artnr STRING(25),
    kl_art_id INTEGER NOT NULL
);


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_wup_map_1;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_wpuums_wup_map_1 (
    landkz STRING(3) NOT NULL,
    filnr STRING(10),
    wup_id INTEGER NOT NULL
);


/*
#------------------------------------------------------------------------------
# 3.) Hilfstabellen fuellen
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE dbp_etl_rfi.kmo_wpuums_1 (
    cycle_id BIGNUMERIC(38, 0),
    loop_id BIGNUMERIC(38, 0),
    rfi_id BIGNUMERIC(38, 0),
    rfi_feld STRING(1000) COLLATE 'und:ci',
    rfi_freigabe STRING(1) COLLATE 'und:ci',
    rfi_datum DATE,
    segnam STRING(1) COLLATE 'und:ci',
    landkz STRING(3) COLLATE 'und:ci',
    filnr STRING(10) COLLATE 'und:ci',
    refnum STRING(16) COLLATE 'und:ci',
    belegdatum STRING(8) COLLATE 'und:ci',
    belegwaers STRING(4) COLLATE 'und:ci',
    qualartnr STRING(4) COLLATE 'und:ci',
    artnr STRING(25) COLLATE 'und:ci',
    aktionsnr STRING(15) COLLATE 'und:ci',
    vorzmenge STRING(1) COLLATE 'und:ci',
    umsmenge STRING(35) COLLATE 'und:ci',
    vorzwert STRING(1) COLLATE 'und:ci',
    umswert STRING(35) COLLATE 'und:ci',
    mwtax STRING(10) COLLATE 'und:ci',
    wgr STRING(6) COLLATE 'und:ci',
    vorzpromotion STRING(1) COLLATE 'und:ci',
    umspromotion STRING(35) COLLATE 'und:ci',
    promotionart STRING(10) COLLATE 'und:ci'
);


INSERT INTO dbp_etl.kmo_wpuums_art_map_1 (landkz, artnr, kl_art_id)
(
    SELECT
        landkz,
        artnr,
        CAST(artnr AS INTEGER) AS artnr2
    FROM dbp_etl_rfi.kmo_wpuums_1
    WHERE rfi_id < 20000 -- Datentyppruefung erfolgreich bestanden

    GROUP BY
        landkz,
        artnr
);


-- Markttag liegt vor dem Eroeffnungsdatum des Marktes
-- Datentyppruefung erfolgreich bestanden
INSERT INTO
dbp_etl.kmo_wpuums_wup_map_1 (landkz, filnr, wup_id)
(
    SELECT
        landkz,
        filnr,
        CAST(filnr AS INTEGER) AS filnr2
    FROM dbp_etl_rfi.kmo_wpuums_1
    WHERE
        rfi_id < 20000
        OR rfi_id = 40031
    GROUP BY
        landkz,
        filnr
);


/*
#------------------------------------------------------------------------------
#  4.) Kroatische Artikelnummer 989999 auf 980000 umsetzen.
#      SAP Artikel_1 989999L ist nicht im DWH Artikelstamm und wird mit WG
#      Erfassartikel 980000 ersetzt.
#------------------------------------------------------------------------------
*/

/*
UPDATE dbp_etl_rfi.kmo_wpuums_1
SET artnr = '0000009800000'
WHERE landkz = 'HR'
  AND artnr = '0000000989999'


*/

/*
#------------------------------------------------------------------------------
#  5.) Freigabe, wenn referentielle Integritaet zwischenzeitlich gegeben ist.
#      Es wird immer der gesamte Markttag freigegeben, weil dieser bei Auftritt
#      eines RFI Fehler auch komplett in die RFI Umgebung_1 verschoben wurde.
#
#      Pro Markttag und RFI Fehler darf kein einziger Datensatz vorhanden sein,
#      der immer noch den enstprechenden RFI Fehler aufweist.
#
#      Jeder Markttag kann aufgrund der Logik in der RFI Pruefung zu einem
#      Zeitpunkt nur mit einem RFI Fehler in der RFI Umgebung_1 vorhanden sein.
#
#      In Abstimmung mit PAM wurde am 19.08.2009 der RFI Fehler "Belegdatum
#      liegt vor dem Eroeffnungsdatum des Marktes" in die automatische Freigabe
#      mit aufgenommen (mue 19.08.2009).
#------------------------------------------------------------------------------
*/

-- Land_1


UPDATE dbp_etl_rfi.kmo_wpuums_1 SET
    rfi_freigabe = '2'
WHERE rfi_id = 10197 AND UPPER(rfi_feld) = 'LANDKZ' AND TRIM(rfi_freigabe) = '' AND (landkz, filnr, belegdatum) IN (
    SELECT (L.landkz, L.filnr, L.belegdatum)
    FROM dbp_etl_rfi.kmo_wpuums_1 AS L
    INNER JOIN dbp_etl_process.land_mandant_zu_1 AS LM ON L.landkz = LM.land_id
    WHERE
        L.rfi_id = 10197
        AND UPPER(L.rfi_feld) = 'LANDKZ'
    GROUP BY L.landkz,
    L.filnr,
    L.belegdatum
);


-- Artikel_1


UPDATE dbp_etl_rfi.kmo_wpuums_1 SET
    rfi_freigabe = '2'
WHERE rfi_id = 10001 AND UPPER(rfi_feld) = 'ARTNR' AND TRIM(rfi_freigabe) = '' AND (landkz, filnr, belegdatum) NOT IN (
    SELECT (L.landkz, L.filnr, L.belegdatum)
    FROM dbp_etl_rfi.kmo_wpuums_1 AS L
    INNER JOIN dbp_etl.kmo_wpuums_art_map_1 AS M ON L.landkz = M.landkz AND L.artnr = M.artnr
    LEFT JOIN dbp_etl_process.land_mandant_zu_1 AS LM ON L.landkz = LM.land_id
    LEFT JOIN (
        SELECT
            mandant_id,
            kl_art_id
        FROM dbp_data.art_1
        GROUP BY
            mandant_id,
            kl_art_id
    ) AS a ON M.kl_art_id = a.kl_art_id AND LM.mandant_id = a.mandant_id
    WHERE
        L.rfi_id = 10001
        AND UPPER(L.rfi_feld) = 'ARTNR'
        AND a.kl_art_id IS NULL
    GROUP BY L.landkz,
    L.filnr,
    L.belegdatum
);


-- Mehrwertsteuersatz


UPDATE dbp_etl_rfi.kmo_wpuums_1 SET
    rfi_freigabe = '2'
WHERE rfi_id = 10196 AND UPPER(rfi_feld) = 'MWTAX' AND TRIM(rfi_freigabe) = '' AND (landkz, filnr, belegdatum) NOT IN (
    SELECT (L.landkz, L.filnr, L.belegdatum)
    FROM dbp_etl_rfi.kmo_wpuums_1 AS L
    INNER JOIN dbp_etl.kmo_wpuums_art_map_1 AS M ON L.landkz = M.landkz AND L.artnr = M.artnr
    INNER JOIN dbp_etl_process.land_mandant_zu_1 AS LM ON L.landkz = LM.land_id
    LEFT JOIN (
        SELECT
            mandant_id,
            kl_art_id,
            MAX(art_id) AS art_id
        FROM dbp_data.art_1
        GROUP BY
            mandant_id,
            kl_art_id
    ) AS a ON M.kl_art_id = a.kl_art_id AND LM.mandant_id = a.mandant_id
    LEFT JOIN dbp_data.art_1 AS AA ON LM.mandant_id = AA.mandant_id AND a.art_id = AA.art_id
    LEFT JOIN dbp_data.mwst_per_1 AS MW
        ON
            LM.mandant_id = MW.mandant_id AND AA.mwst_id = MW.mwst_id AND
            PARSE_DATE('%Y%m%d', L.belegdatum) BETWEEN MW.dat_von AND MW.dat_bis
    WHERE
        L.rfi_id = 10196
        AND UPPER(L.rfi_feld) = 'MWTAX'
        AND MW.mandant_id IS NULL
    GROUP BY L.landkz,
    L.filnr,
    L.belegdatum
);


-- Markt


UPDATE dbp_etl_rfi.kmo_wpuums_1 SET
    rfi_freigabe = '2'
WHERE rfi_id = 10003 AND UPPER(rfi_feld) = 'FILNR' AND TRIM(rfi_freigabe) = '' AND (landkz, filnr, belegdatum) IN (
    SELECT (L.landkz, L.filnr, L.belegdatum)
    FROM dbp_etl_rfi.kmo_wpuums_1 AS L
    INNER JOIN dbp_etl.kmo_wpuums_wup_map_1 AS M ON L.landkz = M.landkz AND L.filnr = M.filnr
    INNER JOIN dbp_etl_process.land_mandant_zu_1 AS LM ON L.landkz = LM.land_id
    INNER JOIN dbp_data.wup_1 AS W ON LM.mandant_id = W.mandant_id AND CAST(M.filnr AS FLOAT64) = W.wup_id
    WHERE
        L.rfi_id = 10003
        AND UPPER(L.rfi_feld) = 'FILNR'
    GROUP BY L.landkz,
    L.filnr,
    L.belegdatum
);


-- Eroeffnungsdatum Markt liegt vor dem Belegdatum


UPDATE dbp_etl_rfi.kmo_wpuums_1 SET
    rfi_freigabe = '2'
WHERE rfi_id = 40031 AND UPPER(rfi_feld) = 'BELEGDATUM' AND TRIM(rfi_freigabe) = '' AND (landkz, filnr, belegdatum) IN (
    SELECT (L.landkz, L.filnr, L.belegdatum)
    FROM dbp_etl_rfi.kmo_wpuums_1 AS L
    INNER JOIN dbp_etl.kmo_wpuums_wup_map_1 AS M ON L.landkz = M.landkz AND L.filnr = M.filnr
    INNER JOIN dbp_etl_process.land_mandant_zu_1 AS LM ON L.landkz = LM.land_id
    INNER JOIN dbp_data.wup_1 AS W
        ON
            LM.mandant_id = W.mandant_id AND CAST(M.filnr AS FLOAT64) = W.wup_id
            AND PARSE_DATE('%Y%m%d', L.belegdatum) >= W.dat_von
    WHERE
        L.rfi_id = 40031
        AND UPPER(L.rfi_feld) = 'BELEGDATUM'
    GROUP BY L.landkz,
    L.filnr,
    L.belegdatum
);


-- Zentraleinkaeufer


UPDATE dbp_etl_rfi.kmo_wpuums_1 SET
    rfi_freigabe = '2'
WHERE rfi_id = 10148 AND UPPER(rfi_feld) = 'ZEK_1' AND TRIM(rfi_freigabe) = '' AND (landkz, filnr, belegdatum) NOT IN (
    SELECT (L.landkz, L.filnr, L.belegdatum)
    FROM dbp_etl_rfi.kmo_wpuums_1 AS L
    INNER JOIN dbp_etl.kmo_wpuums_art_map_1 AS M ON L.landkz = M.landkz AND L.artnr = M.artnr
    INNER JOIN dbp_etl_process.land_mandant_zu_1 AS LM ON L.landkz = LM.land_id
    LEFT JOIN (
        SELECT
            mandant_id,
            kl_art_id,
            MAX(art_id) AS art_id
        FROM dbp_data.art_1
        GROUP BY
            mandant_id,
            kl_art_id
    ) AS a ON M.kl_art_id = a.kl_art_id AND LM.mandant_id = a.mandant_id
    LEFT JOIN dbp_data.art_1 AS AA ON LM.mandant_id = AA.mandant_id AND a.art_id = AA.art_id
    LEFT JOIN dbp_data.zek_1 AS Z ON LM.mandant_id = Z.mandant_id AND AA.zek_id = Z.zek_id
    WHERE
        L.rfi_id = 10148
        AND UPPER(L.rfi_feld) = 'ZEK_1'
        AND Z.mandant_id IS NULL
    GROUP BY L.landkz,
    L.filnr,
    L.belegdatum
);


-- Zuordnung Artikel_1 Warengruppe


UPDATE dbp_etl_rfi.kmo_wpuums_1 SET
    rfi_freigabe = '2'
WHERE
    rfi_id = 10016 AND UPPER(rfi_feld) = 'ARTNR, WG' AND TRIM(rfi_freigabe) = '' AND (landkz, filnr, belegdatum)
    NOT IN (
        SELECT (L.landkz, L.filnr, L.belegdatum)
        FROM dbp_etl_rfi.kmo_wpuums_1 AS L
        INNER JOIN dbp_etl.kmo_wpuums_art_map_1 AS M ON L.landkz = M.landkz AND L.artnr = M.artnr
        INNER JOIN dbp_etl_process.land_mandant_zu_1 AS LM ON L.landkz = LM.land_id
        LEFT JOIN (
            SELECT
                mandant_id,
                kl_art_id,
                MAX(art_id) AS art_id
            FROM dbp_data.art_1
            GROUP BY
                mandant_id,
                kl_art_id
        ) AS a ON M.kl_art_id = a.kl_art_id AND LM.mandant_id = a.mandant_id
        LEFT JOIN dbp_data.art_1 AS AA ON LM.mandant_id = AA.mandant_id AND a.art_id = AA.art_id
        LEFT JOIN dbp_data.art_wg_zu_per_1 AS AWZ
            ON
                LM.mandant_id = AWZ.mandant_id AND AA.art_id = AWZ.art_id
                AND AWZ.dat_bis = PARSE_DATE('%Y%m%d', '99991231') AND AWZ.arthiertyp_id = 2
        WHERE
            L.rfi_id = 10016
            AND UPPER(L.rfi_feld) = 'ARTNR, WG'
            AND AWZ.mandant_id IS NULL
        GROUP BY L.landkz,
        L.filnr,
        L.belegdatum
    );


-- Warengruppe


UPDATE dbp_etl_rfi.kmo_wpuums_1 SET
    rfi_freigabe = '2'
WHERE rfi_id = 10140 AND UPPER(rfi_feld) = 'WG' AND TRIM(rfi_freigabe) = '' AND (landkz, filnr, belegdatum) NOT IN (
    SELECT (L.landkz, L.filnr, L.belegdatum)
    FROM dbp_etl_rfi.kmo_wpuums_1 AS L
    INNER JOIN dbp_etl.kmo_wpuums_art_map_1 AS M ON L.landkz = M.landkz AND L.artnr = M.artnr
    INNER JOIN dbp_etl_process.land_mandant_zu_1 AS LM ON L.landkz = LM.land_id
    LEFT JOIN (
        SELECT
            mandant_id,
            kl_art_id,
            MAX(art_id) AS art_id
        FROM dbp_data.art_1
        GROUP BY
            mandant_id,
            kl_art_id
    ) AS a ON M.kl_art_id = a.kl_art_id AND LM.mandant_id = a.mandant_id
    LEFT JOIN dbp_data.art_1 AS AA ON LM.mandant_id = AA.mandant_id AND a.art_id = AA.art_id
    LEFT JOIN dbp_data.art_wg_zu_per_1 AS AWZ
        ON
            LM.mandant_id = AWZ.mandant_id AND AA.art_id = AWZ.art_id
            AND AWZ.dat_bis = PARSE_DATE('%Y%m%d', '99991231') AND AWZ.arthiertyp_id = 2
    LEFT JOIN dbp_data.wg_per_1 AS WP
        ON
            LM.mandant_id = WP.mandant_id AND AWZ.wg_id = WP.wg_id AND
            PARSE_DATE('%Y%m%d', L.belegdatum) BETWEEN WP.dat_von AND WP.dat_bis AND WP.arthiertyp_id = 2
    WHERE
        L.rfi_id = 10140
        AND UPPER(L.rfi_feld) = 'WG'
        AND WP.mandant_id IS NULL
    GROUP BY L.landkz,
    L.filnr,
    L.belegdatum
);


---- Fehlerfreie Verarbeitung der Kurs_1 Datenlieferung
--
--UPDATE dbp_etl_rfi.kmo_wpuums_1 
--  SET rfi_freigabe = '2'
--WHERE rfi_id = 40038
--  AND UPPER(rfi_feld) = 'LANDKZ, BELEGDATUM'
--  AND TRIM(rfi_freigabe) = ''
--  AND (landkz, filnr, belegdatum) IN
--  (
--    SELECT 
--      l.landkz, l.filnr, l.belegdatum
--    FROM dbp_etl_rfi.kmo_wpuums_1 l
--    
--    INNER JOIN 
--    (
--      SELECT 
--         land_id
--        ,CAST(CAST(dat AS date FORMAT 'YYYYMMDD') AS STRING(10)) AS belegdatum
--      FROM dbp_etl_process.load_log_kurs_1 l
--      
--      INNER JOIN dbp_etl_process.land_mandant_zu_1 lm
--      ON l.mandant_id = lm.mandant_id
--      
--      WHERE ok_fg = 1
--    ) k
--    ON l.landkz = k.land_id
--      AND l.belegdatum = k.belegdatum
--  
--    WHERE rfi_id = 40038
--      AND UPPER(rfi_feld) = 'LANDKZ, BELEGDATUM'
--    
--    GROUP BY l.landkz, l.filnr, l.belegdatum
--  )
--;
--
--
--
--
/*
#------------------------------------------------------------------------------
# 6.) Hilfstabellen loeschen
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_art_map_1;


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_wup_map_1;


/*
#------------------------------------------------------------------------------
# 7.) BTEQ beenden
#------------------------------------------------------------------------------
*/
