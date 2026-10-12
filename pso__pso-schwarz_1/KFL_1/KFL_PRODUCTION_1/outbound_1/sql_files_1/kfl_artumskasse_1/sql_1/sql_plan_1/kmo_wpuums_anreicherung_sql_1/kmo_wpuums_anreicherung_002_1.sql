CREATE OR REPLACE TEMPORARY TABLE _step01_1 (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    promo_fg INTEGER,
    dat DATE,
    wrg_1 STRING(3),
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


CREATE OR REPLACE TEMPORARY TABLE _step02_1 (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    promo_fg INTEGER,
    dat DATE,
    wrg_1 STRING(3),
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


CREATE OR REPLACE TEMPORARY TABLE _step02a_1 (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    promo_fg INTEGER,
    dat DATE,
    wrg_1 STRING(3),
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


CREATE OR REPLACE TEMPORARY TABLE _step03_1 (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    promo_fg INTEGER,
    dat DATE,
    wrg_1 STRING(3),
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


CREATE OR REPLACE TEMPORARY TABLE _aggregat01_1 (
    mandant_id INTEGER,
    art_id INTEGER,
    bewart_id INTEGER,
    bewart_det_id INTEGER,
    promo_fg INTEGER,
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
    promo_fg INTEGER,
    stueckliste_id INTEGER,
    dat DATE,
    ean_kasse INTEGER,
    ek_netto_sum NUMERIC(29, 4)
);


/*
_------------------------------------------------------------------------------
_ 12.) Stuecklistenaufloesung aus ARTBEW_1 in volatile Tabelle (Fueße)
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Aus der ARTBEW_1 werden zunaechst fuer die relevanten Tage alle betroffenen Kopfartikel ermittelt. Ueber den
-- nachgelagerten JOIN gegen die Komponententabelle STUECKLISTE_DET_1 werden dann die zugehoerigen Fußartikel_1 mit
-- der auf Basismengeneinheit geeichten Menge in die Zwischentabelle STEP01 eingespielt.


-- falls eine_1 Komponente mehrfach in der Stueckliste_1 vorhanden ist: Menge aufsummieren
INSERT INTO `_step01_1` (
    mandant_id,
    wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, dat, wrg_1, ean_kasse, menge, umsatz_netto_alt,
    umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id, komponentenmengen_faktor, stueckliste_id
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        b.art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.promo_fg,
        A.dat,
        A.wrg_1,
        A.ean_kasse AS ean_kasse,
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
    FROM dbp_data.artbew_1 AS A
    INNER JOIN dbp_etl.kmo_wpuums_dat_1 AS D ON A.dat = D.dat
    INNER JOIN dbp_etl.kmo_wpuums_art_gp_wup_zu_1 AS Z
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
        FROM dbp_data.stueckliste_1 AS A0
        INNER JOIN dbp_etl.kmo_wpuums_dat_min_1 AS M ON A0.dat_bis >= M.dat
        WHERE -- a.wup_id IS NULL AND
            A0.stueckliste_verwendung_id = 3
            AND (
                A0.mandant_id, A0.art_id, A0.stueckliste_id) IN (
                SELECT (mandant_id, art_id, MAX(stueckliste_id))
                FROM dbp_data.stueckliste_1
                GROUP BY mandant_id,
                art_id
            )
    ) AS k ON A.mandant_id = k.mandant_id AND A.art_id = k.art_id AND A.dat BETWEEN k.dat_von AND k.dat_bis
    -- Ermittlung Fußartikel_1

    INNER JOIN (
        SELECT *
        FROM dbp_data.stueckliste_det_1
        WHERE stueckliste_typ_id = 'M'
    ) AS b
        ON
            k.mandant_id = b.mandant_id AND k.stueckliste_id = b.stueckliste_id AND A.dat
            BETWEEN b.dat_von AND b.dat_bis
    -- Ermittlung Umrechnungsfaktor, damit korrekter Bezug zur Basismengeneinheit hergestellt wird.

    LEFT JOIN dbp_data.art_umrechnung_faktor_per_1 AS C
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
        A.wrg_1,
        A.ean_kasse,
        A.promo_fg
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


INSERT INTO `_step01_1` (
    mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, dat, wrg_1, ean_kasse, menge,
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
        A.promo_fg,
        A.dat,
        A.wrg_1,
        A.ean_kasse AS ean_kasse,
        SUM(CAST(A.menge AS FLOAT64)) AS menge,
        SUM(CAST(A.umsatz_netto AS NUMERIC)) AS umsatz_netto_alt,
        SUM(CAST(A.umsatz_mwst_betrag AS NUMERIC)) AS umsatz_mwst_betrag_alt,
        SUM(CAST(A.umsatz_netto + A.umsatz_mwst_betrag AS NUMERIC)) AS umsatz_bto,
        CAST(B.umrechnungskurs AS FLOAT64) AS umrechnungskurs,
        -100 AS kopf_art_id,
        0 AS komponentenmengen_faktor,
        c.stueckliste_id
    FROM dbp_data.artbew_1 AS A
    INNER JOIN dbp_etl.kmo_wpuums_dat_1 AS D ON A.dat = D.dat
    INNER JOIN dbp_etl.kmo_wpuums_art_gp_wup_zu_1 AS B
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
        FROM dbp_data.stueckliste_1 AS A0
        INNER JOIN dbp_etl.kmo_wpuums_dat_min_1 AS M ON A0.dat_bis >= M.dat
        WHERE -- a.wup_id IS NULL AND
            A0.stueckliste_verwendung_id = 3
            AND (
                A0.mandant_id, A0.art_id, A0.stueckliste_id) IN (
                SELECT (mandant_id, art_id, MAX(stueckliste_id))
                FROM dbp_data.stueckliste_1
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
        A.wrg_1,
        A.ean_kasse,
        A.promo_fg
);


/*
_------------------------------------------------------------------------------
_ 14.) Anreicherung der Fueße um Umrechnungskurs von Kopf
_------------------------------------------------------------------------------
*/


UPDATE `_step01_1` AS `_step010` SET
    umrechnungskurs = t1.umrechnungskurs FROM (
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        bewart_id,
        bewart_det_id,
        promo_fg,
        dat,
        umrechnungskurs,
        stueckliste_id,
        ean_kasse
    FROM `_step01_1`
    WHERE kopf_art_id = -100
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        bewart_id,
        bewart_det_id,
        promo_fg,
        dat,
        ean_kasse,
        umrechnungskurs,
        stueckliste_id
) AS t1_1
WHERE
    `_step010`.mandant_id = t1.mandant_id AND `_step010`.wup_id = t1.wup_id AND `_step010`.nb_id = t1.nb_id AND
    `_step010`.kopf_art_id = t1.art_id AND `_step010`.dat = t1.dat AND `_step010`.stueckliste_id = t1.stueckliste_id
    AND `_step010`.ean_kasse = t1.ean_kasse AND `_step010`.bewart_id = t1.bewart_id AND `_step010`.bewart_det_id =
    t1.bewart_det_id AND `_step010`.promo_fg = t1.promo_fg AND `_step010`.kopf_art_id <> -100;


/*
_------------------------------------------------------------------------------
_ 15.) EK-Ermittlung
_------------------------------------------------------------------------------
*/


INSERT INTO `_step02_1` (
    mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, dat, wrg_1, ean_kasse, menge,
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
        A.promo_fg,
        A.dat,
        A.wrg_1,
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
    FROM `_step01_1` AS A
    INNER JOIN dbp_data.art_gp_nm_zu_per_1 AS X
        ON
            A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND A.wup_id = X.wup_id AND A.dat BETWEEN X.dat_von AND X.dat_bis
    -- Ermittlung betriebsspezifischer ZEKP_1 Satz mit VZ aus
    -- VZ Findung bei Bezugsweg 4 und Betrieb bei Bezugsweg 1

    LEFT JOIN dbp_etl.`__vol_art_gp_wup_zu_per` AS AGW
        ON
            A.mandant_id = AGW.mandant_id AND X.vz_wup_id =
            AGW.wup_id /* hier Zugriff mit Wup_1/VZ aus Kreisprozess !! */ AND X.nb_id = AGW.nb_id AND A.art_id = AGW.art_id
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
-- BQ-Tabelle ART_GP_NM_ZU_PER_1, die erst ab Oktober regelmaeßig mitlief, Ungenauigkeiten beim Lieferanten fuer
-- historische Daten (z.B. auf Q fuer Initialbefuellung!) entstehen. Deswegen zur Sicherheit noch einmal ein
-- Update und das Setzen auf den UMSATZ_NETTO (Spanne 0%) fuer solche Faelle.


UPDATE `_step02_1` SET
    ek_brutto = `_step02_1`.umsatz_netto_alt,
    ek_netto = `_step02_1`.umsatz_netto_alt,
    ek_nettonetto = `_step02_1`.umsatz_netto_alt,
    ek_kal_basis = `_step02_1`.umsatz_netto_alt,
    ek_mep = `_step02_1`.umsatz_netto_alt,
    einstandspreis = `_step02_1`.umsatz_netto_alt,
    ek_netto_bnk = `_step02_1`.umsatz_netto_alt,
    ek_netto_bnk_sachk = `_step02_1`.umsatz_netto_alt,
    ek_mep_vor_fwu = `_step02_1`.umsatz_netto_alt,
    bonusbasis = `_step02_1`.umsatz_netto_alt
WHERE kopf_art_id <> -100 AND ek_brutto IS NULL;


/*
_------------------------------------------------------------------------------
_ 17.) Aufbau von zwei Hilfstabellen (Spannenermittlung)
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Zunaechst wird eine_1 Tabelle mit Kopfinformationen bzgl. UMSATZ_NETTO erstellt.


INSERT INTO `_aggregat01_1` (
    mandant_id, art_id, bewart_id, bewart_det_id, promo_fg, wup_id, nb_id, dat, ean_kasse,
    umsatz_netto
)
(SELECT
    mandant_id,
    art_id,
    bewart_id,
    bewart_det_id,
    promo_fg,
    wup_id,
    nb_id,
    dat,
    ean_kasse,
    umsatz_netto_alt AS umsatz_netto
FROM `_step02_1` AS A
WHERE kopf_art_id = -100);


-- 18.12.2012, -dba-
--
-- Hier die ungleich wichtigere Tabelle! Da wir bei der Bestimmung der Umsatzanteile pro Komponente uns am
-- Verhaeltnis von EKN1 (Gesamt) zum EK-Wert eines Einzelartikels orientieren, wird hier in EK_NETTO_SUM 
-- der gesamte EKN1-Wert der Komponenten gespeichert.


INSERT INTO `_spannen_agg1` (
    mandant_id, wup_id, kopf_art_id, bewart_id, bewart_det_id, promo_fg, stueckliste_id, dat,
    ean_kasse, ek_netto_sum
)
(
    SELECT
        A.mandant_id,
        A.wup_id,
        A.kopf_art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.promo_fg,
        A.stueckliste_id,
        A.dat,
        A.ean_kasse,
        SUM(A.ek_netto) AS ek_netto_sum
    FROM `_step02_1` AS A
    INNER JOIN `_aggregat01_1` AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.kopf_art_id = B.art_id AND
            A.dat = B.dat AND A.ean_kasse = B.ean_kasse AND A.bewart_id = B.bewart_id AND A.bewart_det_id = B.bewart_det_id
            AND A.promo_fg = B.promo_fg
    GROUP BY
        A.mandant_id,
        A.wup_id,
        A.kopf_art_id,
        A.bewart_id,
        A.bewart_det_id,
        A.promo_fg,
        A.stueckliste_id,
        A.dat,
        A.ean_kasse
);


/*
_------------------------------------------------------------------------------
_ 18.) Umsatzverteilung von Kopf auf Komponenten
_------------------------------------------------------------------------------
*/


INSERT INTO `_step02a_1` (
    mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, dat, wrg_1, ean_kasse,
    menge, umsatz_netto_alt, umsatz_mwst_betrag_alt, umsatz_bto, umrechnungskurs, kopf_art_id, komponentenmengen_faktor,
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
        Z.promo_fg,
        Z.dat,
        Z.wrg_1,
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
        CAST(CAST(Z.ek_netto / A.ek_netto_sum AS BIGNUMERIC) AS NUMERIC) AS umsatz_anteil_,
        ROUND(CAST(Z.umsatz_netto_alt * CAST(Z.ek_netto / A.ek_netto_sum AS BIGNUMERIC) AS NUMERIC), 4) AS umsatz_netto,
        ROUND(CAST(Z.umsatz_mwst_betrag_alt * CAST(Z.ek_netto / A.ek_netto_sum AS BIGNUMERIC) AS NUMERIC), 4) AS umsatz_mwst,
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
    FROM `_step02_1` AS Z
    INNER JOIN `_spannen_agg1` AS A ON Z.mandant_id = A.mandant_id AND Z.wup_id = A.wup_id AND Z.kopf_art_id = A.kopf_art_id AND Z.stueckliste_id = A.stueckliste_id AND Z.ean_kasse = A.ean_kasse AND Z.dat = A.dat AND Z.bewart_id = A.bewart_id AND Z.bewart_det_id = A.bewart_det_id AND Z.promo_fg = A.promo_fg

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
-- somit dem Fachbereich, hier fuer eine_1 adäquate Pflege der VK_1-Set Artikel_1 zu sorgen, da ansonsten das Prozedere 
-- obsolet waere!

-- manuelle Spanne ohne Betriebsbezug


UPDATE `_step02a_1` SET
    ek_brutto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_netto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_nettonetto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_kal_basis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_mep = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    einstandspreis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgs AS NUMERIC), 4),
    ek_netto_bnk = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_netto_bnk_sachk = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_mep_vor_fwu = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4) FROM (
    SELECT
        EIN.mandant_id,
        EIN.art_id,
        A.dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.kmo_wpuums_dat_1 AS A
    INNER JOIN dbp_data.art_man_spanne_per_1 AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' /* einstandspreis */
            AND EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_man_spanne_per_1 AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.art_id = MEP.art_id
            AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat BETWEEN MEP.dat_von AND MEP.dat_bis

    LEFT JOIN
        dbp_data.art_man_spanne_per_1
            AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.art_id =
            EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg = 0 AND A.dat BETWEEN
            EKBNK.dat_von AND EKBNK.dat_bis
) AS ms
WHERE
    `_step02a_1`.mandant_id = ms.mandant_id AND `_step02a_1`.art_id = ms.art_id AND `_step02a_1`.dat = ms.dat AND `_step02a_1`
    .bq_findung_id = 27 AND `_step02a_1`.kopf_art_id <> -100;


-- Hier die betriebsspezifischen manuellen Spannenfaktoren


UPDATE `_step02a_1` SET
    ek_brutto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_netto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_nettonetto = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_kal_basis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_mep = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    einstandspreis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgs AS NUMERIC), 4),
    ek_netto_bnk = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwge AS NUMERIC), 4),
    ek_netto_bnk_sachk = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    ek_mep_vor_fwu = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4),
    bonusbasis = ROUND(CAST(`_step02a_1`.umsatz_netto * ms.zwgm AS NUMERIC), 4) FROM (
    SELECT
        EIN.mandant_id,
        EIN.wup_id,
        EIN.art_id,
        A.dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.kmo_wpuums_dat_1 AS A
    INNER JOIN dbp_data.art_wup_man_spanne_per_1 AS EIN
        ON EIN.konditionsart_id = 'ZWGS'
        /* einstandspreis */ AND EIN.loesch_fg = 0 AND A.dat BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_wup_man_spanne_per_1 AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.wup_id =
            MEP.wup_id AND EIN.art_id = MEP.art_id AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN
        dbp_data.art_wup_man_spanne_per_1
            AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.wup_id
            = EKBNK.wup_id AND EIN.art_id = EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg
            = 0 AND A.dat BETWEEN EKBNK.dat_von AND EKBNK.dat_bis
) AS ms
WHERE
    `_step02a_1`.mandant_id = ms.mandant_id AND `_step02a_1`.wup_id = ms.wup_id AND `_step02a_1`.art_id = ms.art_id AND
    `_step02a_1`.dat = ms.dat AND `_step02a_1`.bq_findung_id = 26 AND `_step02a_1`.kopf_art_id <> -100;


