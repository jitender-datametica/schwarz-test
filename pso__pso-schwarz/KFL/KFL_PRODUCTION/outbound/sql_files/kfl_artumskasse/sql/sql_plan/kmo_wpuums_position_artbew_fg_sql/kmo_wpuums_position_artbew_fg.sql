/*
#------------------------------------------------------------------------------
# 2.) Neuanlegen der Lade Tabellen DBP_ETL.position_artbew_bon und
#     kmo_artbew_bon_promotion
#------------------------------------------------------------------------------
*/


-- Informationen stammen aus Bon Kopf
CREATE OR REPLACE TABLE dbp_etl.position_artbew_bon (
    mandant_id INTEGER,
    bon_id STRING(25),
    dat_booking DATE,
    wup_id INTEGER,
    bon_zeile INTEGER,
    kl_art_id INTEGER,
    ean_kasse INTEGER,
    menge NUMERIC(29, 4),
    umsatz_brutto NUMERIC(29, 4),
    wg_id INTEGER,
    lkp_art_id INTEGER,
    lkp_nb_id INTEGER,
    lkp_wg_id INTEGER,
    lkp_arthiertyp_id INTEGER,
    lkp_zek_id INTEGER,
    lkp_mwst_id INTEGER,
    lkp_posten_id STRING(4),
    lkp_umrechnungskurs FLOAT64,
    lkp_mwst NUMERIC(29, 2),
    lkp_wrg STRING(3)
);


-- Tabelle fuer die relevanten Promotionsbetraege


