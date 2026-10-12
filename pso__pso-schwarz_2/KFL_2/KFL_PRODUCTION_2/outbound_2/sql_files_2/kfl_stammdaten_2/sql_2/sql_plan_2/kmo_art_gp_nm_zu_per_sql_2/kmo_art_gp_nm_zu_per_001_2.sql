SELECT dat_relevant
FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2;


DELETE FROM dbp_etl_process.metadata_kmo_bq_findung_2
WHERE ende IS NULL;


INSERT INTO dbp_etl_process.metadata_kmo_bq_findung_2 (snapshot_datum, verdat, beginn)
(SELECT
    dat_relevant AS snapshot_datum,
    CURRENT_DATE("Europe/Berlin") AS verdat,
    CAST(CURRENT_TIMESTAMP() AS DATETIME) AS beginn
FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2);


CREATE TEMPORARY TABLE IF NOT EXISTS _zwischen_tabelle (
    mandant_id INTEGER,
    wup_id INTEGER,
    nb_id INTEGER,
    art_id INTEGER,
    dat DATE,
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
    wg_id INTEGER,
    kreistyp_gruppe_id STRING(4)
);


-- Kreistyp_gruppe aus Marktstamm.
-- Regel Ekorg aus Einkaufsinfosatz
-- Anzahl Orderbuch gepflegt

-- Regel GP_2 aus Einkaufsinfosatz

-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_2 und EORD_2

-- Warengruppe für Zugriff auf vz_wup_wg_zu_per
-- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)

-- GP_2 nach Bezugsquellenfindung
-- Ekorg nach Bezugsquellenfindung
-- Ausstiegspunkt der Bezugsquellenfindung

-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_2 und EORD_2
CREATE TEMPORARY TABLE
IF NOT EXISTS _kmo_art_gp_wup_zu_2 (
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
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER
);


-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_2 und EORD_2

-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_2 und EORD_2

-- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)
-- GP_2 nach Bezugsquellenfindung

-- Anzahl Orderbuch gepflegt
-- Regel GP_2 aus Einkaufsinfosatz
-- Ausstiegspunkt der Bezugsquellenfindung

-- Kreistyp_gruppe aus Marktstamm.
-- Regel Ekorg aus Einkaufsinfosatz
-- Ekorg nach Bezugsquellenfindung

-- Warengruppe für Zugriff auf vz_wup_wg_zu_per
CREATE TEMPORARY TABLE IF NOT EXISTS _kmo_art_gp_wup_zu_3 (
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
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER
);


CREATE TEMPORARY TABLE IF NOT EXISTS _art_gp_wup_zu_per AS
SELECT
    mandant_id,
    art_id,
    gp_id,
    wup_id,
    nb_id,
    einkaufsorganisation_id,
    dat_von,
    dat_bis
FROM dbp_data.art_gp_wup_zu_per_2
WHERE dat_bis >= (
    SELECT dat_relevant
    FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
)
AND mandant_id > 1;


CREATE TEMPORARY TABLE IF NOT EXISTS _vz_wg_wup_zu_per AS
-- Fuehrend Prio aus Zek_kreis
-- Kreistyp ist nicht immer gefuellt.
SELECT
    V.mandant_id,
    V.arthiertyp_id,
    V.wg_hierarchie_ebene_id,
    V.wg_hierarchie_id,
    V.wup_id,
    V.nb_id,
    V.vz_wup_id,
    D.dat_relevant AS dat,
    V.vz_prio_id,
    COALESCE(V.kreistyp_id, '') AS kreistyp_id,
    COALESCE(K.vz_prio_id, V.vz_prio_id) AS zek_kreis_vz_prio_id
FROM dbp_data.vz_wg_wup_zu_per_2 AS V
INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D ON D.dat_relevant BETWEEN V.dat_von AND V.dat_bis
LEFT JOIN dbp_data.l_kreistyp_2 AS K ON V.mandant_id = K.mandant_id AND V.kreistyp_id = K.kreistyp_id
-- Polnischen Dummy_2 Kreistyp Z ignorieren

WHERE CASE
    WHEN V.mandant_id = 3 AND V.kreistyp_id = 'Z'
        THEN 0
    ELSE 1
END = 1;


-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_2 und EORD_2

-- Anzahl Orderbuch gepflegt
-- GP_2 nach Bezugsquellenfindung
-- Regel GP_2 aus Einkaufsinfosatz

-- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)
-- Regel Ekorg aus Einkaufsinfosatz

-- Ausstiegspunkt der Bezugsquellenfindung

-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_2 und EORD_2

-- Ekorg nach Bezugsquellenfindung
-- Warengruppe für Zugriff auf vz_wup_wg_zu_per
-- Kreistyp_gruppe aus Marktstamm.

CREATE TEMPORARY TABLE IF NOT EXISTS _kmo_art_gp_wup_oh_bzw (
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
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER
);


CREATE TEMPORARY TABLE IF NOT EXISTS _art_gp_nm_zu_per_tmp (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    gp_id INTEGER NOT NULL,
    einkaufsorganisation_id INTEGER NOT NULL,
    dat_bis DATE NOT NULL,
    bq_findung_id INTEGER,
    vz_wup_id INTEGER,
    bezugsweg_id INTEGER
);


CREATE TEMPORARY TABLE IF NOT EXISTS _art_gp_nm_zu_per_tmp2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    gp_id INTEGER NOT NULL,
    einkaufsorganisation_id INTEGER NOT NULL,
    dat_bis DATE NOT NULL,
    bq_findung_id INTEGER,
    vz_wup_id INTEGER,
    bezugsweg_id INTEGER
);


CREATE TEMPORARY TABLE IF NOT EXISTS _kmo_art_gp_wup_zu_3x (
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
    wg_id INTEGER
);


