-- USE WAREHOUSE WH_KFL_P_ETL_2XL;


CREATE OR REPLACE TEMPORARY TABLE _step01 (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    dat DATE,
    wrg STRING(3),
    ean_kasse INTEGER,
    menge FLOAT64,
    umsatz_netto_alt NUMERIC(29, 4),
    umsatz_mwst_betrag_alt NUMERIC(29, 4),
    umsatz_bto NUMERIC(29, 4),
    umrechnungskurs FLOAT64,
    kopf_art_id INTEGER,
    komponentenmengen_faktor NUMERIC(29, 4),
    stueckliste_id INTEGER
);


CREATE OR REPLACE TEMPORARY TABLE _step02 (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    dat DATE,
    wrg STRING(3),
    ean_kasse INTEGER,
    menge FLOAT64,
    umsatz_netto_alt NUMERIC(29, 4),
    umsatz_mwst_betrag_alt NUMERIC(29, 4),
    umsatz_bto NUMERIC(29, 4),
    umrechnungskurs FLOAT64,
    kopf_art_id INTEGER,
    komponentenmengen_faktor NUMERIC(29, 4),
    stueckliste_id INTEGER,
    bq_findung_id INTEGER,
    ek_brutto NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    logistikkostenzuschlag NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    ek_mep_vor_fwu NUMERIC(29, 4),
    bonusbasis NUMERIC(29, 4)
);


CREATE OR REPLACE TEMPORARY TABLE _step02a (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    dat DATE,
    wrg STRING(3),
    ean_kasse INTEGER,
    menge FLOAT64,
    umsatz_netto_alt NUMERIC(29, 4),
    umsatz_mwst_betrag_alt NUMERIC(29, 4),
    umsatz_bto NUMERIC(29, 4),
    umrechnungskurs FLOAT64,
    kopf_art_id INTEGER,
    komponentenmengen_faktor NUMERIC(29, 4),
    stueckliste_id INTEGER,
    bq_findung_id INTEGER,
    umsatz_anteil NUMERIC(29, 4),
    umsatz_netto NUMERIC(29, 4),
    umsatz_mwst NUMERIC(29, 4),
    ek_brutto NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    logistikkostenzuschlag NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    ek_mep_vor_fwu NUMERIC(29, 4),
    bonusbasis NUMERIC(29, 4),
    diff_ek_brutto_konz NUMERIC(29, 4),
    diff_ek_netto_konz NUMERIC(29, 4),
    diff_ek_nettonetto_konz NUMERIC(29, 4),
    diff_ek_kal_basis_konz NUMERIC(29, 4),
    diff_ek_mep_konz NUMERIC(29, 4),
    diff_einstandspreis_konz NUMERIC(29, 4),
    diff_logkostenzuschlag_konz NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
    ek_mep_vor_fwu_konz NUMERIC(29, 4),
    bonusbasis_konz NUMERIC(29, 4)
);


CREATE OR REPLACE TEMPORARY TABLE _step03 (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    dat DATE,
    wrg STRING(3),
    ean_kasse INTEGER,
    menge FLOAT64,
    umsatz_netto_alt NUMERIC(29, 4),
    umsatz_mwst_betrag_alt NUMERIC(29, 4),
    umsatz_bto NUMERIC(29, 4),
    umrechnungskurs FLOAT64,
    kopf_art_id INTEGER,
    komponentenmengen_faktor NUMERIC(29, 4),
    stueckliste_id INTEGER,
    bq_findung_id INTEGER,
    umsatz_anteil NUMERIC(29, 4),
    umsatz_netto NUMERIC(29, 4),
    umsatz_mwst NUMERIC(29, 4),
    ek_brutto NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    logistikkostenzuschlag NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    ek_mep_vor_fwu NUMERIC(29, 4),
    bonusbasis NUMERIC(29, 4),
    diff_ek_brutto_konz NUMERIC(29, 4),
    diff_ek_netto_konz NUMERIC(29, 4),
    diff_ek_nettonetto_konz NUMERIC(29, 4),
    diff_ek_kal_basis_konz NUMERIC(29, 4),
    diff_ek_mep_konz NUMERIC(29, 4),
    diff_einstandspreis_konz NUMERIC(29, 4),
    diff_logkostenzuschlag_konz NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
    ek_mep_vor_fwu_konz NUMERIC(29, 4),
    bonusbasis_konz NUMERIC(29, 4)
);


CREATE OR REPLACE TEMPORARY TABLE _aggregat01 (
    mandant_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    dat DATE,
    ean_kasse INTEGER,
    umsatz_netto NUMERIC(29, 4)
);


CREATE OR REPLACE TEMPORARY TABLE _spannen_agg1 (
    mandant_id INTEGER,
    wup_id INTEGER,
    kopf_art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    stueckliste_id INTEGER,
    dat DATE,
    ean_kasse INTEGER,
    ek_netto_sum NUMERIC(29, 4)
);


/*
_------------------------------------------------------------------------------
_ 12.) Stuecklisten aus ARTBEW_STUECKLISTE_ZU fuer RB extrahieren.
_------------------------------------------------------------------------------
*/