-- Bei nicht erfolgreicher BQ-Findung setzen wir die 0% Spanne, also UMSATZ_NETTO!


UPDATE `_step02a_1` SET
    umsatz_anteil = 0,
    umsatz_netto = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC),
    umsatz_mwst = CAST(`_step02a_1`.umsatz_mwst_betrag_alt AS NUMERIC),
    umsatz_bto = CAST(`_step02a_1`.umsatz_netto_alt + `_step02a_1`.umsatz_mwst_betrag_alt AS NUMERIC),
    ek_brutto = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC),
    ek_netto = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC),
    ek_nettonetto = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC),
    ek_kal_basis = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC),
    ek_mep = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC),
    einstandspreis = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC),
    ek_netto_bnk = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC),
    ek_netto_bnk_sachk = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC),
    ek_mep_vor_fwu = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC),
    bonusbasis = CAST(`_step02a_1`.umsatz_netto_alt AS NUMERIC)
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


CREATE OR REPLACE TEMPORARY TABLE _spannen_agg2_1 AS
SELECT
    A.mandant_id,
    A.wup_id,
    A.kopf_art_id,
    A.bewart_id,
    A.bewart_det_id,
    A.promo_fg,
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
FROM `_step02a_1` AS A
INNER JOIN `_aggregat01_1` AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.kopf_art_id = B.art_id AND A.dat = B.dat AND A.ean_kasse = B.ean_kasse AND A.bewart_id = B.bewart_id AND A.bewart_det_id = B.bewart_det_id
        AND A.promo_fg = B.promo_fg