INSERT INTO `_zwischen_tabelle`
(
    SELECT
        B.mandant_id,
        B.wup_id,
        B.nb_id,
        CAST(a.art_id AS INTEGER) AS art_id,
        X.dat_relevant AS dat,
        COALESCE(D.bezugsweg_id, 0) AS bezugsweg_id,
        0 AS anz_ek_infosatz,
        0 AS anz_ek_orderbuch,
        0 AS bq_gp_id,
        0 AS bq_ekorg,
        0 AS bq_findung_id,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        0 AS ref_wup_id,
        0 AS ref_nb_id,
        COALESCE(c.wg_id, 0) AS wg_id,
        COALESCE(B.kreistyp_gruppe_id, '') AS kreistyp_gruppe_id
    FROM (
        SELECT *
        FROM dbp_data.art_2
        WHERE
            dat_bis = PARSE_DATE('%F', '9999-12-31')
            AND mandant_id > 1
    ) AS a
    INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS X ON TRUE
    INNER JOIN dbp_data.wup_2 AS B ON a.mandant_id = B.mandant_id
    INNER JOIN (
        SELECT *
        FROM dbp_data.art_wg_zu_per_2
        WHERE
            mandant_id > 1
            AND (
                SELECT dat_relevant
                FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
            ) BETWEEN dat_von AND dat_bis
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.art_id = c.art_id AND c.arthiertyp_id = 2
    LEFT JOIN (
        dbp_data.art_wup_status_per_2 AS D LEFT JOIN (
            SELECT dat_relevant AS `A11860`
            FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2
        ) AS t2 ON TRUE
    )
        ON
            a.mandant_id = D.mandant_id AND a.art_id
            = D.art_id AND B.wup_id = D.wup_id AND t2.`A11860` BETWEEN D.dat_von AND D.dat_bis
    WHERE
        B.mandant_id > 1
        AND B.wup_id <> 0
);


CREATE OR REPLACE TEMPORARY TABLE _kmo_ek_infosatz AS
/* 1:n gültige Infosaetze?? */ /* falls 1:1, dann dieser Lieferant */ /* falls 1:1, dann dieser Lieferant */
/* lt. FB gibt es nur einen Regellieferant */ /* Kennzeichen Zaehlen aktive Infosaetze inkl. Regel GP_2 */ /* INTEGER */
SELECT
    E.mandant_id,
    E.art_id,
    D.dat_relevant AS dat,
    EK.wup_id,
    EK.nb_id,
    COUNT(E.mandant_id) AS anz_ek_infosatz,
    MAX(E.gp_id) AS bq_gp_id,
    MAX(E.einkaufsorganisation_id) AS bq_ekorg,
    MAX(CASE
        WHEN E.regel_gp_fg = 1
            THEN E.gp_id
        ELSE 0
    END) AS regel_gp_id,
    MAX(CASE
        WHEN E.regel_gp_fg = 1
            THEN E.einkaufsorganisation_id
        ELSE 0
    END) AS regel_ekorg,
    1 AS ek_infosatz_art,
    CAST(NULL AS INTEGER) AS ek_infosatz_id,
    DATE(NULL) AS dat_erstellung
FROM dbp_data.ek_infosatz_2 AS E
INNER JOIN dbp_data.ek_infosatz_wup_zu_2 AS EK ON E.mandant_id = EK.mandant_id AND E.ek_infosatz_id = EK.ek_infosatz_id

INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D
    ON
        D.dat_relevant BETWEEN E.dat_von AND E.dat_bis
        AND E.dat_erstellung <= D.dat_relevant
WHERE
    EK.loesch_fg = 0 /* Ekorg Erweiterung muss auch gueltig sein */
    AND E.mandant_id > 1
    AND E.loesch_fg = 0
    AND (
        E.art_id, D.dat_relevant) IN (
        SELECT (art_id, dat)
        FROM `_zwischen_tabelle`
    )
GROUP BY
    E.mandant_id,
    E.art_id,
    dat,
    EK.wup_id,
    EK.nb_id,
    ek_infosatz_art;


--select get_ddl('table','DBP_DATA._kmo_ek_infosatz')


/* Kennzeichen hoechster inaktiver Infosatz */
/* GROUP BY e.mandant_id,e.art_id,ek.wup_id,ek.nb_id
QUALIFY CSUM(1, e.ek_infosatz_id DESC, e.dat_erstellung DESC) = 1; */
INSERT INTO `_kmo_ek_infosatz` (
    mandant_id, art_id, dat, wup_id, nb_id, anz_ek_infosatz, bq_gp_id, bq_ekorg, regel_gp_id,
    regel_ekorg, ek_infosatz_art, ek_infosatz_id, dat_erstellung
)
(
    SELECT
        E.mandant_id,
        E.art_id,
        D.dat_relevant AS dat,
        EK.wup_id,
        EK.nb_id,
        1 AS anz_ek_infosatz,
        E.gp_id AS bq_gp_id,
        E.einkaufsorganisation_id AS bq_ekorg,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        2 AS ek_infosatz_art,
        E.ek_infosatz_id,
        E.dat_erstellung
    FROM dbp_data.ek_infosatz_2 AS E
    INNER JOIN dbp_data.ek_infosatz_wup_zu_2 AS EK ON E.mandant_id = EK.mandant_id AND E.ek_infosatz_id = EK.ek_infosatz_id -- Definition inaktiv:
    -- EINA_2 und/oder EINE_2 Loschkennzeichen gesetzt

    -- UND/ODER Gültigkeitszeitraum EINA_2 nicht am Stichtag gültig

    -- UND es werden nur die Infosätze berücksichtigt die zum
    -- Stichtag bereits angelegt waren

    INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D
        ON E.dat_erstellung <= D.dat_relevant AND (
            E.loesch_fg
            = 1 OR EK.loesch_fg = 1 OR E.dat_von > D.dat_relevant OR E.dat_bis < D.dat_relevant
        )
    WHERE
        E.mandant_id > 1
        AND (
            E.art_id, D.dat_relevant) IN (
            SELECT (art_id, dat)
            FROM `_zwischen_tabelle`
        )
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY
            E.mandant_id, E.art_id, EK.wup_id, EK.nb_id ORDER BY
            E.ek_infosatz_id IS NULL
            DESC, E.ek_infosatz_id DESC, E.dat_erstellung IS NULL DESC, E.dat_erstellung DESC
    )) = 1
);


/* GROUP BY e.mandant_id,e.art_id,dat,ek.wup_id,ek.nb_id,e.gp_id,e.einkaufsorganisation_id
QUALIFY CSUM(1, e.ek_infosatz_id DESC, e.dat_erstellung DESC) = 1; */
/* Kennzeichen hoechster inaktiver Infosatz */ INSERT INTO `_kmo_ek_infosatz` (
    mandant_id, art_id, dat, wup_id, nb_id,
    anz_ek_infosatz, bq_gp_id, bq_ekorg, regel_gp_id, regel_ekorg, ek_infosatz_art, ek_infosatz_id, dat_erstellung
)
(
    SELECT
        E.mandant_id,
        E.art_id,
        D.dat_relevant AS dat,
        EK.wup_id,
        EK.nb_id,
        1 AS anz_ek_infosatz,
        E.gp_id AS bq_gp_id,
        E.einkaufsorganisation_id AS bq_ekorg,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        3 AS ek_infosatz_art,
        E.ek_infosatz_id,
        E.dat_erstellung
    FROM dbp_data.ek_infosatz_2 AS E
    INNER JOIN dbp_data.ek_infosatz_wup_zu_2 AS EK ON E.mandant_id = EK.mandant_id AND E.ek_infosatz_id = EK.ek_infosatz_id -- Definition aktiv:
    -- EINA_2 und EINE_2 Loschkennzeichen nicht gesetzt

    -- UND/ODER Gültigkeitszeitraum EINA_2 am Stichtag gültig
    -- UND es werden nur die Infosätze berücksichtigt die zum

    -- Stichtag bereits angelegt waren

    INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D
        ON
            D.dat_relevant BETWEEN E.dat_von AND E.dat_bis
            AND E.dat_erstellung <= D.dat_relevant
    WHERE
        E.mandant_id > 1
        AND E.loesch_fg = 0
        AND EK.loesch_fg = 0
        AND (
            E.art_id, D.dat_relevant) IN (
            SELECT (art_id, dat)
            FROM `_zwischen_tabelle`
        )
    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY E.mandant_id, E.art_id, dat, EK.wup_id, EK.nb_id, E.gp_id, E.einkaufsorganisation_id
        ORDER BY
            E.ek_infosatz_id IS NULL DESC, E.ek_infosatz_id DESC, E.dat_erstellung IS NULL DESC, E.dat_erstellung
            DESC
    )) = 1
);


CREATE TEMPORARY TABLE IF NOT EXISTS _kmo_art_kreistyp_gruppe AS
SELECT
    A.art_id,
    A.mandant_id,
    A.kreistyp_id,
    TRIM(A.kreistyp_gruppe_id) AS kreistyp_gruppe_id,
    D.dat_relevant AS dat,
    K.vz_prio_id
FROM dbp_data.art_kreistyp_gruppe_zu_per_2 AS A
INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D ON D.dat_relevant BETWEEN A.dat_von AND A.dat_bis
LEFT JOIN dbp_data.l_kreistyp_2 AS K ON A.mandant_id = K.mandant_id AND A.kreistyp_id = K.kreistyp_id
WHERE
    A.kreistyp_id <> 'Z'
    AND A.mandant_id > 1;


UPDATE `_zwischen_tabelle` SET
    bezugsweg_id = 4
WHERE nb_id = -111 AND bezugsweg_id NOT IN (1, 4);