-- falls eine Komponente mehrfach in der Stueckliste vorhanden ist: Menge aufsummieren
INSERT INTO `_step01` (
    mandant_id,
    wup_id, nb_id, art_id, bewart_id, bewart_det_id, dat, wrg, ean_kasse, menge, umsatz_netto_alt, umsatz_mwst_betrag_alt,
    umsatz_bto, umrechnungskurs, kopf_art_id, komponentenmengen_faktor, stueckliste_id
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        b.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.dat,
        A.wrg,
        CAST(A.ean_kasse AS INTEGER) AS ean_kasse,
        SUM(CAST(A.menge AS FLOAT64)) AS menge,
        SUM(CAST(A.umsatz_netto AS NUMERIC)) AS umsatz_netto_alt,
        SUM(CAST(A.umsatz_mwst_betrag AS NUMERIC)) AS umsatz_mwst_betrag_alt,
        SUM(CAST(A.umsatz_netto + A.umsatz_mwst_betrag AS NUMERIC)) AS umsatz_bto,
        0 AS umrechnungskurs,
        A.art_id AS kopf_art_id,
        ROUND(CAST(SUM(
            CAST(A.menge AS FLOAT64) * CAST(b.komponentenmenge AS FLOAT64)) / MAX(
            COALESCE(C.umrech_faktor, 1.0000
            )
        ) AS NUMERIC), 4) AS komponentenmengen_faktor,
        b.stueckliste_id
    FROM dbp_data.artbew AS A
    INNER JOIN dbp_etl.kmo_wpuums_dat AS D ON A.dat = D.dat
    INNER JOIN dbp_etl.kmo_wpuums_art_gp_wup_zu AS Z
        ON
            A.mandant_id = Z.mandant_id AND A.art_id = Z.art_id
            AND A.wup_id = Z.wup_id AND A.nb_id = Z.nb_id AND A.dat = Z.dat
    INNER JOIN (
        SELECT
            A0.mandant_id,
            A0.stueckliste_id,
            A0.dat_von,
            A0.dat_bis,
            A0.art_id,
            NULL AS wup_id,
            NULL AS nb_id,
            A0.stueckliste_verwendung_id
        FROM dbp_data.stueckliste AS A0
        INNER JOIN dbp_etl.kmo_wpuums_dat_min AS M ON A0.dat_bis >= M.dat
        WHERE -- a.wup_id IS NULL AND
            A0.stueckliste_verwendung_id = 3
            AND (
                A0.mandant_id, A0.art_id, A0.stueckliste_id) IN (
                SELECT (mandant_id, art_id, MAX(stueckliste_id))
                FROM dbp_data.stueckliste
                GROUP BY mandant_id,
                art_id
            )
    ) AS k ON A.mandant_id = k.mandant_id AND A.art_id = k.art_id AND A.dat BETWEEN k.dat_von AND k.dat_bis
    -- Ermittlung Fußartikel

    INNER JOIN (
        SELECT *
        FROM dbp_data.stueckliste_det
        WHERE stueckliste_typ_id = 'M'
    ) AS b
        ON
            k.mandant_id = b.mandant_id AND k.stueckliste_id = b.stueckliste_id AND A.dat
            BETWEEN b.dat_von AND b.dat_bis
    -- Ermittlung Umrechnungsfaktor, damit korrekter Bezug zur Basismengeneinheit hergestellt wird.

    LEFT JOIN dbp_data.art_umrechnung_faktor_per AS C
        ON
            b.mandant_id = C.mandant_id AND b.art_id = C.art_id
            AND b.komponentenmenge_einh_id = C.altnv_menge_einh_id AND A.dat BETWEEN C.dat_von AND C.dat_bis
    WHERE
        A.mandant_id > 1
        AND A.menge <> 0
        AND A.umsatz_netto <> 0
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        b.art_id,
        A.dat,
        kopf_art_id,
        A.bewart_id,
        A.bewart_det_id,
        b.stueckliste_id,
        A.wrg,
        A.ean_kasse
);


/*
_------------------------------------------------------------------------------
_ 13.) Zuspielen der STKL-Koepfe in volatile Tabelle
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Nachgelagert werden dann alle Koepfe in dieselbe volatile Tabelle gespielt. Als Kennung wird in die Spalte
-- KOPF_ART_ID nun der Wert "-100" eingestellt, um spaeter zwischen Kopf und Fuß unterscheiden zu koennen.


INSERT INTO `_step01` (
    mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, dat, wrg, ean_kasse, menge,
    umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id, komponentenmengen_faktor,
    stueckliste_id
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.dat,
        A.wrg,
        CAST(A.ean_kasse AS INTEGER) AS ean_kasse,
        SUM(CAST(A.menge AS FLOAT64)) AS menge,
        SUM(CAST(A.umsatz_netto AS NUMERIC)) AS umsatz_netto_alt,
        SUM(CAST(A.umsatz_mwst_betrag AS NUMERIC)) AS umsatz_mwst_betrag_alt,
        SUM(CAST(A.umsatz_netto + A.umsatz_mwst_betrag AS NUMERIC)) AS umsatz_bto,
        CAST(B.umrechnungskurs AS FLOAT64) AS umrechnungskurs,
        -100 AS kopf_art_id,
        0 AS komponentenmengen_faktor,
        c.stueckliste_id
    FROM dbp_data.artbew AS A
    INNER JOIN dbp_etl.kmo_wpuums_dat AS D ON A.dat = D.dat
    INNER JOIN dbp_etl.kmo_wpuums_art_gp_wup_zu AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id
            AND A.nb_id = B.nb_id AND A.art_id = B.art_id AND A.dat = B.dat
    INNER JOIN (
        SELECT
            A0.mandant_id,
            A0.stueckliste_id,
            A0.dat_von,
            A0.dat_bis,
            A0.art_id,
            NULL AS wup_id,
            NULL AS nb_id,
            A0.stueckliste_verwendung_id
        FROM dbp_data.stueckliste AS A0
        INNER JOIN dbp_etl.kmo_wpuums_dat_min AS M ON A0.dat_bis >= M.dat
        WHERE -- a.wup_id IS NULL AND
            A0.stueckliste_verwendung_id = 3
            AND (
                A0.mandant_id, A0.art_id, A0.stueckliste_id) IN (
                SELECT (mandant_id, art_id, MAX(stueckliste_id))
                FROM dbp_data.stueckliste
                GROUP BY mandant_id,
                art_id
            )
    ) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id AND A.dat BETWEEN c.dat_von AND c.dat_bis
    WHERE
        A.mandant_id > 1
        AND A.menge <> 0
        AND A.umsatz_netto <> 0
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        A.dat,
        B.umrechnungskurs,
        A.bewart_id,
        A.bewart_det_id,
        c.stueckliste_id,
        A.wrg,
        A.ean_kasse
);


/*
_------------------------------------------------------------------------------
_ 14.) Anreicherung der Fueße um Umrechnungskurs von Kopf
_------------------------------------------------------------------------------
*/