CREATE OR REPLACE TABLE dbp_etl.position_artbew_bon_promotion (
    mandant_id INTEGER,
    bon_id STRING(25),
    dat_booking DATE,
    kl_art_id INTEGER,
    bon_zeile INTEGER,
    bonuskauf_id STRING(20),
    konditionsart_id STRING(10),
    umsatz_brutto NUMERIC(29, 4),
    umsatz_promo_brutto NUMERIC(29, 4),
    menge_promo NUMERIC(29, 3)
);


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabelle
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE dbp_etl.position_artbew_bon_dat (
    dat DATE NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.position_artbew_bon_delta (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_booking DATE NOT NULL,
    xml_name STRING(255)
);


/*
#------------------------------------------------------------------------------
# 3.) Relevante Markttage ermitteln
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_etl.position_artbew_bon_delta (mandant_id, wup_id, dat_booking, xml_name)
(
    SELECT
        K.mandant_id,
        K.wup_id,
        K.dat_booking,
        B.xml_name
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.bon_id = T.bon_id AND K.mandant_id = T.mandant_id AND
            K.wup_id = T.wup_id AND T.mandant_id = 3 AND T.kassensystem_name = 'POSITION'
    INNER JOIN dbp_ods.bon_load_status AS B ON T.datei_name = B.xml_name AND B.artbew_fg = 0
    WHERE
        K.mandant_id = 3
        AND K.dat_booking <= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
    GROUP BY
        K.mandant_id,
        K.wup_id,
        K.dat_booking,
        B.xml_name
);


/*
#------------------------------------------------------------------------------
# 3.) Befuellen der temporaeren Tabelle kmo_artbew_bon
#     Es werden nur Kopf und Zeile zusammengefasst und untersucht, die
#     Promotionsbetraege sind direkt von der Zeile abgeleitet und werden
#     abschliend fuer die RFI geprueften Zeilen ermittelt.
#------------------------------------------------------------------------------
*/


-- pro Mandant kann hier ein spezieller Filter eingebaut werden

-- pro Mandant kann hier ein spezieller Filter eingebaut werden
-- Gesamten Markttag holen
-- Gesamten Markttag holen

INSERT INTO dbp_etl.position_artbew_bon (
    mandant_id, bon_id, dat_booking, wup_id, bon_zeile, kl_art_id,
    ean_kasse, menge, umsatz_brutto, wg_id
)
(SELECT
    mandant_id,
    bon_id,
    dat_booking,
    wup_id,
    bon_zeile,
    kl_art_id,
    CAST(ean_kasse AS INTEGER) AS ean_kasse,
    CAST(menge_ AS NUMERIC) AS menge_,
    CAST(umsatz_brutto_ AS NUMERIC) AS umsatz_brutto_,
    wg_id
FROM (
    SELECT
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.wup_id,
        Z.kl_art_id,
        Z.ean_kasse,
        Z.bon_zeile,
        CASE
            WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                THEN Z.menge * -1
            ELSE Z.menge
        END AS menge_,
        CASE
            WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                THEN Z.umsatz_brutto * -1
            ELSE Z.umsatz_brutto
        END AS umsatz_brutto_,
        Z.wg_id
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            dat_booking
        FROM dbp_etl.position_artbew_bon_delta
        GROUP BY
            mandant_id,
            wup_id,
            dat_booking
    ) AS d ON K.mandant_id = d.mandant_id AND K.wup_id = d.wup_id AND K.dat_booking = d.dat_booking
    INNER JOIN dbp_ods.ods_bon_verkauf AS Z
        ON
            K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND K.wup_id = Z.wup_id
    INNER JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id
            AND K.wup_id = T.wup_id
    WHERE
        K.mandant_id = 3
        AND K.kunde_fg = 1
        AND K.turnover_fg = 1
        AND CASE
            WHEN
                K.mandant_id = 8 OR K.mandant_id = 3 AND K.kasse_nr NOT IN (
                    241) OR K.mandant_id = 7 AND K.kasse_nr NOT IN (241,
                242) OR K.mandant_id = 2 AND K.kasse_nr NOT IN (241, 242) OR K.mandant_id = 6 AND K.kasse_nr NOT IN (
                    241,
                    242
                ) OR K.mandant_id = 5 AND K.kasse_nr NOT IN (241, 242
                )
                THEN 1
            ELSE 0
        END = 1
        AND (
            K.bon_id, K.wup_id) NOT IN (
            SELECT (bon_id, wup_id)
            FROM dbp_ods.ods_bon_storno
        )
    UNION DISTINCT
    SELECT
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.wup_id,
        Z.kl_art_id,
        Z.ean_kasse,
        Z.bon_zeile -- Mengen Flag beruecksichtigen (Vorgabe David vom 18.03.)
        ,
        CASE
            WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                THEN Z.menge * -1
            ELSE Z.menge
        END * Z.menge_fg AS menge_,
        CASE
            WHEN K.kunde_fg = 0 /* zeilenstornor_fg = 1 */
                THEN Z.umsatz_brutto * -1
            ELSE Z.umsatz_brutto
        END AS umsatz_brutto_,
        Z.wg_id
    FROM dbp_ods.ods_bon_kopf AS K
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            dat_booking
        FROM dbp_etl.position_artbew_bon_delta
        GROUP BY
            mandant_id,
            wup_id,
            dat_booking
    ) AS d ON K.mandant_id = d.mandant_id AND K.wup_id = d.wup_id AND K.dat_booking = d.dat_booking
    INNER JOIN dbp_ods.ods_bon_retoure AS Z
        ON
            K.mandant_id = Z.mandant_id AND K.bon_id = Z.bon_id AND K.wup_id = Z.wup_id
    INNER JOIN dbp_ods.ods_bon_transaction AS T
        ON
            K.mandant_id = T.mandant_id AND K.bon_id = T.bon_id
            AND K.wup_id = T.wup_id
    WHERE
        K.mandant_id = 3
        AND K.kunde_fg = 1
        AND K.turnover_fg = 1
        AND CASE
            WHEN
                K.mandant_id = 8 OR K.mandant_id = 3 AND K.kasse_nr NOT IN (
                    241) OR K.mandant_id = 7 AND K.kasse_nr NOT IN (241,
                242) OR K.mandant_id = 2 AND K.kasse_nr NOT IN (241, 242) OR K.mandant_id = 6 AND K.kasse_nr NOT IN (
                    241,
                    242
                ) OR K.mandant_id = 5 AND K.kasse_nr NOT IN (241, 242
                )
                THEN 1
            ELSE 0
        END = 1
        AND (
            K.bon_id, K.wup_id) NOT IN (
            SELECT (bon_id, wup_id)
            FROM dbp_ods.ods_bon_storno
        )
) AS t9);


/*
#------------------------------------------------------------------------------
# 8.) Anreichern der Ladetabelle mit den Lookupschluesseln
#     mandant_id, art_id, wup_id, nb_id, zek_id, wg_id
#------------------------------------------------------------------------------
*/

-- wup_id, nb_id


UPDATE dbp_etl.position_artbew_bon SET
    lkp_nb_id = W.nb_id