MERGE INTO `_zwischen_tabelle` AS A
USING (
    SELECT
        aws.mandant_id,
        aws.art_id,
        X.dat_relevant AS dat,
        MAX(aws.bezugsweg_id) AS bezugsweg_id_
    FROM (
        SELECT
            A0.mandant_id,
            A0.art_id,
            A0.dat_von,
            A0.dat_bis,
            A0.bezugsweg_id
        FROM dbp_data.art_wup_status_per_2 AS A0
        INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS D ON TRUE
        WHERE
            A0.art_id IN (
                SELECT art_id
                FROM `_zwischen_tabelle`
                WHERE bezugsweg_id NOT IN (1, 4)
            )
            AND A0.mandant_id > 1
            AND A0.bezugsweg_id IN (1, 4)
            AND A0.dat_bis >= D.dat_relevant
    ) AS aws
    INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS X ON TRUE
    WHERE X.dat_relevant BETWEEN aws.dat_von AND aws.dat_bis
    GROUP BY
        aws.mandant_id,
        aws.art_id,
        dat
) AS b
    ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.dat = b.dat AND A.bezugsweg_id NOT IN (1, 4)
WHEN MATCHED THEN UPDATE SET
    bezugsweg_id = b.bezugsweg_id_;


/* keine BQ Findung moeglich */ INSERT INTO `_kmo_art_gp_wup_oh_bzw`
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat,
    bezugsweg_id,
    anz_ek_infosatz,
    anz_ek_orderbuch,
    0 AS bq_gp_id,
    0 AS bq_ekorg,
    0 AS bq_findung_id,
    regel_gp_id,
    regel_ekorg,
    ref_wup_id,
    ref_nb_id,
    kreistyp_gruppe_id,
    wg_id
FROM `_zwischen_tabelle`
WHERE bezugsweg_id NOT IN (1, 4));


DELETE FROM `_zwischen_tabelle`
WHERE bezugsweg_id NOT IN (1, 4);


/* vz_prio_id_ */ /* kreistyp_id_ */ /* vz_prio_id_ */ /* Bezugsweg 4 immer VZ */ /* kreistyp_id_ */
/* Zugriff auf Artikel_2 Kreistyp Zuordnung mit Region_2 aus Markt */ INSERT INTO `_kmo_art_gp_wup_zu_2`
(SELECT
    t1.mandant_id,
    t1.art_id,
    t1.wup_id,
    t1.nb_id,
    t1.dat,
    t1.bezugsweg_id,
    0 AS anz_ek_infosatz,
    0 AS anz_ek_orderbuch,
    0 AS bq_gp_id,
    0 AS bq_ekorg,
    0 AS bq_findung_id,
    0 AS regel_gp_id,
    0 AS regel_ekorg,
    t1.vz_wup_id_ AS ref_wup_id,
    -111 AS ref_nb_id,
    t1.kreistyp_gruppe_id,
    t1.wg_id
FROM (
    SELECT
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat,
        AGW.bezugsweg_id,
        COALESCE(AK.kreistyp_id, AKK.kreistyp_id) AS kreistyp_id_,
        CASE
            WHEN TRIM(AGW.kreistyp_gruppe_id) = ''
                THEN -1
            ELSE COALESCE(AK.vz_prio_id, AKK.vz_prio_id, -1)
        END AS vz_prio_id_,
        COALESCE(WWWG.vz_wup_id, WWUP.vz_wup_id, VZWG.vz_wup_id, VZWUP.vz_wup_id) AS vz_wup_id_,
        -111 AS vz_nb_id_,
        AGW.kreistyp_gruppe_id,
        AGW.wg_id,
        WWWG.zek_kreis_vz_prio_id,
        WWUP.zek_kreis_vz_prio_id AS zek_kreis_vz_prio_id0,
        VZWG.zek_kreis_vz_prio_id AS zek_kreis_vz_prio_id1,
        VZWUP.zek_kreis_vz_prio_id AS zek_kreis_vz_prio_id2,
        VZWG.vz_prio_id,
        VZWUP.vz_prio_id AS vz_prio_id0
    FROM `_zwischen_tabelle` AS AGW
    LEFT JOIN `_kmo_art_kreistyp_gruppe` AS AK
        ON
            AGW.mandant_id = AK.mandant_id AND AGW.art_id = AK.art_id AND AGW.kreistyp_gruppe_id
            = AK.kreistyp_gruppe_id AND AGW.dat = AK.dat /* Zugriff ohne Region_2 (Kreisgruppe) */
    LEFT JOIN `_kmo_art_kreistyp_gruppe` AS AKK ON AGW.mandant_id = AKK.mandant_id AND AGW.art_id = AKK.art_id AND TRIM(AKK.kreistyp_gruppe_id) = '' AND AGW.dat = AKK.dat
    /* Zugriff mit Kreistyp auf VZ Zuordnung auf Markt - Warengruppenebene */
    LEFT JOIN `_vz_wg_wup_zu_per` AS WWWG
        ON
            AGW.mandant_id = WWWG.mandant_id AND AGW.wup_id = WWWG.wup_id AND AGW.nb_id
            = WWWG.nb_id AND AGW.wg_id = WWWG.wg_hierarchie_id AND WWWG.arthiertyp_id = 6 AND
            -- zweistufige SAP Warengruppenhierarchie
            WWWG.wg_hierarchie_ebene_id = 4 AND -- Hierarchiestufe Warengruppe

            WWWG.kreistyp_id = COALESCE(AK.kreistyp_id, AKK.kreistyp_id) AND -- hier Zugriff mit kreistyp auf WRF3
            AGW.dat =
            WWWG.dat /* Zugriff mit Kreistyp auf VZ Zuordnung auf Marktebene */
    LEFT JOIN `_vz_wg_wup_zu_per` AS WWUP
        ON
            AGW.mandant_id = WWUP.mandant_id AND AGW.wup_id = WWUP.wup_id AND AGW.nb_id
            = WWUP.nb_id AND WWUP.kreistyp_id = COALESCE(AK.kreistyp_id, AKK.kreistyp_id) AND
            -- hier Zugriff mit kreistyp auf WRF3
            WWUP.wg_hierarchie_id = -1 AND -- ohne WG Bezug
            AGW.dat = WWUP.dat
    /* Zugriff ohne Kreistyp mit nöchstniedrigerer Proritaet auf VZ Zuordnung auf Markt - Warengruppenebene */
    LEFT JOIN `_vz_wg_wup_zu_per` AS VZWG
        ON
            AGW.mandant_id = VZWG.mandant_id AND AGW.wup_id = VZWG.wup_id AND AGW.nb_id
            = VZWG.nb_id AND AGW.wg_id = VZWG.wg_hierarchie_id AND VZWG.arthiertyp_id = 6 AND
            -- zweistufige SAP Warengruppenhierarchie
            VZWG.wg_hierarchie_ebene_id = 4 AND
            -- dann ist der naechstpassende Eintrag besser als keiner

            -- Wenn oben nichts gefunden wurde oder kreistyp_region_id = leer
            -- Hierarchiestufe Warengruppe
            VZWG.zek_kreis_vz_prio_id
            > CASE
                WHEN TRIM(AGW.kreistyp_gruppe_id) = ''
                    THEN -1
                ELSE COALESCE(AK.vz_prio_id, AKK.vz_prio_id, -1)
            END AND AGW.dat = VZWG.dat
    /* Zugriff ohne Kreistyp mit nöchstniedrigerer Proritaet auf VZ Zuordnung auf Marktebene */
    LEFT JOIN `_vz_wg_wup_zu_per` AS VZWUP
        ON
            AGW.mandant_id = VZWUP.mandant_id AND AGW.wup_id = VZWUP.wup_id AND AGW.nb_id
            = VZWUP.nb_id AND -- dann ist naechstpassende Eintrag besser als keiner

            -- Wenn oben nichts gefunden wurde oder kreistyp_region_id = leer
            VZWUP.zek_kreis_vz_prio_id > CASE
                WHEN TRIM(AGW.kreistyp_gruppe_id) = ''
                    THEN -1
                ELSE COALESCE(AK.vz_prio_id, AKK.vz_prio_id, -1)
            END AND VZWUP.wg_hierarchie_id = -1 AND -- ohne WG Bezug
            AGW.dat = VZWUP.dat
    WHERE
        AGW.bezugsweg_id = 4
        AND AGW.mandant_id IN (2, 3, 4, 7)
        AND AGW.nb_id <> -111
        /* GROUP BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat
        Folgende Zugriffsreihenfolge:
        - Zugriff mit Region_2, Kreistyp, Warengruppe und Markt
        - Zugriff mit Region_2, Kreistyp und Markt ohne Warengruppe
        - Zugriff ohne Region_2 und ohne Kreistyp mit Warengruppe und mit Markt
        - Zugriff ohne Region_2 und ohne Kreistyp und ohne Warengruppe und mit Markt */
        /* QUALIFY CSUM (1,
        COALESCE(wwwg.zek_kreis_vz_prio_id, wwup.zek_kreis_vz_prio_id) ASC,
        COALESCE(vzwg.zek_kreis_vz_prio_id, vzwup.zek_kreis_vz_prio_id) ASC,
        COALESCE(vzwg.vz_prio_id, vzwup.vz_prio_id) ASC) = 1) a; */

    QUALIFY (ROW_NUMBER() OVER (PARTITION BY AGW.mandant_id, AGW.art_id, AGW.wup_id, AGW.nb_id, AGW.dat ORDER BY COALESCE(
        WWWG.zek_kreis_vz_prio_id, zek_kreis_vz_prio_id0) IS NULL, COALESCE(WWWG.zek_kreis_vz_prio_id,
    zek_kreis_vz_prio_id0), COALESCE(zek_kreis_vz_prio_id1, zek_kreis_vz_prio_id2) IS NULL, COALESCE(zek_kreis_vz_prio_id1,
    zek_kreis_vz_prio_id2), COALESCE(VZWG.vz_prio_id, vz_prio_id0) IS NULL, COALESCE(
        VZWG.vz_prio_id,
        vz_prio_id0
    ))) = 1
) AS t1_2);