UPDATE `_step01` AS `_step010` SET
    umrechnungskurs = t1.umrechnungskurs FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        bewart_id,
        bewart_det_id,
        dat,
        umrechnungskurs,
        stueckliste_id,
        ean_kasse
    FROM `_step01`
    WHERE kopf_art_id = -100
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        bewart_id,
        bewart_det_id,
        dat,
        ean_kasse,
        umrechnungskurs,
        stueckliste_id
) AS t1
WHERE
    `_step010`.mandant_id = t1.mandant_id AND `_step010`.wup_id = t1.wup_id AND `_step010`.nb_id = t1.nb_id AND
    `_step010`.kopf_art_id = t1.art_id AND `_step010`.dat = t1.dat AND `_step010`.stueckliste_id = t1.stueckliste_id
    AND `_step010`.ean_kasse = t1.ean_kasse AND `_step010`.bewart_id = t1.bewart_id AND `_step010`.bewart_det_id = t1.bewart_det_id AND `_step010`.kopf_art_id <> -100;


/*
_------------------------------------------------------------------------------
_ 15.) EK-Ermittlung
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Standardmaeßige EK-Ermittlung, die an dieser Stelle nur fuer die Fußartikel greift, da die VK-Set Kopfartikel
-- NICHT in der EK-Tabelle gefuehrt werden! Somit sind selbige nach diesem Step noch NULL!


INSERT INTO `_step02` (
    mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, dat, wrg, ean_kasse, menge,
    umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id, komponentenmengen_faktor,
    stueckliste_id, bq_findung_id, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
    logistikkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk, ek_mep_vor_fwu, bonusbasis
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.dat,
        A.wrg,
        A.ean_kasse,
        A.menge,
        A.umsatz_netto_alt,
        A.umsatz_mwst_betrag_alt,
        A.umsatz_bto,
        A.umrechnungskurs,
        A.kopf_art_id,
        A.komponentenmengen_faktor,
        A.stueckliste_id,
        X.bq_findung_id,
        CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_brutto, AGWW.ek_brutto) AS NUMERIC) AS ek_brutto_,
        CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_netto, AGWW.ek_netto) AS NUMERIC) AS ek_netto_,
        CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_nettonetto, AGWW.ek_nettonetto) AS NUMERIC) AS ek_nettonetto_,
        CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_kal_basis, AGWW.ek_kal_basis) AS NUMERIC) AS ek_kal_basis_,
        CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_mep, AGWW.ek_mep) AS NUMERIC) AS ek_mep_,
        CAST(A.komponentenmengen_faktor * COALESCE(AGW.einstandspreis, AGWW.einstandspreis) AS NUMERIC) AS einstandspreis_,
        CAST(A.komponentenmengen_faktor * COALESCE(AGW.logistikkostenzuschlag, AGWW.logistikkostenzuschlag, 0.0000) AS NUMERIC)
            AS logistikkostenzuschlag_,
        CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_netto_bnk, AGWW.ek_netto_bnk) AS NUMERIC) AS ek_netto_bnk_,
        CAST(
            A.komponentenmengen_faktor * COALESCE(AGW.ek_netto_bnk_sachk, AGWW.ek_netto_bnk_sachk) AS NUMERIC) AS
        ek_netto_bnk_sachk_,
        CAST(A.komponentenmengen_faktor * COALESCE(AGW.ek_mep_vor_fwu, AGWW.ek_mep_vor_fwu) AS NUMERIC) AS ek_mep_vor_fwu_,
        CAST(A.komponentenmengen_faktor * COALESCE(AGW.bonusbasis, AGWW.bonusbasis) AS NUMERIC) AS bonusbasis_
    FROM `_step01` AS A
    INNER JOIN dbp_data.art_gp_nm_zu_per AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND A.wup_id = X.wup_id AND A.dat BETWEEN X.dat_von AND X.dat_bis
    -- Ermittlung betriebsspezifischer ZEKP Satz mit VZ aus
    -- VZ Findung bei Bezugsweg 4 und Betrieb bei Bezugsweg 1

    LEFT JOIN dbp_etl.`__vol_art_gp_wup_zu_per` AS AGW
        ON
            A.mandant_id = AGW.mandant_id AND X.vz_wup_id =
            AGW.wup_id /* hier Zugriff mit Wup/VZ aus Kreisprozess !! */ AND X.nb_id = AGW.nb_id AND A.art_id = AGW.art_id
            AND X.gp_id = AGW.gp_id AND X.einkaufsorganisation_id = AGW.einkaufsorganisation_id AND A.dat = AGW.dat
    -- Betrieb = blank für Bezugsweg 1 und 4 beim ersten
    -- Zugriff nichts gefunden wird.

    LEFT JOIN
        dbp_etl.`__vol_art_gp_wup_zu_per`
            AS AGWW
        ON
            A.mandant_id = AGWW.mandant_id AND AGWW.wup_id =
            -1 /* Betrieb = 'blank' */ AND A.art_id = AGWW.art_id AND X.gp_id = AGWW.gp_id AND X.einkaufsorganisation_id =
            AGWW.einkaufsorganisation_id AND A.dat = AGWW.dat
);