WHERE B.umsatz_netto <> 0
GROUP BY
    A.mandant_id,
    A.wup_id,
    A.kopf_art_id,
    A.bewart_id,
    A.bewart_det_id,
    A.promo_fg,
    A.ean_kasse,
    A.stueckliste_id,
    A.dat;


-- 18.12.2012, -dba-
--
-- Wie dem obigen Titel zu entnehmen ist, werden hier fuer saemtliche Komponenten eines VK_1-Set die entsprechenden
-- Werte ermittelt. Als Anmerkung waere hier noch zu erwaehnen, dass aufgrund von Rundungsungenauigkeiten im Teradata-
-- Umfeld bei der EK-Berechnung laut Spanne leider die Genauigkeit von NUMBER(29,4) auf NUMBER(29,2) gesetzt werden
-- musste, da wir ansonsten kein stimmiges Verhaeltnis der EK-Werte im Vergleich von vorher zu nachher gehabt haetten.


INSERT INTO `_step03_1` (
    mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, dat, wrg_1, ean_kasse, menge,
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
        Z.promo_fg,
        Z.dat,
        Z.wrg_1,
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
    FROM `_step02a_1` AS Z
    INNER JOIN
        `_spannen_agg2_1`
            AS A
        ON
            Z.mandant_id = A.mandant_id AND Z.wup_id = A.wup_id AND Z.kopf_art_id = A.kopf_art_id
            AND Z.stueckliste_id = A.stueckliste_id AND Z.ean_kasse = A.ean_kasse AND Z.dat = A.dat AND Z.bewart_id = A.bewart_id
            AND Z.bewart_det_id = A.bewart_det_id AND Z.promo_fg = A.promo_fg
);


