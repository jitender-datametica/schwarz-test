--#------------------------------------------------------------------------------
--# Skriptname   : kmo_wpuums_mis.btq
--# Erstelldatum : 03.11.2008
--#------------------------------------------------------------------------------
--# Projekt   : TP1_MIS
--# Kommentar : weiterfuehrende RFI Ueberpruefung der Daten der Schnittstelle
--#             KMO_WPUUMS_1 (Kassen Direktentsorgung) fuer die Teiprojekte MIS
--#             und laden der Daten in das Aggregat artbew_wg_sum_1
--# Quelle    : Tabelle DBP_LOAD.kmo_wpuums_1
--# Ziel      : Tabelle DBP_RFI.kmo_wpuums_1
--#             Tabelle DBP_DATA.artbew_wg_sum_1
--#------------------------------------------------------------------------------
--# History:
--#  03.11.2008  Michael Ueding   Ersterstellung ...
--#  10.02.2011  Adrien Bieligk   Parallelbeladung MIS für alle Länder
--#  17.05.2011  Michael Ueding   Erweiterung wg. Promotion, Entfernen der
--#                               Information HERKUNFT
--#  16.09.2011  Adrien Bieligk   Parallelbeladung MIS für alle Länder gelöscht
--#  10.10.2012  Michael Ueding   Anforderung Bestand Reichweite: Menge fortschreiben
--#  09.01.2014  Alex Alberg      COMMIT WORK nach dem INSERT in die Tab. artbew_wg_sum_1
--#                               und vor dem UPDATE auf die Tab. wupcal_1 implementiert
--#------------------------------------------------------------------------------
--# Processing Steps
--#    1.) Logon auf der Datenbank
--#    2.) Erzeugen der temporaeren Tabellen
--#    3.) Loeschen der Artikel_1 0000009800130, 0000009800131, 0000009800132 fuer
--#        Kroatien (fuer MIS nicht relevant)
--#    4.) Befuellung der Temp-Tabelle kmo_wpuums_tmp_1
--#    5.) Berechnung der Umsaetze in Euro Waehrung
--#    6.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_wg_sum_1
--#    7.) Befuellung der artbew_wg_sum_1
--#    8.) Bereinigung der RFI Tabelle kmo_wpuums_1
--#    9.) Marktkalender Update
--#   10.) Füllen der dbp_process.artbew_wg_sum_agg_wt_1
--#   11.) Bteq beenden
--#------------------------------------------------------------------------------


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_tmp_1;


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_wpuums_tmp_1 LIKE dbp_data.artbew_wg_sum_1;


/*
#------------------------------------------------------------------------------
# 3.) Loeschen der Artikel_1 0000009800130, 0000009800131, 0000009800132 fuer
#     Kroatien (fuer MIS nicht relevant)
#------------------------------------------------------------------------------
*/


DELETE FROM dbp_etl.kmo_wpuums_1
WHERE landkz = 'HR' AND artnr_integer IN (9800130, 9800131, 9800132);


/*
#------------------------------------------------------------------------------
# 4.) Befuellung der Temp-Tabelle kmo_wpuums_tmp_1
#------------------------------------------------------------------------------
#  Bedeutung der Bewegungsarten (Abweichend von der Lookuptabelle bewart_1!!):
#  1001: Datenherkunft Kasse (SAP wird ueber diesen Weg nicht eingespielt)
#------------------------------------------------------------------------------
*/


-- Mai 2011: Promotionswert von Umsatz abziehen (addieren, weil negatives Vorzeichen)

/* mue 13.01.2010: Nach Abstimmung mit Hr. Ferber/VIS auf Arthiertyp_1 2 gesetzt */
-- die Konz Betraege werden in einem folgenden
/* Kassen Direktentsorgung */ /* Kassen Direktentsorgung */
-- ,(l.belegdatum_dat / 100) +  190000 AS kjmo
-- Schritt berechnet