/*
_------------------------------------------------------------------------------
_ 16.) Update fuer NULLs bei EK-Werten
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Im normalen Deltabetrieb eigentlich ein obsoleter Step. Allerdings können durch das Anziehen unserer neuen
-- BQ-Tabelle ART_GP_NM_ZU_PER, die erst ab Oktober regelmaeßig mitlief, Ungenauigkeiten beim Lieferanten fuer
-- historische Daten (z.B. auf Q fuer Initialbefuellung!) entstehen. Deswegen zur Sicherheit noch einmal ein
-- Update und das Setzen auf den UMSATZ_NETTO (Spanne 0%) fuer solche Faelle.


UPDATE `_step02` SET
    ek_brutto = `_step02`.umsatz_netto_alt,
    ek_netto = `_step02`.umsatz_netto_alt,
    ek_nettonetto = `_step02`.umsatz_netto_alt,
    ek_kal_basis = `_step02`.umsatz_netto_alt,
    ek_mep = `_step02`.umsatz_netto_alt,
    einstandspreis = `_step02`.umsatz_netto_alt,
    ek_netto_bnk = `_step02`.umsatz_netto_alt,
    ek_netto_bnk_sachk = `_step02`.umsatz_netto_alt,
    ek_mep_vor_fwu = `_step02`.umsatz_netto_alt,
    bonusbasis = `_step02`.umsatz_netto_alt
WHERE kopf_art_id <> -100 AND ek_brutto IS NULL;


/*
_------------------------------------------------------------------------------
_ 17.) Aufbau von zwei Hilfstabellen (Spannenermittlung)
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Zunaechst wird eine Tabelle mit Kopfinformationen bzgl. UMSATZ_NETTO erstellt.


INSERT INTO `_aggregat01` (mandant_id, art_id, bewart_id, bewart_det_id, wup_id, nb_id, dat, ean_kasse, umsatz_netto)
(SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    wup_id,
    nb_id,
    dat,
    ean_kasse,
    umsatz_netto_alt AS umsatz_netto
FROM `_step02` AS A
WHERE kopf_art_id = -100);


-- 18.12.2012, -dba-
--
-- Hier die ungleich wichtigere Tabelle! Da wir bei der Bestimmung der Umsatzanteile pro Komponente uns am
-- Verhaeltnis von EKN1 (Gesamt) zum EK-Wert eines Einzelartikels orientieren, wird hier in EK_NETTO_SUM 
-- der gesamte EKN1-Wert der Komponenten gespeichert.


INSERT INTO `_spannen_agg1` (
    mandant_id, wup_id, kopf_art_id, bewart_id, bewart_det_id, stueckliste_id, dat, ean_kasse,
    ek_netto_sum
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.kopf_art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.stueckliste_id,
        A.dat,
        A.ean_kasse,
        SUM(A.ek_netto) AS ek_netto_sum
    FROM `_step02` AS A
    INNER JOIN `_aggregat01` AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.kopf_art_id = B.art_id AND
            A.dat = B.dat AND A.ean_kasse = B.ean_kasse AND A.bewart_id = B.bewart_id AND A.bewart_det_id = B.bewart_det_id
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.kopf_art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.stueckliste_id,
        A.dat,
        A.ean_kasse
);


/*
_------------------------------------------------------------------------------
_ 18.) Umsatzverteilung von Kopf auf Komponenten
_------------------------------------------------------------------------------
*/


INSERT INTO `_step02a` (
    mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, dat, wrg, ean_kasse, menge,
    umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id, komponentenmengen_faktor,
    stueckliste_id, bq_findung_id, umsatz_anteil, umsatz_netto, umsatz_mwst, ek_brutto, ek_netto, ek_nettonetto,
    ek_kal_basis, ek_mep, einstandspreis, logistikkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk, ek_mep_vor_fwu,
    bonusbasis, diff_ek_brutto_konz, diff_ek_netto_konz, diff_ek_nettonetto_konz, diff_ek_kal_basis_konz, diff_ek_mep_konz,
    diff_einstandspreis_konz, diff_logkostenzuschlag_konz, diff_ek_netto_bnk_konz, diff_ek_netto_bnk_sachk_konz,
    ek_mep_vor_fwu_konz, bonusbasis_konz
)
(
    SELECT
        Z.mandant_id,
        Z.wup_id,
        Z.nb_id,
        Z.art_id,
        Z.bewart_id,
        Z.bewart_det_id,
        Z.dat,
        Z.wrg,
        Z.ean_kasse,
        Z.menge,
        Z.umsatz_netto_alt,
        Z.umsatz_mwst_betrag_alt,
        Z.umsatz_bto,
        Z.umrechnungskurs,
        Z.kopf_art_id,
        Z.komponentenmengen_faktor,
        Z.stueckliste_id,
        Z.bq_findung_id,
        CAST(CAST(Z.ek_netto AS BIGNUMERIC) / CAST(A.ek_netto_sum AS BIGNUMERIC) AS NUMERIC) AS umsatz_anteil_,
        CAST(
            Z.umsatz_netto_alt * (CAST(Z.ek_netto AS BIGNUMERIC) / CAST(A.ek_netto_sum AS BIGNUMERIC)) AS NUMERIC) AS
        umsatz_netto,
        CAST(
            Z.umsatz_mwst_betrag_alt * (CAST(Z.ek_netto AS BIGNUMERIC) / CAST(A.ek_netto_sum AS BIGNUMERIC)) AS NUMERIC) AS
        umsatz_mwst,
        Z.ek_brutto,
        Z.ek_netto,
        Z.ek_nettonetto,
        Z.ek_kal_basis,
        Z.ek_mep,
        Z.einstandspreis,
        Z.logistikkostenzuschlag,
        Z.ek_netto_bnk,
        Z.ek_netto_bnk_sachk,
        Z.ek_mep_vor_fwu,
        Z.bonusbasis,
        0 AS diff_ek_brutto_konz,
        0 AS diff_ek_netto_konz,
        0 AS diff_ek_nettonetto_konz,
        0 AS diff_ek_kal_basis_konz,
        0 AS diff_ek_mep_konz,
        0 AS diff_einstandspreis_konz,
        0 AS diff_logkostenzuschlag_konz,
        0 AS diff_ek_netto_bnk_konz,
        0 AS diff_ek_netto_bnk_sachk_konz,
        0 AS ek_mep_vor_fwu_konz,
        0 AS bonusbasis_konz
    FROM `_step02` AS Z
    INNER JOIN `_spannen_agg1` AS A
        ON
            Z.mandant_id = A.mandant_id AND Z.wup_id = A.wup_id AND Z.kopf_art_id = A.kopf_art_id
            AND Z.stueckliste_id = A.stueckliste_id AND Z.ean_kasse = A.ean_kasse AND Z.dat = A.dat AND Z.bewart_id = A.bewart_id
            AND Z.bewart_det_id = A.bewart_det_id
    WHERE A.ek_netto_sum <> 0
);