INSERT INTO `_kmo_art_gp_wup_zu_2`
(
    SELECT
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        dat,
        bezugsweg_id,
        anz_ek_infosatz,
        anz_ek_orderbuch,
        0 AS bq_gp_id,
        0 AS bq_ekorg,
        bq_findung_id,
        regel_gp_id,
        regel_ekorg,
        wup_id AS ref_wup_id,
        nb_id AS ref_nb_id,
        kreistyp_gruppe_id,
        wg_id
    FROM `_zwischen_tabelle`
    WHERE
        bezugsweg_id = 1
        OR nb_id = -111
);


INSERT INTO `_kmo_art_gp_wup_zu_2`
(SELECT
    t2.mandant_id,
    t2.art_id,
    t2.wup_id,
    t2.nb_id,
    t2.dat,
    t2.bezugsweg_id,
    0 AS anz_ek_infosatz,
    0 AS anz_ek_orderbuch,
    0 AS bq_gp_id,
    0 AS bq_ekorg,
    0 AS bq_findung_id,
    0 AS regel_gp_id,
    0 AS regel_ekorg,
    t2.vz_wup_id_ AS ref_wup_id,
    -111 AS ref_nb_id,
    '' AS kreistyp_gruppe_id,
    t2.wg_id
FROM (
    SELECT
        agw.mandant_id,
        agw.art_id,
        agw.wup_id,
        agw.nb_id,
        agw.dat,
        agw.bezugsweg_id,
        agw.wg_id,
        COALESCE(E.vz_wup_id, WWWG.vz_wup_id, WWUP.vz_wup_id) AS vz_wup_id_,
        -111 AS vz_nb_id_,
        E.fix_gp_fg,
        WWWG.wg_hierarchie_id,
        WWUP.wg_hierarchie_id AS wg_hierarchie_id0,
        WWWG.vz_prio_id,
        WWUP.vz_prio_id AS vz_prio_id0
    FROM (
        SELECT *
        FROM `_zwischen_tabelle`
        WHERE nb_id <> -111
    ) AS agw
    LEFT JOIN dbp_data.ek_orderbuch_2 AS E
        ON
            agw.mandant_id = E.mandant_id AND agw.art_id = E.art_id AND
            agw.wup_id = E.wup_id AND E.gesperrt_fg = 0 AND agw.dat BETWEEN E.dat_von AND E.dat_bis AND E.vz_wup_id
            IS NOT NULL
    LEFT JOIN `_vz_wg_wup_zu_per` AS WWWG
        ON
            agw.mandant_id = WWWG.mandant_id AND agw.wup_id = WWWG.wup_id AND agw.nb_id
            = WWWG.nb_id AND agw.wg_id = WWWG.wg_hierarchie_id AND WWWG.arthiertyp_id = 6 AND
            -- zweistufige SAP Warengruppenhierarchie
            WWWG.wg_hierarchie_ebene_id = 4 AND -- Hierarchiestufe Warengruppe

            agw.dat = WWWG.dat /* Zugriff auf VZ Zuordnung auf Marktebene */
    LEFT JOIN `_vz_wg_wup_zu_per` AS WWUP
        ON
            agw.mandant_id = WWUP.mandant_id AND agw.wup_id = WWUP.wup_id AND agw.nb_id
            = WWUP.nb_id AND WWUP.wg_hierarchie_id = -1 AND -- ohne WG Bezug
            agw.dat = WWUP.dat
    WHERE
        agw.bezugsweg_id = 4
        AND agw.mandant_id IN (5, 6, 8) -- GROUP BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat

        -- Orderbuch mit Kennzeichen fixer Lieferant fuehrend

        -- WRF3 mit Markt/WG Referenz fuerend vor WRF3 mit Markt Referenz

        -- Orderbuch mit Kennzeichen fixer Lieferant fuehrend

        -- WRF3 mit Markt/WG Referenz fuerend vor WRF3 mit Markt Referenz

        /* QUALIFY CSUM(1,
                  COALESCE(fix_gp_fg, 0) DESC,
                  COALESCE(wwwg.wg_hierarchie_id, wwup.wg_hierarchie_id) DESC,
                  COALESCE(wwwg.vz_prio_id, wwup.vz_prio_id) ASC) = 1) */

    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY
            agw.mandant_id, agw.art_id, agw.wup_id, agw.nb_id, agw.dat ORDER BY
            COALESCE(E.fix_gp_fg, 0) IS NULL DESC, COALESCE(E.fix_gp_fg, 0) DESC, COALESCE(WWWG.wg_hierarchie_id, wg_hierarchie_id0
            ) IS NULL DESC, COALESCE(WWWG.wg_hierarchie_id, wg_hierarchie_id0) DESC, COALESCE(WWWG.vz_prio_id, vz_prio_id0
            ) IS NULL, COALESCE(WWWG.vz_prio_id, vz_prio_id0)
    )) = 1
) AS t2);