-- Anforderung Bestand/Reichweite
/* Belegbruttoumsatz - Promotionsumsatz = (Brutto)Kassenumsatz */
INSERT INTO
dbp_etl.kmo_wpuums_tmp_1 (
    mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id, bewart_id, kjmo,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    quelle,
    menge
)
(
    SELECT
        lkp_mandant_id AS mandant_id,
        lkp_nb_id AS nb_id,
        2 AS arthiertyp_id,
        lkp_wg_id AS wg_id,
        belegdatum_dat AS dat,
        lkp_wup_id AS wup_id,
        1001 AS bewart_id,
        CAST(
            ROUND(
                CAST(FORMAT_DATE('%Y%m', belegdatum_dat) AS BIGNUMERIC), 0
            ) AS INTEGER
        ) AS kjmo,
        CAST(SUM(ROUND(CAST(SUBSTR(umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN vorzwert = '-'
                THEN -1
            ELSE 1
        END + ROUND(CAST(SUBSTR(umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN vorzpromotion = '-'
                THEN -1
            ELSE 1
        END) AS NUMERIC),
        SUM(CAST((ROUND(CAST(SUBSTR(umswert, 16, 20) AS NUMERIC), 4) * CASE
            WHEN vorzwert = '-'
                THEN -1
            ELSE 1
        END + ROUND(CAST(SUBSTR(umspromotion, 16, 20) AS NUMERIC), 4) * CASE
            WHEN vorzpromotion = '-'
                THEN -1
            ELSE 1
        END) / (1 + lkp_mwst / 100) AS NUMERIC)),
        belegwaers AS umsatz_wrg,
        SUM(0),
        SUM(0),
        1 AS quelle,
        CAST(SUM(ROUND(CAST(SUBSTR(umsmenge, 16, 20) AS NUMERIC), 4) * CASE
            WHEN vorzmenge = '-'
                THEN -1
            ELSE 1
        END * -1) AS NUMERIC)
    FROM dbp_etl.kmo_wpuums_1 AS L
    GROUP BY
        mandant_id,
        wup_id,
        wg_id,
        bewart_id,
        dat,
        nb_id,
        arthiertyp_id,
        umsatz_wrg,
        kjmo,
        quelle
);


/*
#------------------------------------------------------------------------------
# 5.) Berechnung der Umsaetze in Euro Waehrung
#     (ACHTUNG: Berechnung mit Kurstyp 3 und nicht wie bei Artbew_1 mit Kurstyp 9)
#------------------------------------------------------------------------------
*/


UPDATE dbp_etl.kmo_wpuums_tmp_1 SET
    umsatz_brutto_konz
    = ROUND(
        CAST(kmo_wpuums_tmp.umsatz_brutto * K.umrechnungskurs AS NUMERIC), 4
    ),
    umsatz_netto_konz
    = ROUND(CAST(kmo_wpuums_tmp.umsatz_netto * K.umrechnungskurs AS NUMERIC), 4)
FROM
    dbp_data.kurs_1 AS K
WHERE
    kmo_wpuums_tmp.umsatz_wrg = K.von_wrg_id
    AND kmo_wpuums_tmp.dat BETWEEN K.dat_von AND K.dat_bis
    AND K.nach_wrg_id
    = 'EUR' AND K.kurstyp_id = 3;


/*
#------------------------------------------------------------------------------
# 6.) Loeschen der bestehenden Daten aus der Zieltabelle artbew_wg_sum_1
#
#------------------------------------------------------------------------------
*/


DELETE FROM dbp_data.artbew_wg_sum_1
WHERE bewart_id = 1001 AND (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_wpuums_tmp_1
) AND quelle = 1; -- Daten in der Zieltabelle stammen aus der Kasse


--kalkulierte Umsaetze werden durch Kasse Direkt oder SAP Korrektur ersetzt.


DELETE FROM dbp_data.artbew_wg_sum_1
WHERE bewart_id IN (
    1001, 1009
)
AND (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_wpuums_tmp_1
)
AND (mandant_id, wup_id, nb_id, dat) IN (
    SELECT (
        mandant_id, wup_id,
        nb_id, dat
    )
    FROM dbp_data.wupcal_1
    WHERE datenlieferung_artbew_wg_sum = 2
);


-- nun alle Daten aus der temporaeren Tabelle loeschen
-- die nicht in die in die Zieltabelle uebernommen werden,
-- weil obige Bedinung(en) nicht erfuellt sind.


DELETE FROM dbp_etl.kmo_wpuums_tmp_1
WHERE (
    mandant_id, wup_id, dat, nb_id) IN (
    SELECT (T.mandant_id, T.wup_id, T.dat, T.nb_id)
    FROM dbp_etl.kmo_wpuums_tmp_1 AS T
    INNER JOIN dbp_data.artbew_wg_sum_1
        AS A ON T.mandant_id = A.mandant_id AND T.wup_id = A.wup_id AND T.nb_id
    = A.nb_id AND T.dat = A.dat AND A.bewart_id IN (1001, 1009)
);


/*
#------------------------------------------------------------------------------
# 7.) Befuellung der artbew_wg_sum_1
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_data.artbew_wg_sum_1 (
    mandant_id, nb_id, arthiertyp_id, wg_id, dat, wup_id, bewart_id, kjmo,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    quelle,
    menge
)
(SELECT
    mandant_id,
    nb_id,
    arthiertyp_id,
    wg_id,
    dat,
    wup_id,
    bewart_id,
    kjmo,
    umsatz_brutto,
    umsatz_netto,
    umsatz_wrg,
    umsatz_brutto_konz,
    umsatz_netto_konz,
    quelle,
    menge
FROM dbp_etl.kmo_wpuums_tmp_1);


/*
#------------------------------------------------------------------------------
#  9.) Marktkalender Update
#      Hier folgt der Update auf den Marktkalender (wupcal_1) wenn Tagesdaten
#      geliefert und verarbeitet wurden
#------------------------------------------------------------------------------
*/


UPDATE dbp_data.wupcal_1 SET
    datenlieferung_artbew_wg_sum = 1
WHERE (
    mandant_id, wup_id, nb_id, dat) IN (
    SELECT (mandant_id, wup_id, nb_id, dat)
    FROM dbp_etl.kmo_wpuums_tmp_1
);


/*
#------------------------------------------------------------------------------
# 10.) Fuellen der dbp_process.artbew_wg_sum_agg_wt_1
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_etl_process.artbew_wg_sum_agg_wt_1 (
    mandant_id, wup_id, nb_id, dat, calc_fg, dat_lief
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat,
        0 AS calc_fg,
        CURRENT_DATE("Europe/Berlin") AS dat_lief
    FROM dbp_etl.kmo_wpuums_tmp_1
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat,
        calc_fg,
        dat_lief
);


/*
#------------------------------------------------------------------------------
# 11.) Ende
#------------------------------------------------------------------------------
*/