/*
_------------------------------------------------------------------------------
_ 19.) Manuelle Spannenpflege fuer Stuecklistenartikel
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Laut Konzept gilt die Regel: Manuelle Spannen stehen ueber der Stuecklistenaufloesung! Falls also fuer die
-- Komponentenartikel manuelle Spannen gepflegt sein sollten, wird das Ganze wieder ueberschrieben!!! Es obliegt 
-- somit dem Fachbereich, hier fuer eine adäquate Pflege der VK-Set Artikel zu sorgen, da ansonsten das Prozedere 
-- obsolet waere!

-- manuelle Spanne ohne Betriebsbezug


UPDATE `_step02a` SET
    ek_brutto = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_netto = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_nettonetto = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_kal_basis = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_mep = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    einstandspreis = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgs AS NUMERIC), 4),
    ek_netto_bnk = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_netto_bnk_sachk = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_mep_vor_fwu = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    bonusbasis = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4) FROM (
    SELECT
        EIN.mandant_id,
        EIN.art_id,
        A.dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.kmo_wpuums_dat AS A
    INNER JOIN dbp_data.art_man_spanne_per AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' /* einstandspreis */
            AND EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_man_spanne_per AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.art_id = MEP.art_id
            AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat BETWEEN MEP.dat_von AND MEP.dat_bis

    LEFT JOIN
        dbp_data.art_man_spanne_per
            AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.art_id =
            EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg = 0 AND A.dat BETWEEN
            EKBNK.dat_von AND EKBNK.dat_bis
) AS ms
WHERE
    `_step02a`.mandant_id = ms.mandant_id AND `_step02a`.art_id = ms.art_id AND `_step02a`.dat = ms.dat AND `_step02a`
    .bq_findung_id = 27 AND `_step02a`.kopf_art_id <> -100;


-- Hier die betriebsspezifischen manuellen Spannenfaktoren


UPDATE `_step02a` SET
    ek_brutto = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_netto = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_nettonetto = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_kal_basis = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_mep = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    einstandspreis = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgs AS NUMERIC), 4),
    ek_netto_bnk = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_netto_bnk_sachk = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_mep_vor_fwu = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    bonusbasis = ROUND(CAST(`_step02a`.umsatz_netto * ms.zwgm AS NUMERIC), 4) FROM (
    SELECT
        EIN.mandant_id,
        EIN.wup_id,
        EIN.art_id,
        A.dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.kmo_wpuums_dat AS A
    INNER JOIN dbp_data.art_wup_man_spanne_per AS EIN
        ON EIN.konditionsart_id = 'ZWGS'
        /* einstandspreis */ AND EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_wup_man_spanne_per AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.wup_id =
            MEP.wup_id AND EIN.art_id = MEP.art_id AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN
        dbp_data.art_wup_man_spanne_per
            AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.wup_id
            = EKBNK.wup_id AND EIN.art_id = EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg
            = 0 AND A.dat BETWEEN EKBNK.dat_von AND EKBNK.dat_bis
) AS ms
WHERE
    `_step02a`.mandant_id = ms.mandant_id AND `_step02a`.wup_id = ms.wup_id AND `_step02a`.art_id = ms.art_id AND
    `_step02a`.dat = ms.dat AND `_step02a`.bq_findung_id = 26 AND `_step02a`.kopf_art_id <> -100;


-- Bei nicht erfolgreicher BQ-Findung setzen wir die 0% Spanne, also UMSATZ_NETTO!


UPDATE `_step02a` SET
    umsatz_anteil = 0,
    umsatz_netto = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC),
    umsatz_mwst = CAST(`_step02a`.umsatz_mwst_betrag_alt AS NUMERIC),
    umsatz_bto = CAST(`_step02a`.umsatz_netto_alt + `_step02a`.umsatz_mwst_betrag_alt AS NUMERIC),
    ek_brutto = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC),
    ek_netto = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC),
    ek_nettonetto = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC),
    ek_kal_basis = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC),
    ek_mep = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC),
    einstandspreis = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC),
    ek_netto_bnk = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC),
    ek_netto_bnk_sachk = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC),
    ek_mep_vor_fwu = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC),
    bonusbasis = CAST(`_step02a`.umsatz_netto_alt AS NUMERIC)