/* führend gueltige Infosätze */ /* Wichtig: Anz. Infosaetze aus Coalesce (s.u.) */
-- 1. Zugriff Ermittlung gültige Infosätze mit VZ/Markt Bezug
INSERT INTO `_kmo_art_gp_wup_zu_3`
(
    SELECT
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat,
        AGW.bezugsweg_id,
        COALESCE(E.anz_ek_infosatz, EO.anz_ek_infosatz, EK.anz_ek_infosatz, EKK.anz_ek_infosatz, 0) AS anz_ek_infosatz_,
        AGW.anz_ek_orderbuch,
        CASE
            WHEN COALESCE(E.anz_ek_infosatz, EO.anz_ek_infosatz, EK.anz_ek_infosatz, EKK.anz_ek_infosatz, 0) = 1
                THEN COALESCE(E.bq_gp_id, EO.bq_gp_id, EK.bq_gp_id, EKK.bq_gp_id, 0)
            ELSE 0
        END AS bq_gp_id_,
        CASE
            WHEN COALESCE(E.anz_ek_infosatz, EO.anz_ek_infosatz, EK.anz_ek_infosatz, EKK.anz_ek_infosatz, 0) = 1
                THEN COALESCE(E.bq_ekorg, EO.bq_ekorg, EK.bq_ekorg, EKK.bq_ekorg, 0)
            ELSE 0
        END AS bq_ekorg_,
        CASE
            WHEN COALESCE(E.anz_ek_infosatz, EO.anz_ek_infosatz, EK.anz_ek_infosatz, EKK.anz_ek_infosatz, 0) = 1
            /* es ist ein gueltiger oder mindestens ein ungueltiger Infosatz vorhanden */
                THEN CASE
                    WHEN COALESCE(E.mandant_id, EO.mandant_id) IS NOT NULL
                        THEN 1
                    ELSE 3
                END
            ELSE 0 /* Kein Infosatz oder Anzahl Infosätze > 1 */
        END AS bq_findung_id_,
        COALESCE(E.regel_gp_id, EO.regel_gp_id, 0) AS regel_gp_id_,
        COALESCE(E.regel_ekorg, EO.regel_ekorg, 0) AS regel_ekorg_,
        COALESCE(AGW.ref_wup_id, -1) AS ref_wup_id,
        AGW.ref_nb_id,
        AGW.kreistyp_gruppe_id,
        AGW.wg_id
    FROM `_kmo_art_gp_wup_zu_2` AS AGW
    LEFT JOIN `_kmo_ek_infosatz` AS E
        ON
            AGW.mandant_id = E.mandant_id AND AGW.ref_wup_id = E.wup_id AND AGW.art_id = E.art_id
            AND AGW.dat = E.dat AND E.ek_infosatz_art = 1 /* Zaehlen aktive Infosaetze mit Regel GP_2 betriebsspezifisch */
    -- 2. Zugriff Ermittlung gültige Infosätze ohne Markt/VZ Referenz

    LEFT JOIN `_kmo_ek_infosatz` AS EO
        ON
            AGW.mandant_id = EO.mandant_id AND EO.wup_id = 0 AND AGW.art_id = EO.art_id AND
            AGW.dat = EO.dat AND EO.ek_infosatz_art = 1 /* Zaehlen aktive Infosaetze mit Regel GP_2 betriebsuebergreifend */
    -- 3. Zugriff: Ermittlung des hoechsten inaktiven Infosatzes Zugriff

    -- zuerst mit Marktbezug danach den betriebsuebrgreifenden Eintrag

    -- (fuehrend ist der betriebsspezifische Datensatz, s.o.)

    LEFT JOIN `_kmo_ek_infosatz` AS EK
        ON
            AGW.mandant_id = EK.mandant_id AND AGW.ref_wup_id = EK.wup_id AND AGW.art_id =
            EK.art_id AND AGW.dat = EK.dat AND EK.ek_infosatz_art = 2 /* hoechster inaktiver Infosatz betriebsspezifisch */
    LEFT JOIN
        `_kmo_ek_infosatz`
            AS EKK
        ON
            AGW.mandant_id = EKK.mandant_id AND EKK.wup_id = 0 AND AGW.art_id = EKK.art_id
            AND AGW.dat = EKK.dat AND EKK.ek_infosatz_art = 2 /* hoechster inaktiver Infosatz betriebsuebergreifend */
);


/* Fixer Lieferant */ /* Fixer Lieferant */ /* Falls Zurordnung Orderbuch eindeutig dann dieseen GP_2 */
/* Falls Zurordnung Orderbuch eindeutig dann dieseen GP_2 */ MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (
    SELECT
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat,
        COUNT(E.mandant_id) AS anz_ek_orderbuch,
        MAX(E.gp_id) AS bq_gp_id,
        MAX(E.einkaufsorganisation_id) AS bq_ekorg,
        MAX(CASE
            WHEN E.fix_gp_fg = 1
                THEN E.gp_id
            ELSE 0
        END) AS fix_gp_id,
        MAX(CASE
            WHEN E.fix_gp_fg = 1
                THEN E.einkaufsorganisation_id
            ELSE 0
        END) AS fix_ekorg
    FROM `_kmo_art_gp_wup_zu_3` AS AGW
    INNER JOIN dbp_data.ek_orderbuch_2 AS E
        ON
            AGW.mandant_id = E.mandant_id AND AGW.art_id = E.art_id AND
            AGW.ref_wup_id = E.wup_id AND E.gesperrt_fg = 0 AND AGW.dat BETWEEN E.dat_von AND E.dat_bis
    WHERE
        AGW.anz_ek_infosatz > 1 /* 1:n Zuordnung Einkaufsinfosatz */
        AND AGW.bq_findung_id = 0
    GROUP BY
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat = b.dat
        AND A.anz_ek_infosatz > 1 -- wenn nur ein gueltiger Orderbucheintrag vorhanden ist, GP_2 uebernehmen

-- Sollte ein fixer Lieferant gepflegt sein, so hat dieser Vorrang und

-- die Zuordnung zum Orderbuch wird als eindeutig betrachtet, egal ob
-- mehrere Einträge vorhanden sind

-- (es gibt lt. Aussage von EKSAP nur einen fixen Lieferant pro Zeitpunkt)

WHEN MATCHED THEN UPDATE SET
    anz_ek_orderbuch = CASE
        WHEN b.fix_gp_id > 0
            THEN 1
        ELSE CAST(b.anz_ek_orderbuch AS INTEGER)
    END,
    bq_gp_id = CASE
        WHEN b.fix_gp_id > 0
            THEN b.fix_gp_id
        ELSE CASE
            WHEN b.anz_ek_orderbuch = 1
                THEN b.bq_gp_id
            ELSE 0
        END
    END,
    bq_ekorg = CASE
        WHEN b.fix_gp_id > 0
            THEN b.fix_ekorg
        ELSE CASE
            WHEN b.anz_ek_orderbuch = 1
                THEN b.bq_ekorg
            ELSE 0
        END
    END,
    bq_findung_id = CASE
        WHEN b.anz_ek_orderbuch = 1 OR b.fix_gp_id > 0
            THEN 7
        ELSE 0
    END;


-- GROUP BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat

-- QUALIFY CSUM(1, COALESCE(ek.ek_infosatz_id, ekk.ek_infosatz_id) DESC) = 1) b
-- maximale Infosatz ID ermitteln

MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (SELECT
    AGW.mandant_id,
    AGW.art_id,
    AGW.wup_id,
    AGW.nb_id,
    AGW.dat,
    COALESCE(EK.bq_gp_id, EKK.bq_gp_id) AS bq_gp_id_,
    COALESCE(EK.bq_ekorg, EKK.bq_ekorg) AS bq_ekorg_
FROM `_kmo_art_gp_wup_zu_3` AS AGW
INNER JOIN dbp_data.ek_orderbuch_2 AS E
    ON
            AGW.mandant_id = E.mandant_id AND AGW.art_id = E.art_id AND
            AGW.ref_wup_id = E.wup_id AND E.gesperrt_fg = 0 AND AGW.dat BETWEEN E.dat_von AND E.dat_bis
    /* hoechster aktiver Infosatz betriebsspezifisch */
    LEFT JOIN `_kmo_ek_infosatz` AS EK
        ON
            AGW.mandant_id = EK.mandant_id AND AGW.ref_wup_id = EK.wup_id AND AGW.art_id =
            EK.art_id AND E.gp_id = EK.bq_gp_id AND AGW.dat = EK.dat AND EK.ek_infosatz_art = 3
    /* hoechster aktiver Infosatz betriebsspezifisch */ /* hoechster aktiver Infosatz betriebsuebergreifend */
    LEFT JOIN `_kmo_ek_infosatz` AS EKK
        ON
            AGW.mandant_id = EKK.mandant_id AND EKK.wup_id = 0 AND AGW.art_id = EKK.art_id
            AND E.gp_id = EKK.bq_gp_id AND AGW.dat = EKK.dat AND EKK.ek_infosatz_art = 3
    /* hoechster aktiver Infosatz betriebsuebergreifend */
    WHERE
        AGW.anz_ek_infosatz > 1 /* 1:n Zuordnung Einkaufsinfosatz */
        AND AGW.anz_ek_orderbuch > 1 /* 1:n Zuordnung Orderbuch im vorigen Schritt ermittelt */
        AND AGW.bq_findung_id = 0 /* kein Fixer Lieferant (s.o.) */
        AND (EK.mandant_id IS NOT NULL OR EKK.mandant_id IS NOT NULL)
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY AGW.mandant_id, AGW.art_id, AGW.wup_id, AGW.nb_id, AGW.dat ORDER BY COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id) IS NULL DESC, COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id) DESC)) = 1)
    AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat = b.dat
        AND A.bq_findung_id = 0