FROM dbp_data.wup AS W
WHERE position_artbew_bon.mandant_id = W.mandant_id AND position_artbew_bon.wup_id = W.wup_id;


-- art_id, zek_id, mwst_id, posten_id


UPDATE dbp_etl.position_artbew_bon SET
    lkp_art_id = t0.art_id,
    lkp_zek_id = CAST(t0.zek_id AS INTEGER),
    lkp_mwst_id = t0.mwst_id,
    lkp_posten_id = t0.posten_id FROM (SELECT
    mandant_id,
    kl_art_id,
    art_id,
    zek_id,
    mwst_id,
    posten_id
FROM dbp_data.art AS A
QUALIFY (ROW_NUMBER() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1) AS t0
WHERE position_artbew_bon.mandant_id = t0.mandant_id AND position_artbew_bon.kl_art_id = t0.kl_art_id;


-- wg_id, arthiertyp_id


UPDATE dbp_etl.position_artbew_bon SET
    lkp_wg_id = W.wg_id,
    lkp_arthiertyp_id = W.arthiertyp_id
FROM dbp_data.art_wg_zu_per AS W
WHERE
    position_artbew_bon.mandant_id = W.mandant_id AND position_artbew_bon.lkp_art_id = W.art_id AND W.dat_bis =
    DATE '9999-12-31' AND W.arthiertyp_id = 2;


-- Waehrung


UPDATE dbp_etl.position_artbew_bon SET
    lkp_wrg = M.default_wrg
FROM dbp_data.mandant AS M
WHERE position_artbew_bon.mandant_id = M.mandant_id;


-- Umrechnungskurs


UPDATE dbp_etl.position_artbew_bon SET
    lkp_umrechnungskurs = K.umrechnungskurs
FROM dbp_data.kurs AS K
WHERE
    position_artbew_bon.lkp_wrg = K.von_wrg_id AND position_artbew_bon.dat_booking BETWEEN K.dat_von AND K.dat_bis AND
    K.kurstyp_id = 9 AND K.nach_wrg_id = 'EUR';


-- MWST Satz


UPDATE dbp_etl.position_artbew_bon SET
    lkp_mwst = M.mwst
FROM dbp_data.mwst_per AS M
WHERE
    position_artbew_bon.mandant_id = M.mandant_id AND position_artbew_bon.lkp_mwst_id = M.mwst_id AND
    position_artbew_bon.dat_booking BETWEEN M.dat_von AND M.dat_bis;


/*
#------------------------------------------------------------------------------
# 10.) Befuellen der temporaeren Tabelle DBP_ETL.position_artbew_bon_dat
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_etl.position_artbew_bon_dat (dat)
(
    SELECT dat_booking
    FROM dbp_etl.position_artbew_bon
    GROUP BY dat_booking
);


/*
#------------------------------------------------------------------------------
# 14.) Ermittlung der Promotionsbetraege fuer die RFI geprueften Bonzeilen
#      Da die Datentypen korrekt sind und die Promotionsbetraege direkt von
#      den Bonzeilen abgeleitet ist keine separate RFI Pruefung erforderlich
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_etl.position_artbew_bon_promotion (
    mandant_id, bon_id, dat_booking, kl_art_id, bon_zeile,
    bonuskauf_id, konditionsart_id, umsatz_brutto, umsatz_promo_brutto, menge_promo
)
(
    SELECT
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.kl_art_id,
        K.bon_zeile,
        P.bonuskauf_id,
        P.konditionsart_id,
        CAST(SUM(P.betrag_promo_brutto * -1) AS NUMERIC) AS umsatz_brutto,
        SUM(P.umsatz_promo_brutto) AS umsatz_promo_brutto,
        SUM(P.menge_promo) AS menge_promo
    FROM dbp_etl.position_artbew_bon AS K
    INNER JOIN dbp_ods.ods_promotion AS P
        ON
            K.mandant_id = P.mandant_id AND K.bon_id = P.bon_id AND K.bon_zeile
            = P.bon_zeile
    WHERE COALESCE(P.betrag_promo_brutto, 0) <> 0
    GROUP BY
        K.mandant_id,
        K.bon_id,
        K.dat_booking,
        K.kl_art_id,
        K.bon_zeile,
        P.bonuskauf_id,
        P.konditionsart_id
);


/*
#------------------------------------------------------------------------------
# 2.) Erzeugen der temporaeren Tabellen
#------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE dbp_etl.position_artbew_bon_aktion_relevant (
    mandant_id INTEGER NOT NULL,
    aktion_id STRING(10) NOT NULL,
    bewart_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    anz_aktion INTEGER NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.artbew_position_tmp (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    aktion_id STRING(10) DEFAULT '          ' NOT NULL,
    promo_fg INTEGER DEFAULT 0 NOT NULL,
    ean_kasse INTEGER DEFAULT 0 NOT NULL,
    einkaufsorganisation_id INTEGER,
    herst_id INTEGER,
    mwst_id INTEGER NOT NULL,
    menge NUMERIC(29, 3),
    wrg STRING(3),
    umsatz_netto NUMERIC(29, 4),
    diff_umsatz_netto_konz NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    diff_umsatz_mwst_betrag_konz NUMERIC(29, 4),
    ek_brutto NUMERIC(29, 4),
    diff_ek_brutto_konz NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    diff_ek_netto_konz NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    diff_ek_nettonetto_konz NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    diff_ek_kal_basis_konz NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    diff_ek_mep_konz NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    diff_einstandspreis_konz NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    diff_logkostenzuschlag_konz NUMERIC(29, 4),
    bezugsweg_id INTEGER,
    ek_netto_bnk NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
    posten_id STRING(2),
    bq_findung_id INTEGER,
    ek_gld NUMERIC(29, 4),
    diff_ek_gld_konz NUMERIC(29, 4)
);


/*
#------------------------------------------------------------------------------
# 3.) Befuellen der tempoeraren Tabelle DBP_ETL.position_artbew_bon_aktion_relevant
#------------------------------------------------------------------------------
*/


-- Kennzeichen Zuordnung Aktion, Artikel, Wup aktiv
INSERT INTO dbp_etl.position_artbew_bon_aktion_relevant
(mandant_id, aktion_id, bewart_id, dat, art_id, wup_id, nb_id, anz_aktion)
(
    SELECT
        mandant_id,
        MAX(aktion_id) AS max_aktion_id,
        bewart_id,
        dat,
        art_id,
        wup_id,
        nb_id,
        MAX(zaehler) AS anz_aktion
    FROM (
        SELECT
            A.mandant_id,
            A.bewart_id,
            D.dat,
            AAW.art_id,
            AAW.wup_id,
            AAW.nb_id,
            A.aktion_id,
            ROW_NUMBER() OVER (
                PARTITION BY
                    A.mandant_id, A.bewart_id, AAW.art_id, AAW.wup_id, AAW.nb_id, D.dat ORDER BY
                    A.dat_von
                    IS NULL, A.dat_von
            ) AS zaehler
        FROM dbp_data.aktion AS A
        INNER JOIN dbp_data.aktion_art_wup_zu AS AAW
            ON
                A.mandant_id = AAW.mandant_id AND A.aktion_id = AAW.aktion_id
                AND A.bewart_id = AAW.bewart_id
        INNER JOIN dbp_etl.position_artbew_bon_dat AS D ON D.dat BETWEEN A.dat_von AND A.dat_bis
        WHERE
            A.mandant_id <> 1 -- nur KMO Mandanten

            AND A.bewart_id = 1002 -- Kennzeichen Aktion

            AND (UPPER(AAW.grund_sperrung) <> 'X' OR AAW.grund_sperrung IS NULL)
    ) AS a
    GROUP BY
        mandant_id,
        bewart_id,
        dat,
        art_id,
        wup_id,
        nb_id
);


/*
#------------------------------------------------------------------------------
# 5.) Befuellen der temporaeren Tabelle DBP_ETL.artbew_kmo_tmp
#------------------------------------------------------------------------------
*/


-- Ermittlung der Promotionsbetraege pro Bonzeile und Kennzeichnung promo_fg

-- Berechnung im Vergleich zur Wpuums auftreten.
-- ,umrechnungskurs

-- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0
-- Ermittlung Promotionsbetrag pro Bon Zeile

-- Mai 2011: Umsatz Brutto = Belegbetrag minus Betrag Promotion (Promo mit negativen Vorzeichen deshalb addieren!!!)

-- Bonzeilen zusammenfassen damit keine Rundungsdifferenzen bei der MWST

-- im abschlisenden Insert in die Zieltabelle verschluesselt initialisiert (s.u.)

/* Datenlieferung an Externe, kommt erst noch... */ -- ,umrechnungskurs

/* Kennzeichen ob in der Position ein Promotionsbetrag enthalten ist */ INSERT INTO dbp_etl.artbew_position_tmp
(
    wup_id, mandant_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id, promo_fg, ean_kasse, einkaufsorganisation_id,
    herst_id, mwst_id, menge, wrg, umsatz_netto, umsatz_mwst_betrag, bezugsweg_id, posten_id
)
(
    SELECT
        l.wup_id,
        l.mandant_id,
        COALESCE(R.bewart_id, 1001) AS bewart_id,
        -1 AS gp_id,
        l.lkp_nb_id AS nb_id,
        l.lkp_art_id AS art_id,
        l.dat_booking AS dat,
        CASE
            WHEN R.anz_aktion = 1 -- wenn genau eine Aktion vorhanden ist, diese eintragen

                THEN R.aktion_id
            ELSE ''
        END AS aktion_id,
        l.promo_fg,
        l.ean_kasse,
        -1 AS einkaufsorganisation_id,
        -1 AS herst_id,
        l.lkp_mwst_id AS mwst_id,
        l.menge_ AS menge,
        l.lkp_wrg AS wrg,
        CAST((l.umsatz_brutto_ + l.umsatz_promotion_brutto_) / (1 + l.lkp_mwst / 100) AS NUMERIC) AS umsatz_netto,
        l.umsatz_brutto_ + l.umsatz_promotion_brutto_ - CAST((l.umsatz_brutto_ + l.umsatz_promotion_brutto_) / (1 + l.lkp_mwst / 100) AS NUMERIC)
            AS umsatz_mwst_betrag,
        0 AS bezugsweg_id,
        COALESCE(l.lkp_posten_id, ' ') AS posten_id
    FROM (
        SELECT
            Z.mandant_id,
            Z.wup_id,
            Z.lkp_nb_id,
            Z.lkp_art_id,
            Z.lkp_posten_id,
            Z.dat_booking,
            Z.lkp_mwst,
            Z.lkp_mwst_id,
            Z.lkp_wrg,
            Z.lkp_umrechnungskurs,
            CASE
                WHEN COALESCE(p.promotion_brutto, 0) <> 0
                    THEN 1
                ELSE 0
            END AS promo_fg,
            Z.ean_kasse,
            SUM(Z.umsatz_brutto) AS umsatz_brutto_,
            SUM(Z.menge) AS menge_,
            SUM(COALESCE(p.promotion_brutto, 0)) AS umsatz_promotion_brutto_
        FROM dbp_etl.position_artbew_bon AS Z
        LEFT JOIN (
            SELECT
                mandant_id,
                bon_id,
                dat_booking,
                bon_zeile,
                SUM(umsatz_brutto) AS promotion_brutto
            FROM dbp_etl.position_artbew_bon_promotion
            GROUP BY
                mandant_id,
                bon_id,
                dat_booking,
                bon_zeile
        ) AS p
            ON
                Z.mandant_id = p.mandant_id AND Z.bon_id = p.bon_id AND Z.dat_booking = p.dat_booking AND Z.bon_zeile
                = p.bon_zeile
        GROUP BY
            Z.mandant_id,
            Z.wup_id,
            Z.lkp_nb_id,
            Z.lkp_art_id,
            Z.lkp_posten_id,
            Z.dat_booking,
            Z.lkp_mwst,
            Z.lkp_mwst_id,
            Z.lkp_wrg,
            Z.lkp_umrechnungskurs,
            promo_fg,
            Z.ean_kasse
    ) AS l
    LEFT JOIN
        dbp_etl.position_artbew_bon_aktion_relevant
            AS R
        ON
            l.mandant_id = R.mandant_id AND l.lkp_art_id
            = R.art_id AND l.wup_id = R.wup_id AND l.lkp_nb_id = R.nb_id AND l.dat_booking = R.dat
);


DELETE FROM dbp_data.artbew_promotion_zu AS A
WHERE
    A.konditionsart_id <> 'RB19'
    AND EXISTS (
        SELECT 1
        FROM dbp_etl.position_artbew_bon_dat p
        WHERE A.dat = p.dat
    )
    AND EXISTS (
        SELECT 1
        FROM dbp_etl.artbew_position_tmp t
        WHERE
            A.mandant_id = t.mandant_id
            AND A.wup_id = t.wup_id
            AND A.dat = t.dat
            AND t.promo_fg = 1
    );


/*
#------------------------------------------------------------------------------
# 8.) Befuellen der Miniatur-Artbew zur Ablage der Promotionswerte
#------------------------------------------------------------------------------
*/


INSERT INTO dbp_data.artbew_promotion_zu (
    art_id, mandant_id, wup_id, nb_id, dat, bonuskauf_id,
    konditionsart_id, ean_kasse, wrg_id, betrag_promo_netto, betrag_mwst, umrechnungskurs, system_id, menge_promo,
    umsatz_promo_netto, umsatz_mwst
)
(
    SELECT
        L.lkp_art_id AS art_id,
        L.mandant_id,
        L.wup_id,
        L.lkp_nb_id AS nb_id,
        L.dat_booking AS dat,
        P.bonuskauf_id,
        P.konditionsart_id,
        L.ean_kasse,
        L.lkp_wrg AS wrg_id,
        SUM(CAST(P.umsatz_brutto / (1 + L.lkp_mwst / 100) AS NUMERIC)),
        SUM(P.umsatz_brutto - CAST(P.umsatz_brutto / (1 + L.lkp_mwst / 100) AS NUMERIC)),
        ROUND(CAST(L.lkp_umrechnungskurs AS NUMERIC), 5) AS umrechnungskurs,
        COALESCE(K.system_id, 0) AS system_id,
        SUM(P.menge_promo),
        SUM(CAST(P.umsatz_promo_brutto / (1 + L.lkp_mwst / 100) AS NUMERIC)),
        SUM(P.umsatz_promo_brutto - CAST(P.umsatz_promo_brutto / (1 + L.lkp_mwst / 100) AS NUMERIC))
    FROM dbp_etl.position_artbew_bon AS L
    INNER JOIN dbp_etl.position_artbew_bon_promotion AS P
        ON
            L.mandant_id = P.mandant_id AND L.bon_id = P.bon_id
            AND L.dat_booking = P.dat_booking AND L.bon_zeile = P.bon_zeile
    -- Ermittlung System_id fuer oben eingetragene Konditionsarten

    LEFT JOIN dbp_data.l_konditionsart AS K ON P.mandant_id = K.mandant_id AND P.konditionsart_id = K.konditionsart_id

    GROUP BY
        L.mandant_id,
        L.wup_id,
        nb_id,
        art_id,
        dat,
        P.bonuskauf_id,
        P.konditionsart_id,
        wrg_id,
        umrechnungskurs,
        system_id,
        L.ean_kasse
);


/*
#------------------------------------------------------------------------------
# 13.) Status in den Bondaten zurueckstetzen (solange MIS noch nicht aktiv ist)
#------------------------------------------------------------------------------
*/

-- nur temporaer bis die MIS Verarbeitung aktiviert wird.


UPDATE dbp_ods.bon_load_status SET
    artbew_fg = 1
WHERE xml_name IN (
    SELECT xml_name
    FROM dbp_etl.position_artbew_bon_delta
);


CREATE OR REPLACE TEMPORARY TABLE kill_duplicates AS
SELECT
    mandant_id,
    wup_id,
    art_id,
    dat,
    bonuskauf_id,
    konditionsart_id,
    COUNT(*) AS anzahl,
    MIN(ean_kasse) AS min_ean_kasse,
    MAX(ean_kasse) AS max_ean_kasse,
    MIN(menge_promo) AS min_menge_promo,
    MAX(menge_promo) AS max_menge_promo
FROM dbp_data.artbew_promotion_zu
WHERE konditionsart_id <> 'RB19'
GROUP BY
    art_id,
    mandant_id,
    wup_id,
    dat,
    bonuskauf_id,
    konditionsart_id
HAVING anzahl > 1 AND min_ean_kasse = 0 AND max_ean_kasse <> 0 AND min_menge_promo = 0 AND max_menge_promo <> 0;


DELETE FROM dbp_data.artbew_promotion_zu
WHERE (mandant_id, wup_id, art_id, dat, bonuskauf_id, konditionsart_id) IN (SELECT (
    mandant_id, wup_id, art_id, dat,
    bonuskauf_id, konditionsart_id
)
FROM kill_duplicates) AND ean_kasse = 0;