WHERE bq_findung_id = 25 AND kopf_art_id <> -100;


/*
_------------------------------------------------------------------------------
_ 20.) Spannen-EK-Bewertung pro Komponente
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Des Weiteren werden fuer die einzelnen Konditionsstufen die zugrunde liegende Spanne im Verhaeltnis zum 
-- Gesamtabverkauf (UMSATZ_NETTO ermittelt. Mit diesen Spannen werden spaeter die EK-Werte fuer die Kom-
-- ponentenartikel festgeschrieben.


CREATE OR REPLACE TEMPORARY TABLE _spannen_agg2 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.kopf_art_id,
    A.bewart_id,
    A.bewart_det_id,
    A.ean_kasse,
    A.stueckliste_id,
    A.dat,
    1 - SUM(A.ek_brutto / B.umsatz_netto) AS ek_brutto_spn,
    1 - SUM(A.ek_netto / B.umsatz_netto) AS ek_netto_spn,
    1 - SUM(A.ek_nettonetto / B.umsatz_netto) AS ek_nettonetto_spn,
    1 - SUM(A.ek_kal_basis / B.umsatz_netto) AS ek_kal_basis_spn,
    1 - SUM(A.ek_mep / B.umsatz_netto) AS ek_mep_spn,
    1 - SUM(A.einstandspreis / B.umsatz_netto) AS einstandspreis_spn,
    1 - SUM(A.logistikkostenzuschlag / B.umsatz_netto) AS logkostenzuschlag_spn,
    1 - SUM(A.ek_netto_bnk / B.umsatz_netto) AS ek_netto_bnk_spn,
    1 - SUM(A.ek_netto_bnk_sachk / B.umsatz_netto) AS ek_netto_bnk_sachk_spn,
    1 - SUM(A.ek_mep_vor_fwu / B.umsatz_netto) AS ek_mep_vor_fwu_spn,
    1 - SUM(A.bonusbasis / B.umsatz_netto) AS bonusbasis_spn
FROM `_step02a` AS A
INNER JOIN `_aggregat01` AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.kopf_art_id = B.art_id AND A.dat = B.dat AND A.ean_kasse = B.ean_kasse AND A.bewart_id = B.bewart_id AND A.bewart_det_id = B.bewart_det_id
WHERE B.umsatz_netto <> 0
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.kopf_art_id,
    A.bewart_id,
    A.bewart_det_id,
    A.ean_kasse,
    A.stueckliste_id,
    A.dat;


-- 18.12.2012, -dba-
--
-- Wie dem obigen Titel zu entnehmen ist, werden hier fuer saemtliche Komponenten eines VK-Set die entsprechenden
-- Werte ermittelt. Als Anmerkung waere hier noch zu erwaehnen, dass aufgrund von Rundungsungenauigkeiten im Teradata-
-- Umfeld bei der EK-Berechnung laut Spanne leider die Genauigkeit von NUMBER(29,4) auf NUMBER(29,2) gesetzt werden
-- musste, da wir ansonsten kein stimmiges Verhaeltnis der EK-Werte im Vergleich von vorher zu nachher gehabt haetten.


INSERT INTO `_step03` (
    mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, dat, wrg, ean_kasse, menge,
    umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id, komponentenmengen_faktor,
    stueckliste_id, bq_findung_id, umsatz_anteil, umsatz_netto, umsatz_mwst, ek_brutto, ek_netto, ek_nettonetto,
    ek_kal_basis, ek_mep, einstandspreis, logistikkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk, ek_mep_vor_fwu,
    bonusbasis, diff_ek_brutto_konz, diff_ek_netto_konz, diff_ek_nettonetto_konz, diff_ek_kal_basis_konz, diff_ek_mep_konz,
    diff_einstandspreis_konz, diff_logkostenzuschlag_konz, diff_ek_netto_bnk_konz, diff_ek_netto_bnk_sachk_konz,
    ek_mep_vor_fwu_konz, bonusbasis_konz
)
(
    SELECT
        Z.mandant_id,
        Z.wup_id,
        Z.nb_id,
        Z.art_id,
        Z.bewart_id,
        Z.bewart_det_id,
        Z.dat,
        Z.wrg,
        Z.ean_kasse,
        Z.menge,
        Z.umsatz_netto_alt,
        Z.umsatz_mwst_betrag_alt,
        Z.umsatz_bto,
        Z.umrechnungskurs,
        Z.kopf_art_id,
        Z.komponentenmengen_faktor,
        Z.stueckliste_id,
        Z.bq_findung_id,
        Z.umsatz_anteil,
        Z.umsatz_netto,
        Z.umsatz_mwst,
        CAST(-1 * (A.ek_brutto_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2)) AS NUMERIC)
            AS ek_brutto_,
        CAST(
            -1 * (A.ek_netto_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2)) AS
            NUMERIC
        ) AS ek_netto_,
        CAST(-1 * (
            A.ek_nettonetto_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2
            )
        ) AS NUMERIC) AS ek_nettonetto_,
        CAST(-1 * (
            A.ek_kal_basis_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2
            )
        ) AS NUMERIC) AS ek_kal_basis_,
        CAST(
            -1 * (A.ek_mep_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2)) AS
            NUMERIC
        ) AS ek_mep_,
        CAST(-1 * (A.einstandspreis_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) AS NUMERIC) AS einstandspreis_,
        CAST(-1 * (A.logkostenzuschlag_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) AS NUMERIC) AS logistikkostenzuschlag_,
        CAST(-1 * (
            A.ek_netto_bnk_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2
            )
        ) AS NUMERIC) AS ek_netto_bnk_,
        CAST(-1 * (A.ek_netto_bnk_sachk_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) AS NUMERIC) AS ek_netto_bnk_sachk_,
        CAST(-1 * (A.ek_mep_vor_fwu_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) AS NUMERIC) AS ek_mep_vor_fwu_,
        CAST(
            -1 * (A.bonusbasis_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2))
            AS NUMERIC
        ) AS bonusbasis_,
        ROUND(CAST(-1 * (A.ek_brutto_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_brutto_konz,
        ROUND(CAST(-1 * (A.ek_netto_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_netto_konz,
        ROUND(CAST(-1 * (A.ek_nettonetto_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_nettonetto_konz,
        ROUND(CAST(-1 * (A.ek_kal_basis_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_kal_basis_konz,
        ROUND(CAST(-1 * (
            A.ek_mep_spn * ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(CAST(Z.umsatz_netto AS NUMERIC), 2
            )
        ) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_mep_konz,
        ROUND(CAST(-1 * (A.einstandspreis_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_einstandspreis_konz,
        ROUND(CAST(-1 * (A.logkostenzuschlag_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_logkostenzuschlag_konz,
        ROUND(CAST(-1 * (A.ek_netto_bnk_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_netto_bnk_konz,
        ROUND(CAST(-1 * (A.ek_netto_bnk_sachk_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) * Z.umrechnungskurs AS NUMERIC), 4) AS diff_ek_netto_bnk_sachk_konz,
        ROUND(CAST(-1 * (A.ek_mep_vor_fwu_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) * Z.umrechnungskurs AS NUMERIC), 4) AS ek_mep_vor_fwu_konz,
        ROUND(CAST(-1 * (A.bonusbasis_spn * ROUND(
            CAST(Z.umsatz_netto AS NUMERIC), 2) - ROUND(
            CAST(Z.umsatz_netto AS NUMERIC),
            2
        )) * Z.umrechnungskurs AS NUMERIC), 4) AS bonusbasis_konz
    FROM `_step02a` AS Z
    INNER JOIN
        `_spannen_agg2`
            AS A
        ON
            Z.mandant_id = A.mandant_id AND Z.wup_id = A.wup_id AND Z.kopf_art_id = A.kopf_art_id
            AND Z.stueckliste_id = A.stueckliste_id AND Z.ean_kasse = A.ean_kasse AND Z.dat = A.dat AND Z.bewart_id = A.bewart_id
            AND Z.bewart_det_id = A.bewart_det_id
);


/*
_------------------------------------------------------------------------------
_ 21.) Spannen-EK-Bewertung pro Kopfartikel (ARTBEW-Bezug)
_------------------------------------------------------------------------------
*/