WHEN MATCHED THEN UPDATE SET
    bq_gp_id = b.bq_gp_id_,
    bq_ekorg = b.bq_ekorg_,
    bq_findung_id = 5;


--select * from DBP_DATA._kmo_art_gp_wup_zu_3 where art_id = 97000760 and mandant_id = 3


/* hoechster aktiver Infosatz betriebsspezifisch */ MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (
    SELECT
        AGW.mandant_id,
        AGW.art_id,
        AGW.wup_id,
        AGW.nb_id,
        AGW.dat,
        AGW.bezugsweg_id,
        COALESCE(EK.bq_gp_id, EKK.bq_gp_id) AS bq_gp_id_,
        COALESCE(EK.bq_ekorg, EKK.bq_ekorg) AS bq_ekorg_
    FROM `_kmo_art_gp_wup_zu_3` AS AGW
    LEFT JOIN `_kmo_ek_infosatz` AS EK
        ON
            AGW.mandant_id = EK.mandant_id AND AGW.ref_wup_id = EK.wup_id AND AGW.art_id =
            EK.art_id AND AGW.dat = EK.dat AND EK.ek_infosatz_art = 3 /* hoechster aktiver Infosatz betriebsspezifisch */
        /* hoechster aktiver Infosatz betriebsuebergreifend */
    LEFT JOIN `_kmo_ek_infosatz` AS EKK
        ON
            AGW.mandant_id = EKK.mandant_id AND EKK.wup_id = 0 AND AGW.art_id = EKK.art_id
            AND AGW.dat = EKK.dat AND EKK.ek_infosatz_art = 3 /* hoechster aktiver Infosatz betriebsuebergreifend */
    WHERE
        AGW.anz_ek_infosatz > 1
        AND AGW.bq_findung_id = 0
        AND AGW.anz_ek_orderbuch <> 1 -- GROUP BY agw.mandant_id,agw.art_id,agw.wup_id,agw.nb_id,agw.dat,agw.bezugsweg_id

        /* QUALIFY CSUM(1, COALESCE(ek.ek_infosatz_id, ekk.ek_infosatz_id) DESC
                       , COALESCE(ek.dat_erstellung, ekk.dat_erstellung) DESC) = 1) b */

    QUALIFY (ROW_NUMBER() OVER (
        PARTITION BY AGW.mandant_id, AGW.art_id, AGW.wup_id, AGW.nb_id, AGW.dat, AGW.bezugsweg_id
        ORDER BY
            COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id) IS NULL DESC, COALESCE(EK.ek_infosatz_id, EKK.ek_infosatz_id
            ) DESC, COALESCE(EK.dat_erstellung, EKK.dat_erstellung) IS NULL DESC, COALESCE(EK.dat_erstellung, EKK.dat_erstellung
            ) DESC
    )) = 1
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.art_id = b.art_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id AND A.dat = b.dat
        AND A.anz_ek_infosatz > 1 AND A.bq_findung_id = 0 AND A.anz_ek_orderbuch <> 1
WHEN MATCHED THEN UPDATE SET
    bq_gp_id = CASE
        WHEN A.anz_ek_orderbuch > 1 OR A.regel_gp_id = 0
            THEN b.bq_gp_id_
        ELSE A.regel_gp_id
    END,
    bq_ekorg = CASE
        WHEN A.anz_ek_orderbuch > 1 OR A.regel_ekorg = 0
            THEN b.bq_ekorg_
        ELSE A.regel_ekorg
    END,
    bq_findung_id = CASE
        WHEN A.anz_ek_orderbuch = 0 AND A.regel_gp_id = 0
            THEN 9
        WHEN A.anz_ek_orderbuch = 0 AND A.regel_gp_id > 0
            THEN 11
        WHEN A.anz_ek_orderbuch > 0
            THEN 5 /* falls oben nicht alle gefunden werden */
        ELSE NULL
    END;


INSERT INTO `_kmo_art_gp_wup_zu_3`
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat,
    bezugsweg_id,
    anz_ek_infosatz,
    anz_ek_orderbuch,
    bq_gp_id,
    bq_ekorg,
    bq_findung_id,
    regel_gp_id,
    regel_ekorg,
    COALESCE(ref_wup_id, -1) AS ref_wup_id,
    ref_nb_id,
    kreistyp_gruppe_id,
    wg_id
FROM `_kmo_art_gp_wup_oh_bzw`);


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_gp_id = G.gp_id,
    bq_ekorg = G.einkaufsorganisation_id
FROM dbp_data.gp_2 AS G
WHERE `_kmo_art_gp_wup_zu_3`.mandant_id = G.mandant_id AND `_kmo_art_gp_wup_zu_3`.bq_findung_id = 0 AND G.gp_id = -1;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_findung_id = 25 /* Kennzeichen, dass BQ Findung nicht erfolgreich ist */
WHERE bq_findung_id = 0;


/* Nummernkreis für Bezugsweg 4 um 12 versetzt */ -- Ermittlung betriebsspezifischer ZEKP_2 Satz mit VZ aus

/* Wenn ZEKP_2 nicht mit Betrieb/VZ gefunden wird +1 */ -- VZ Findung bei Bezugsweg 4 und Betrieb bei Bezugsweg 1

MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (
    SELECT
        A0.mandant_id,
        A0.wup_id,
        A0.nb_id,
        A0.art_id,
        A0.dat,
        A0.bq_findung_id + CASE
            WHEN AGW.mandant_id IS NULL
                THEN 1
            ELSE 0
        END + CASE
            WHEN A0.bezugsweg_id = 1
                THEN 0
            ELSE 12
        END AS bq_findung_id_
    FROM `_kmo_art_gp_wup_zu_3` AS A0
    LEFT JOIN `_art_gp_wup_zu_per` AS AGW
        ON A0.mandant_id = AGW.mandant_id AND A0.ref_wup_id = AGW.wup_id
        /* hier Zugriff mit Wup_2/VZ aus Kreisprozess !! */ AND A0.ref_nb_id = AGW.nb_id AND A0.art_id = AGW.art_id AND
        A0.bq_gp_id = AGW.gp_id AND A0.bq_ekorg = AGW.einkaufsorganisation_id AND A0.dat BETWEEN AGW.dat_von AND AGW.dat_bis
        -- Betrieb = blank für Bezugsweg 1 und 4 beim ersten
        -- Zugriff nichts gefunden wird.

    LEFT JOIN `_art_gp_wup_zu_per` AS AGWW
        ON A0.mandant_id = AGWW.mandant_id AND AGWW.wup_id = -1
        /* Betrieb = 'blank' */ AND A0.art_id = AGWW.art_id AND A0.bq_gp_id = AGWW.gp_id AND A0.bq_ekorg = AGWW.einkaufsorganisation_id
        AND A0.dat BETWEEN AGWW.dat_von AND AGWW.dat_bis
    WHERE A0.bq_findung_id <> 25
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.art_id = b.art_id AND A.dat = b.dat AND A.bq_findung_id <>
        25
WHEN MATCHED THEN UPDATE SET
    bq_findung_id = b.bq_findung_id_;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_findung_id = 27 FROM (
    SELECT
        EIN.mandant_id,
        EIN.art_id,
        A.dat_relevant AS dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS A
    INNER JOIN dbp_data.art_man_spanne_per_2 AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' /* einstandspreis */
            AND EIN.loesch_fg = 0 AND A.dat_relevant BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_man_spanne_per_2 AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.art_id = MEP.art_id
            AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A.dat_relevant BETWEEN MEP.dat_von AND
            MEP.dat_bis
    LEFT JOIN dbp_data.art_man_spanne_per_2 AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.art_id =
            EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg = 0 AND A.dat_relevant
            BETWEEN EKBNK.dat_von AND EKBNK.dat_bis
    WHERE EIN.mandant_id > 1
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.art_id = b.art_id AND
    `_kmo_art_gp_wup_zu_3`.dat = b.dat;


/* optional */ -- Nun die betriebsuebergreifenden manuellen Spannenfaktoren
/* optional */
/* Einstandspreis zwingend erforderlich */ MERGE INTO `_kmo_art_gp_wup_zu_3` AS A
USING (
    SELECT
        EIN.mandant_id,
        EIN.wup_id,
        EIN.art_id,
        A0.dat_relevant AS dat,
        EIN.ek_faktor AS zwgs,
        COALESCE(MEP.ek_faktor, EIN.ek_faktor) AS zwgm,
        COALESCE(EKBNK.ek_faktor, MEP.ek_faktor, EIN.ek_faktor) AS zwge
    FROM dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS A0
    INNER JOIN dbp_data.art_wup_man_spanne_per_2 AS EIN
        ON
            EIN.konditionsart_id = 'ZWGS' /* einstandspreis */
            AND EIN.loesch_fg = 0 AND A0.dat_relevant BETWEEN EIN.dat_von AND EIN.dat_bis
    LEFT JOIN dbp_data.art_wup_man_spanne_per_2 AS MEP
        ON
            EIN.mandant_id = MEP.mandant_id AND EIN.wup_id =
            MEP.wup_id AND EIN.art_id = MEP.art_id AND MEP.konditionsart_id = 'ZWGM' /* MEP */ AND MEP.loesch_fg = 0 AND A0.dat_relevant BETWEEN MEP.dat_von AND MEP.dat_bis
    LEFT JOIN dbp_data.art_wup_man_spanne_per_2 AS EKBNK
        ON
            EIN.mandant_id = EKBNK.mandant_id AND EIN.wup_id
            = EKBNK.wup_id AND EIN.art_id = EKBNK.art_id AND EKBNK.konditionsart_id = 'ZWGE' /* eknetto bnk */ AND EKBNK.loesch_fg
            = 0 AND A0.dat_relevant BETWEEN EKBNK.dat_von AND EKBNK.dat_bis
    WHERE EIN.mandant_id > 1
) AS b
    ON A.mandant_id = b.mandant_id AND A.wup_id = b.wup_id AND A.art_id = b.art_id AND A.dat = b.dat
WHEN MATCHED THEN UPDATE SET
    bq_findung_id = 26;


UPDATE `_kmo_art_gp_wup_zu_3` SET
    bq_findung_id = 2,
    ref_wup_id = -1 FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        A.art_id
    FROM `_kmo_art_gp_wup_zu_3` AS A
    INNER JOIN `_art_gp_wup_zu_per` AS B
        ON
            A.mandant_id = B.mandant_id AND A.ref_wup_id = B.wup_id AND A.bq_gp_id = B.gp_id
            AND A.art_id = B.art_id AND A.dat BETWEEN B.dat_von AND B.dat_bis
    LEFT JOIN (
        SELECT *
        FROM `_kmo_ek_infosatz`
        WHERE ek_infosatz_art = 1
    ) AS c
        ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id AND A.ref_wup_id = c.wup_id
    WHERE
        A.anz_ek_infosatz = 1
        AND A.bq_findung_id = 1
        AND A.bezugsweg_id = 1
        AND c.wup_id IS NULL
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.wup_id
) AS b
WHERE
    `_kmo_art_gp_wup_zu_3`.mandant_id = b.mandant_id AND `_kmo_art_gp_wup_zu_3`.wup_id = b.wup_id AND
    `_kmo_art_gp_wup_zu_3`.art_id = b.art_id;


CREATE TEMPORARY TABLE IF NOT EXISTS _snapshot_art_gp AS
SELECT
    A.mandant_id,
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.dat_von,
    A.gp_id,
    A.einkaufsorganisation_id,
    A.dat_bis,
    A.vz_wup_id,
    A.bq_findung_id,
    A.bezugsweg_id,
    A.td_update,
    A.td_insert
FROM dbp_data.art_gp_nm_zu_per_2 AS A
INNER JOIN dbp_etl.art_gp_nm_zu_per_dat_relevant_2 AS B ON A.dat_bis >= B.dat_relevant
WHERE A.mandant_id > 1;


INSERT INTO `_kmo_art_gp_wup_zu_3x`
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.wup_id,
        A.nb_id,
        A.dat,
        A.bezugsweg_id,
        A.anz_ek_infosatz,
        A.anz_ek_orderbuch,
        A.bq_gp_id,
        A.bq_ekorg,
        A.bq_findung_id,
        A.regel_gp_id,
        A.regel_ekorg,
        A.ref_wup_id,
        A.ref_nb_id,
        A.kreistyp_gruppe_id,
        A.wg_id
    FROM `_kmo_art_gp_wup_zu_3` AS A
    INNER JOIN `_snapshot_art_gp` AS Z
        ON
            A.mandant_id = Z.mandant_id AND A.wup_id = Z.wup_id AND A.art_id = Z.art_id AND
            A.dat BETWEEN Z.dat_von AND Z.dat_bis
    WHERE
        A.bq_gp_id <> Z.gp_id
        OR -- geaenderter Lieferant
        A.bq_findung_id <> COALESCE(Z.bq_findung_id, -1)
        OR -- geaenderter Ausstiegspunkt
        A.ref_wup_id <> COALESCE(Z.vz_wup_id, -1)
        OR -- geaendertes Liefer VZ
        A.bezugsweg_id <> Z.bezugsweg_id -- geaenderter Bezugsweg
);


INSERT INTO `_kmo_art_gp_wup_zu_3x`
(
    SELECT *
    FROM `_kmo_art_gp_wup_zu_3` AS A
    WHERE (
        mandant_id, wup_id, art_id) NOT IN (
        SELECT (mandant_id, wup_id, art_id)
        FROM `_snapshot_art_gp`
    )
);