/*
_------------------------------------------------------------------------------
_ 21.) Spannen-EK-Bewertung pro Kopfartikel (ARTBEW_1-Bezug)
_------------------------------------------------------------------------------
*/


INSERT INTO `_step03_1` (
    mandant_id, wup_id, nb_id, art_id, bewart_id, bewart_det_id, promo_fg, dat, wrg_1, ean_kasse, menge,
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
        Z.promo_fg,
        Z.dat,
        Z.wrg_1,
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
        CAST((1 - A0.ek_brutto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_brutto_,
        CAST((1 - A0.ek_netto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_netto_,
        CAST((1 - A0.ek_nettonetto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_nettonetto_,
        CAST((1 - A0.ek_kal_basis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_kal_basis_,
        CAST((1 - A0.ek_mep_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_mep_,
        CAST((1 - A0.einstandspreis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS einstandspreis_,
        CAST(
            (1 - A0.logkostenzuschlag_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS
        logistikkostenzuschlag_,
        CAST((1 - A0.ek_netto_bnk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_netto_bnk_,
        CAST(
            (1 - A0.ek_netto_bnk_sachk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS
        ek_netto_bnk_sachk_,
        CAST((1 - A0.ek_mep_vor_fwu_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS ek_mep_vor_fwu_,
        CAST((1 - A0.bonusbasis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) AS NUMERIC) AS bonusbasis_,
        ROUND(CAST((1 - A0.ek_brutto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4)
            AS diff_ek_brutto_konz,
        ROUND(CAST((1 - A0.ek_netto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4)
            AS diff_ek_netto_konz,
        ROUND(
            CAST((1 - A0.ek_nettonetto_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC),
            4
        ) AS diff_ek_nettonetto_konz,
        ROUND(
            CAST((1 - A0.ek_kal_basis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC),
            4
        ) AS diff_ek_kal_basis_konz,
        ROUND(
            CAST((1 - A0.ek_mep_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4) AS
        diff_ek_mep_konz,
        ROUND(
            CAST((1 - A0.einstandspreis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC
            ), 4
        ) AS diff_einstandspreis_konz,
        ROUND(CAST(
            (1 - A0.logkostenzuschlag_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS
            NUMERIC
        ), 4) AS diff_logkostenzuschlag_konz,
        ROUND(
            CAST((1 - A0.ek_netto_bnk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC),
            4
        ) AS diff_ek_netto_bnk_konz,
        ROUND(CAST(
            (1 - A0.ek_netto_bnk_sachk_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS
            NUMERIC
        ), 4) AS diff_ek_netto_bnk_sachk_konz,
        ROUND(
            CAST((1 - A0.ek_mep_vor_fwu_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC
            ), 4
        ) AS ek_mep_vor_fwu_konz,
        ROUND(CAST((1 - A0.bonusbasis_spn) * ROUND(CAST(Z.umsatz_netto_alt AS NUMERIC), 2) * Z.umrechnungskurs AS NUMERIC), 4
        ) AS bonusbasis_konz
    FROM `_step02_1` AS Z
    LEFT JOIN (
        SELECT
            mandant_id,
            wrg_id,
            dat_von,
            dat_bis,
            von_wrg_id,
            umrechnungskurs,
            td_update,
            td_insert,
            1 AS conv_fg
        FROM dbp_data.mandant_wrg_zu_per_1 AS A
        WHERE
            von_wrg_id IS NOT NULL
            AND wrg_id <> von_wrg_id
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    ) AS y ON Z.mandant_id = y.mandant_id AND Z.wrg_1 = y.wrg_id
    INNER JOIN `_spannen_agg2_1` AS A0
        ON
            Z.mandant_id = A0.mandant_id AND Z.wup_id = A0.wup_id AND Z.art_id = A0.kopf_art_id
            AND Z.stueckliste_id = A0.stueckliste_id AND Z.ean_kasse = A0.ean_kasse AND Z.dat = A0.dat AND Z.bewart_id =
            A0.bewart_id AND Z.bewart_det_id = A0.bewart_det_id AND Z.promo_fg = A0.promo_fg
    WHERE Z.kopf_art_id = -100
);


/*
_------------------------------------------------------------------------------
_ 22.) Aktualisierung der EK-Werte fuer Kopfartikel in ARTBEW_1
_------------------------------------------------------------------------------
*/


MERGE INTO dbp_data.artbew_1 AS A
USING (
    SELECT *
    FROM `_step03_1`
    WHERE kopf_art_id = -100
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.art_id = b.art_id AND A.ean_kasse = b.ean_kasse AND A.dat = b.dat AND A.bewart_id = b.bewart_id AND A.bewart_det_id = b.bewart_det_id AND A.promo_fg =
        b.promo_fg
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


DELETE FROM dbp_data.artbew_stueckliste_zu_1
WHERE (mandant_id, wup_id, nb_id, art_id, dat, komponente_art_id, stueckliste_id) IN (SELECT (
    mandant_id, wup_id, nb_id,
    kopf_art_id, dat, art_id, stueckliste_id
)
FROM `_step03_1`);


INSERT INTO dbp_data.artbew_stueckliste_zu_1 (
    art_id, mandant_id, wup_id, nb_id, dat, komponente_art_id,
    stueckliste_id, umrech_faktor, menge_komponente_in_vk_set, wrg_id, umsatz_netto, umsatz_mwst_betrag, menge, ek_brutto,
    ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, ek_mep_vor_fwu, einstandspreis, logkostenzuschlag, ek_netto_bnk,
    ek_netto_bnk_sachk, bq_findung_id, umrechnungskurs, umrechnungskurs_hist, bonusbasis, td_update, td_insert
)
(
    SELECT
        x.kopf_art_id AS art_id,
        x.mandant_id,
        x.wup_id,
        x.nb_id,
        x.dat,
        x.art_id AS komponente_art_id,
        x.stueckliste_id,
        1 AS umrech_faktor,
        NULL AS menge_komponente_in_vk_set,
        x.wrg_1 AS wrg_id,
        x.umsatz_netto,
        x.umsatz_mwst AS umsatz_mwst_betrag,
        x.komponentenmengen_faktor AS menge,
        x.ek_brutto,
        x.ek_netto,
        x.ek_nettonetto,
        x.ek_kal_basis,
        x.ek_mep,
        x.ek_mep_vor_fwu,
        x.einstandspreis,
        x.logistikkostenzuschlag AS logkostenzuschlag,
        x.ek_netto_bnk,
        x.ek_netto_bnk_sachk,
        x.bq_findung_id,
        ROUND(CAST(x.umrechnungskurs AS NUMERIC), 5) AS umrechnungskurs,
        K.umrechnungskurs AS umrechnungskurs_hist,
        x.bonusbasis,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM (
        SELECT
            mandant_id,
            wup_id,
            nb_id,
            kopf_art_id,
            dat,
            art_id,
            stueckliste_id,
            wrg_1,
            SUM(umsatz_netto) AS umsatz_netto,
            SUM(umsatz_mwst) AS umsatz_mwst,
            SUM(komponentenmengen_faktor) AS komponentenmengen_faktor,
            SUM(ek_brutto) AS ek_brutto,
            SUM(ek_netto) AS ek_netto,
            SUM(ek_nettonetto) AS ek_nettonetto,
            SUM(ek_kal_basis) AS ek_kal_basis,
            SUM(ek_mep) AS ek_mep,
            SUM(einstandspreis) AS einstandspreis,
            SUM(logistikkostenzuschlag) AS logistikkostenzuschlag,
            SUM(ek_netto_bnk) AS ek_netto_bnk,
            SUM(ek_netto_bnk_sachk) AS ek_netto_bnk_sachk,
            bq_findung_id,
            MAX(umrechnungskurs) AS umrechnungskurs,
            SUM(ek_mep_vor_fwu) AS ek_mep_vor_fwu,
            SUM(bonusbasis) AS bonusbasis
        FROM `_step03_1`
        WHERE kopf_art_id <> -100
        GROUP BY
            mandant_id,
            wup_id,
            nb_id,
            art_id,
            dat,
            wrg_1,
            kopf_art_id,
            stueckliste_id,
            bq_findung_id
    ) AS x
    LEFT JOIN
        dbp_data.kurs_1
            AS K
        ON
            x.wrg_1 = K.von_wrg_id AND x.dat BETWEEN K.dat_von AND K.dat_bis AND K.nach_wrg_id
            = 'EUR' AND K.kurstyp_id = 3
);


UPDATE dbp_data.artbew_stueckliste_zu_1 SET
    umrech_faktor = b.umrech_faktor,
    menge_komponente_in_vk_set = CAST(b.umrech_faktor * b.menge_komponente_in_vk_set AS NUMERIC) FROM (
    SELECT
        A.mandant_id
        ,
        A.art_id,
        A.komponente_art_id,
        A.wup_id,
        A.dat,
        A.stueckliste_id,
        MAX(COALESCE(C.umrech_faktor, 1.00000)) AS umrech_faktor,
        MAX(b.komponentenmenge) AS menge_komponente_in_vk_set
    FROM dbp_data.artbew_stueckliste_zu_1 AS A
    INNER JOIN (
        SELECT *
        FROM dbp_data.stueckliste_det_1
        WHERE stueckliste_typ_id = 'M'
    ) AS b
        ON
            A.mandant_id = b.mandant_id AND A.stueckliste_id = b.stueckliste_id AND A.komponente_art_id
            = b.art_id AND A.dat BETWEEN b.dat_von AND b.dat_bis
    LEFT JOIN dbp_data.art_umrechnung_faktor_per_1 AS C
        ON
            b.mandant_id = C.mandant_id AND b.art_id = C.art_id
            AND b.komponentenmenge_einh_id = C.altnv_menge_einh_id AND A.dat BETWEEN C.dat_von AND C.dat_bis
    WHERE
        A.dat >= (
            SELECT MIN(dat)
            FROM dbp_data.tag_1
            WHERE akt_kj = -2
        )
        AND A.mandant_id > 1
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.komponente_art_id,
        A.wup_id,
        A.dat,
        A.stueckliste_id
) AS b
WHERE
    artbew_stueckliste_zu.mandant_id = b.mandant_id AND artbew_stueckliste_zu.art_id = b.art_id AND
    artbew_stueckliste_zu.komponente_art_id = b.komponente_art_id AND artbew_stueckliste_zu.wup_id = b.wup_id AND
    artbew_stueckliste_zu.dat = b.dat AND artbew_stueckliste_zu.stueckliste_id = b.stueckliste_id;


-- GLD-valuation, 16.09.2022, -dbay-


CREATE TABLE IF NOT EXISTS dbp_etl.gld_dat_1 (
    dat DATE
);


INSERT INTO dbp_etl.gld_dat_1 (dat)
(
    SELECT *
    FROM dbp_etl.kmo_wpuums_dat_1
    WHERE
        dat NOT IN (
            SELECT dat
            FROM dbp_etl.gld_dat_1
        )
    GROUP BY dat
);


CREATE OR REPLACE TABLE dbp_etl.tmp_art_wup_tag_gld_1 (
    art_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    ek_gld NUMERIC(29, 4),
    umrechnungskurs FLOAT64
);


CREATE OR REPLACE TABLE dbp_etl.`_snap1_$_1{TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_buch,
    SUM(sum_betrag) AS sum_betrag,
    SUM(CAST(sum_menge AS NUMERIC)) AS sum_menge
FROM (
    SELECT
        L.mandant_id,
        L.art_id,
        L.wup_id,
        L.nb_id,
        L.dat_buch,
        ABS(SUM(CAST(L.betrag_lagerbew AS NUMERIC))) AS sum_betrag,
        ABS(SUM(L.menge_lagerbew_bme)) AS sum_menge
    FROM dbp_data.lagerbew_det_1 AS L
    INNER JOIN dbp_etl.gld_dat_1 AS D ON L.dat_buch = D.dat
    WHERE
        L.lager_bewart_id IN ('251', '252')
        AND L.mandant_id > 1
    GROUP BY
        L.mandant_id,
        L.art_id,
        L.wup_id,
        L.nb_id,
        L.dat_buch
    UNION ALL
    SELECT
        L.mandant_id,
        L.art_id,
        L.wup_id,
        L.nb_id,
        L.dat_buch,
        ABS(SUM(CAST(L.betrag_lagerbew AS NUMERIC))) AS sum_betrag,
        ABS(SUM(L.menge_lagerbew_bme)) AS sum_menge
    FROM dbp_data.lagerbew_det_delta_1 AS L
    INNER JOIN dbp_etl.gld_dat_1 AS D ON L.dat_buch = D.dat
    WHERE
        L.lager_bewart_id IN ('251', '252')
        AND L.mandant_id > 1
    GROUP BY
        L.mandant_id,
        L.art_id,
        L.wup_id,
        L.nb_id,
        L.dat_buch
) AS x
GROUP BY
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_buch;


/* bei Division durch 0: ek_gld = 0 */ INSERT INTO dbp_etl.tmp_art_wup_tag_gld_1 (
    art_id, mandant_id,
    wup_id, nb_id, dat, ek_gld, umrechnungskurs
)
(
    SELECT
        A.art_id,
        A.mandant_id,
        A.wup_id,
        A.nb_id,
        A.dat_buch,
        CAST(CASE
            WHEN A.sum_menge = 0
                THEN 0
            ELSE A.sum_betrag / A.sum_menge
        END AS NUMERIC) AS ek_gld,
        CAST(K.umrechnungskurs AS FLOAT64) AS umrechnungskurs
    FROM dbp_etl.`_snap1_$_1{TRANSIENT_TABLE_SUFFIX}` AS A
    INNER JOIN dbp_data.mandant_1 AS M ON A.mandant_id = M.mandant_id
    INNER JOIN
        dbp_data.kurs_1
            AS K
        ON
            M.default_wrg = K.von_wrg_id AND K.kurstyp_id = 3 AND K.nach_wrg_id =
            'EUR' AND -- a.dat_buch BETWEEN k.dat_von AND k.dat_bis
            K.dat_bis = DATE '9999-12-31'
);


INSERT INTO dbp_etl_process.ekc_artbew_agg_wt_1 (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_etl.tmp_art_wup_tag_gld_1
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_etl_process.ekc_artbew_agg_wt_1
    )
    GROUP BY
        mandant_id,
        wup_id,
        nb_id,
        dat
);


UPDATE dbp_data.artbew_1 SET
    ek_gld = 0,
    diff_ek_gld_konz = 0
FROM dbp_etl.gld_dat_1
WHERE artbew.dat = gld_dat.dat AND artbew.mandant_id > 1;


UPDATE dbp_data.artbew_1 SET
    ek_gld = artbew.umsatz_netto,
    diff_ek_gld_konz = artbew.diff_umsatz_netto_konz
FROM dbp_etl.gld_dat_1
WHERE artbew.dat = gld_dat.dat AND artbew.mandant_id > 1 AND artbew.art_id = -1; /* unbekannter Artikel_1 */


UPDATE dbp_data.artbew_1 SET
    ek_gld = artbew.ek_netto,
    diff_ek_gld_konz = artbew.diff_ek_netto_konz
FROM dbp_etl.gld_dat_1, dbp_data.art_1 AS A
WHERE
    artbew.dat = gld_dat.dat AND artbew.mandant_id > 1 AND artbew.mandant_id = A.mandant_id AND artbew.art_id = A.art_id
    AND artbew.art_id > -1 AND A.wg_art_fg = 1; /* Warengruppenerfassartikel */


UPDATE dbp_data.artbew_1 SET
    ek_gld = CAST(G.ek_gld * artbew.menge AS NUMERIC),
    diff_ek_gld_konz = CAST(G.ek_gld * artbew.menge * G.umrechnungskurs AS NUMERIC) FROM dbp_data.art_1 AS A,
    dbp_etl.tmp_art_wup_tag_gld_1 AS G
WHERE
    artbew.dat = G.dat AND artbew.mandant_id = G.mandant_id AND artbew.wup_id = G.wup_id AND artbew.art_id = G.art_id
    AND artbew.art_id > -1 AND artbew.mandant_id = A.mandant_id AND artbew.art_id = A.art_id AND A.wg_art_fg = 0;
/* keine WG Erfassartiekel */


TRUNCATE TABLE dbp_etl.kmo_wpuums_art_gp_wup_zu_1;


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_anr_1;


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_dat_1;


DROP TABLE IF EXISTS dbp_etl.kmo_wpuums_dat_min_1;