INSERT INTO `_step03` (
    mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, dat, wrg, ean_kasse, menge,
    umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id, komponentenmengen_faktor,
    stueckliste_id, bq_findung_id, umsatz_anteil, umsatz_netto, umsatz_mwst, ek_brutto, ek_netto, ek_nettonetto,
    ek_kal_basis, ek_mep, einstandspreis, logistikkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk, ek_mep_vor_fwu,
    bonusbasis, diff_ek_brutto_konz, diff_ek_netto_konz, diff_ek_nettonetto_konz, diff_ek_kal_basis_konz, diff_ek_mep_konz,
    diff_einstandspreis_konz, diff_logkostenzuschlag_konz, diff_ek_netto_bnk_konz, diff_ek_netto_bnk_sachk_konz,
    ek_mep_vor_fwu_konz, bonusbasis_konz
)
(
    SELECT
        Z.mandant_id,
        Z.wup_id,
        Z.nb_id,
        Z.art_id,
        Z.bewart_id,
        Z.bewart_det_id,
        Z.dat,
        Z.wrg,
        Z.ean_kasse,
        Z.menge,
        Z.umsatz_netto_alt,
        Z.umsatz_mwst_betrag_alt,
        Z.umsatz_bto,
        Z.umrechnungskurs,
        Z.kopf_art_id,
        Z.komponentenmengen_faktor,
        Z.stueckliste_id,
        Z.bq_findung_id,
        0 AS umsatz_anteil,
        Z.umsatz_netto_alt AS umsatz_netto,
        Z.umsatz_mwst_betrag_alt AS umsatz_mwst,
        CAST((1 - A.ek_brutto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_brutto_,
        CAST((1 - A.ek_netto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_netto_,
        CAST((1 - A.ek_nettonetto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_nettonetto_,
        CAST((1 - A.ek_kal_basis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_kal_basis_,
        CAST((1 - A.ek_mep_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_mep_,
        CAST((1 - A.einstandspreis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS einstandspreis_,
        CAST(
            (1 - A.logkostenzuschlag_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS
        logistikkostenzuschlag_,
        CAST((1 - A.ek_netto_bnk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_netto_bnk_,
        CAST((1 - A.ek_netto_bnk_sachk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_netto_bnk_sachk_
        ,
        CAST((1 - A.ek_mep_vor_fwu_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_mep_vor_fwu_,
        CAST((1 - A.bonusbasis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS bonusbasis_,
        ROUND(CAST((1 - A.ek_brutto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4)
            AS diff_ek_brutto_konz,
        ROUND(
            CAST((1 - A.ek_netto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4) AS
        diff_ek_netto_konz,
        ROUND(
            CAST((1 - A.ek_nettonetto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC),
            4
        ) AS diff_ek_nettonetto_konz,
        ROUND(CAST((1 - A.ek_kal_basis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4
        ) AS diff_ek_kal_basis_konz,
        ROUND(
            CAST((1 - A.ek_mep_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4) AS
        diff_ek_mep_konz,
        ROUND(
            CAST((1 - A.einstandspreis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC),
            4
        ) AS diff_einstandspreis_konz,
        ROUND(CAST(
            (1 - A.logkostenzuschlag_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS
            NUMERIC
        ), 4) AS diff_logkostenzuschlag_konz,
        ROUND(CAST((1 - A.ek_netto_bnk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4
        ) AS diff_ek_netto_bnk_konz,
        ROUND(CAST(
            (1 - A.ek_netto_bnk_sachk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS
            NUMERIC
        ), 4) AS diff_ek_netto_bnk_sachk_konz,
        ROUND(
            CAST((1 - A.ek_mep_vor_fwu_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC),
            4
        ) AS ek_mep_vor_fwu_konz,
        ROUND(CAST((1 - A.bonusbasis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4)
            AS bonusbasis_konz
    FROM `_step02` AS Z
    INNER JOIN `_spannen_agg2` AS A
        ON
            Z.mandant_id = A.mandant_id AND Z.wup_id = A.wup_id AND Z.art_id = A.kopf_art_id
            AND Z.stueckliste_id = A.stueckliste_id AND Z.ean_kasse = A.ean_kasse AND Z.dat = A.dat AND Z.bewart_id = A.bewart_id
            AND Z.bewart_det_id = A.bewart_det_id
    WHERE Z.kopf_art_id = -100
);


/*
_------------------------------------------------------------------------------
_ 22.) Aktualisierung der EK-Werte fuer Kopfartikel in ARTBEW
_------------------------------------------------------------------------------
*/


MERGE INTO dbp_data.artbew AS A
USING (
    SELECT *
    FROM `_step03`
    WHERE kopf_art_id = -100
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.art_id = b.art_id AND A.ean_kasse = b.ean_kasse AND A.dat = b.dat AND A.bewart_id = b.bewart_id AND A.bewart_det_id = b.bewart_det_id
WHEN MATCHED THEN UPDATE SET
    ek_brutto = b.ek_brutto,
    diff_ek_brutto_konz = b.diff_ek_brutto_konz,
    ek_netto = b.ek_netto,
    diff_ek_netto_konz = b.diff_ek_netto_konz,
    ek_nettonetto = b.ek_nettonetto,
    diff_ek_nettonetto_konz = b.diff_ek_nettonetto_konz,
    ek_kal_basis = b.ek_kal_basis,
    diff_ek_kal_basis_konz = b.diff_ek_kal_basis_konz,
    ek_mep = b.ek_mep,
    diff_ek_mep_konz = b.diff_ek_mep_konz,
    einstandspreis = b.einstandspreis,
    diff_einstandspreis_konz = b.diff_einstandspreis_konz,
    logkostenzuschlag = b.logistikkostenzuschlag,
    diff_logkostenzuschlag_konz = b.diff_logkostenzuschlag_konz,
    ek_netto_bnk = b.ek_netto_bnk,
    diff_ek_netto_bnk_konz = b.diff_ek_netto_bnk_konz,
    ek_netto_bnk_sachk = b.ek_netto_bnk_sachk,
    diff_ek_netto_bnk_sachk_konz = b.diff_ek_netto_bnk_sachk_konz,
    ek_mep_vor_fwu = b.ek_mep_vor_fwu,
    ek_mep_vor_fwu_konz = b.ek_mep_vor_fwu_konz,
    bonusbasis = b.bonusbasis,
    bonusbasis_konz = b.bonusbasis_konz,
    bq_findung_id = 28;


/*
_------------------------------------------------------------------------------
_ 23.) Einspielen der Komponentenartikel in Zieltabelle
_------------------------------------------------------------------------------
*/


DELETE FROM dbp_data.artbew_stueckliste_zu
WHERE mandant_id > 1 AND dat IN (
    SELECT dat
    FROM dbp_etl.kmo_wpuums_dat
);


INSERT INTO dbp_data.artbew_stueckliste_zu (
    art_id, mandant_id, wup_id, nb_id, dat, komponente_art_id,
    stueckliste_id, wrg_id, umsatz_netto, umsatz_mwst_betrag, menge, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis,
    ek_mep, ek_mep_vor_fwu, einstandspreis, logkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk, bq_findung_id,
    umrechnungskurs, bonusbasis, td_update, td_insert
)
(
    SELECT
        kopf_art_id AS art_id,
        mandant_id,
        wup_id,
        nb_id,
        dat,
        art_id AS komponente_art_id,
        stueckliste_id,
        wrg AS wrg_id,
        SUM(umsatz_netto) AS umsatz_netto,
        SUM(umsatz_mwst) AS umsatz_mwst_betrag,
        SUM(komponentenmengen_faktor) AS menge,
        SUM(ek_brutto) AS ek_brutto,
        SUM(ek_netto) AS ek_netto,
        SUM(ek_nettonetto) AS ek_nettonetto,
        SUM(ek_kal_basis) AS ek_kal_basis,
        SUM(ek_mep) AS ek_mep,
        SUM(ek_mep_vor_fwu) AS ek_mep_vor_fwu,
        SUM(einstandspreis) AS einstandspreis,
        SUM(logistikkostenzuschlag) AS logkostenzuschlag,
        SUM(ek_netto_bnk) AS ek_netto_bnk,
        SUM(ek_netto_bnk_sachk) AS ek_netto_bnk_sachk,
        bq_findung_id,
        ROUND(CAST(MAX(umrechnungskurs) AS NUMERIC), 5) AS umrechnungskurs,
        SUM(bonusbasis) AS bonusbasis,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM `_step03`
    WHERE kopf_art_id <> -100
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        komponente_art_id,
        dat,
        wrg,
        kopf_art_id,
        stueckliste_id,
        bq_findung_id
);