/* nur die Historie, die nicht neu kommt uebernehmen */ INSERT INTO `_art_gp_nm_zu_per_tmp` (
    mandant_id, art_id, wup_id,
    nb_id, dat_von, gp_id, einkaufsorganisation_id, dat_bis, bq_findung_id, vz_wup_id, bezugsweg_id
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_von,
    gp_id,
    einkaufsorganisation_id,
    PARSE_DATE('%Y%m%d', '99991231') AS dat_bis,
    COALESCE(bq_findung_id, -1) AS bq_findung_id,
    COALESCE(vz_wup_id, -1) AS vz_wup_id,
    /* dat_bis wird spaeter neu geschnitten */ bezugsweg_id
FROM dbp_data.art_gp_nm_zu_per_2
WHERE (
    mandant_id, wup_id, art_id) IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_kmo_art_gp_wup_zu_3x`
)
AND mandant_id > 1
AND (
    mandant_id, wup_id, art_id, dat_von) NOT IN (
    SELECT (mandant_id, wup_id, art_id, dat)
    FROM `_kmo_art_gp_wup_zu_3x`
));


INSERT INTO `_art_gp_nm_zu_per_tmp` (
    mandant_id, art_id, wup_id, nb_id, dat_von, gp_id, einkaufsorganisation_id, dat_bis,
    bq_findung_id, vz_wup_id, bezugsweg_id
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat AS dat_von,
    bq_gp_id AS gp_id,
    bq_ekorg AS einkaufsorganisation_id,
    PARSE_DATE('%Y%m%d', '99991231') AS dat_bis,
    bq_findung_id,
    ref_wup_id,
    bezugsweg_id
FROM `_kmo_art_gp_wup_zu_3x`);


-- Falls mehrere neue Zuordnungen in ein bestehendes Intervall fallen

/* letzten Datesatz nicht einfuegen, dieser wird ersetzt */ INSERT INTO `_art_gp_nm_zu_per_tmp` (
    mandant_id, art_id,
    wup_id, nb_id, dat_von, gp_id, einkaufsorganisation_id, dat_bis, bq_findung_id, vz_wup_id, bezugsweg_id
)
(
    SELECT
        Z.mandant_id,
        Z.art_id,
        Z.wup_id,
        Z.nb_id,
        DATE_ADD(A.dat, INTERVAL 1 DAY) AS dat_von_,
        Z.gp_id,
        Z.einkaufsorganisation_id,
        PARSE_DATE('%Y%m%d', '99991231') AS dat_bis_,
        COALESCE(Z.bq_findung_id, -1),
        COALESCE(Z.vz_wup_id, -1),
        Z.bezugsweg_id
    FROM `_kmo_art_gp_wup_zu_3x` AS A
    INNER JOIN dbp_data.art_gp_nm_zu_per_2 AS Z
        ON
            A.mandant_id = Z.mandant_id AND A.wup_id = Z.wup_id AND A.art_id = Z.art_id AND A.dat >= Z.dat_von AND /* innerhalb eines bestehenden Zeitraums */ A.dat < Z.dat_bis AND
            Z.dat_bis < PARSE_DATE(
                '%Y%m%d', '99991231') AND (
                A.bq_gp_id <> Z.gp_id OR /* geaenderter Lieferant */ A.bq_findung_id
                <> COALESCE(Z.bq_findung_id, -1) OR /* geaenderter Ausstiegspunkt */ A.ref_wup_id <> COALESCE(Z.vz_wup_id, -1
                ) OR /* geaendertes Liefer VZ */ A.bezugsweg_id <> Z.bezugsweg_id
            )
    WHERE
        Z.mandant_id > 1
        AND (Z.mandant_id, Z.art_id, Z.wup_id, DATE_ADD(A.dat, INTERVAL 1 DAY)) NOT IN (SELECT (
            mandant_id, art_id, wup_id,
            dat_von
        )
        FROM `_art_gp_nm_zu_per_tmp`)
    GROUP BY
        Z.mandant_id,
        Z.wup_id,
        Z.nb_id,
        Z.art_id,
        Z.gp_id,
        Z.einkaufsorganisation_id,
        COALESCE(Z.bq_findung_id, -1),
        COALESCE(Z.vz_wup_id, -1),
        dat_von_,
        dat_bis_,
        Z.bezugsweg_id
);


-- bei Lieferung, Ausstiegspunkt, Liefer VZ aufweisen
-- COALESCE(MDIFF(gp_id, 1, dat_von ASC), 1) AS gp_wechsel_fg,

-- COALESCE(MDIFF(bq_findung_id, 1, dat_von ASC), 1) AS bq_findung_wechsel_fg,
-- zum Vorgänger aufweisen.

-- MDIFF(x, w, y) is equivalent to:  x - SUM(x) OVER (ORDER BY y ROWS BETWEEN w PRECEDING AND w PRECEDING)

-- kein Vorgänger da ist, oder die einen Lieferantenwechsel im Vergleich

-- COALESCE(MDIFF(vz_wup_id, 1, dat_von ASC), 1) AS vz_wup_wechsel_fg,

-- Alle Datensätze markieren, die entweder keinen Wechsel haben, weil
/* GROUP BY mandant_id,art_id,wup_id */
-- Nur die Datensätze sind relevant, die einen Wechsel

-- COALESCE(MDIFF(bezugsweg_id, 1, dat_von ASC), 1) AS bezugsweg_wechsel_fg
INSERT INTO `_art_gp_nm_zu_per_tmp2` (
    mandant_id,
    art_id, wup_id, nb_id, dat_von, gp_id, einkaufsorganisation_id, dat_bis, bq_findung_id, vz_wup_id, bezugsweg_id
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_von,
    gp_id,
    einkaufsorganisation_id,
    dat_bis,
    bq_findung_id,
    vz_wup_id,
    bezugsweg_id
FROM `_art_gp_nm_zu_per_tmp`
QUALIFY COALESCE(gp_id - (SUM(gp_id) OVER (
    PARTITION BY mandant_id, art_id, wup_id ORDER BY dat_von IS NULL, dat_von
    ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)), 1) <> 0 OR COALESCE(bq_findung_id - (SUM(bq_findung_id) OVER (
    PARTITION BY
        mandant_id, art_id, wup_id
    ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING
)), 1)
<> 0 OR COALESCE(vz_wup_id - (SUM(vz_wup_id) OVER (PARTITION BY
    mandant_id, art_id, wup_id ORDER BY
    dat_von
    IS NULL, dat_von
ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING)), 1) <> 0 OR COALESCE(bezugsweg_id - (SUM(bezugsweg_id
) OVER (
    PARTITION BY mandant_id, art_id, wup_id ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND 1
    PRECEDING
)), 1) <> 0);


UPDATE `_art_gp_nm_zu_per_tmp2` AS `_art_gp_nm_zu_per_tmp20` SET
    dat_bis = dt1.dat_bis_ FROM (SELECT
    mandant_id,
    wup_id,
    art_id,
    dat_von,
    CASE
        WHEN (SUM(ROUND(CAST(
            FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id,
            art_id
        ORDER BY dat_von IS NULL, dat_von
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) - ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC),
        0) = 0
            THEN PARSE_DATE('%F', '9999-12-31')
        ELSE DATE_ADD(DATE(CAST((SUM(ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0)) OVER (PARTITION BY
            mandant_id, wup_id, art_id
        ORDER BY dat_von IS NULL, dat_von ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)) -
        ROUND(CAST(FORMAT_DATE('%Y%m%d', dat_von) AS BIGNUMERIC), 0) AS STRING)), INTERVAL -1 DAY)
    END AS dat_bis_
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        dat_von
    FROM `_art_gp_nm_zu_per_tmp2`
    GROUP BY
        mandant_id,
        art_id,
        wup_id,
        dat_von
) AS t0) AS dt1
WHERE
    `_art_gp_nm_zu_per_tmp20`.mandant_id = dt1.mandant_id AND `_art_gp_nm_zu_per_tmp20`.wup_id = dt1.wup_id AND
    `_art_gp_nm_zu_per_tmp20`.art_id = dt1.art_id AND `_art_gp_nm_zu_per_tmp20`.dat_von = dt1.dat_von AND
    `_art_gp_nm_zu_per_tmp20`.dat_bis <> dt1.dat_bis_;


DELETE FROM dbp_data.art_gp_nm_zu_per_2 AS A
WHERE (
    mandant_id, wup_id, art_id) IN (
    SELECT (mandant_id, wup_id, art_id)
    FROM `_kmo_art_gp_wup_zu_3x`
);


INSERT INTO dbp_data.art_gp_nm_zu_per_2 (
    mandant_id, art_id, wup_id, nb_id, dat_von, gp_id,
    einkaufsorganisation_id, dat_bis, vz_wup_id, bq_findung_id, bezugsweg_id, td_update, td_insert
)
(SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_von,
    gp_id,
    einkaufsorganisation_id,
    dat_bis,
    vz_wup_id,
    bq_findung_id,
    bezugsweg_id,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_art_gp_nm_zu_per_tmp2`);
