--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_aktion_relevant_1;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE TABLE IF NOT EXISTS dbp_etl.kmo_artbew_bon_aktion_relevant_1 (
    mandant_id INTEGER NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    bewart_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    anz_aktion INTEGER NOT NULL
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.artbew_kmo_tmp_1;


--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.


CREATE TABLE IF NOT EXISTS dbp_etl.artbew_kmo_tmp_1 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
    promo_fg INTEGER DEFAULT 0 NOT NULL,
    ean_kasse INTEGER DEFAULT 0 NOT NULL,
    einkaufsorganisation_id INTEGER,
    herst_id INTEGER,
    mwst_id INTEGER NOT NULL,
    menge NUMERIC(29, 3),
    wrg_1 STRING(3) COLLATE 'und:ci',
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
    posten_id STRING(2) COLLATE 'und:ci',
    bq_findung_id INTEGER,
    ek_gld NUMERIC(29, 4),
    diff_ek_gld_konz NUMERIC(29, 4)
);


-- Ausstiegspunkt der Bezugsquellenfindung
-- Anzahl Infosätze (1 wenn nur ungültige vorhanden sind)

-- Warengruppe für Zugriff auf vz_wup_wg_zu_per
-- Regel Ekorg aus Einkaufsinfosatz

-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_1 und EORD_1

-- Ekorg nach Bezugsquellenfindung
-- Kurs_1 für die Umrechnung von Landeswährung in Euro
-- Anzahl Orderbuch gepflegt

-- GP_1 nach Bezugsquellenfindung
-- Kreistyp_gruppe aus Marktstamm.
-- Regel GP_1 aus Einkaufsinfosatz

-- VZ aus Kreisprozess für Bezugsweg 4 oder wup_id für Bezugsweg 1 für Zugriff auf EINA_1 und EORD_1
CREATE OR REPLACE
TABLE dbp_etl.kmo_wpuums_art_gp_wup_zu_1 (
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
    wg_id INTEGER,
    umrechnungskurs FLOAT64
);


--[OK] statement is translated correctly (syntax and type checks are fine)


-- Kennzeichen Zuordnung Aktion_1, Artikel_1, Wup_1 aktiv
INSERT INTO dbp_etl.kmo_artbew_bon_aktion_relevant_1 (
    mandant_id,
    aktion_id, bewart_id, dat, art_id, wup_id, nb_id, anz_aktion
)
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
        FROM dbp_data.aktion_1 AS A
        INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AAW
            ON
                A.mandant_id = AAW.mandant_id AND A.aktion_id = AAW.aktion_id
                AND A.bewart_id = AAW.bewart_id
        INNER JOIN dbp_etl.kmo_artbew_bon_dat_1 AS D ON D.dat BETWEEN A.dat_von AND A.dat_bis
        WHERE
            A.mandant_id <> 1 -- nur KMO Mandanten

            AND A.bewart_id = 1002 -- Kennzeichen Aktion_1

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


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.


-- Ermittlung Promotionsbetrag pro Bon Zeile
-- ,umrechnungskurs

-- im abschließenden INSERT INTO in die Zieltabelle verschluesselt initialisiert (s.u.)

/* Datenlieferung an Externe, kommt erst noch... */ -- Berechnung im Vergleich zur Wpuums auftreten.

-- Bonzeilen zusammenfassen damit keine Rundungsdifferenzen bei der MWST

-- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0

-- Mai 2011: Umsatz Brutto = Belegbetrag minus Betrag Promotion (Promo mit negativen Vorzeichen deshalb addieren!!!)

-- Ermittlung der Promotionsbetraege pro Bonzeile und Kennzeichnung promo_fg
-- ,umrechnungskurs

/* Kennzeichen ob in der Position ein Promotionsbetrag enthalten ist */ INSERT INTO dbp_etl.artbew_kmo_tmp_1
(
    wup_id, mandant_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id, promo_fg, ean_kasse, einkaufsorganisation_id,
    herst_id, mwst_id, menge, wrg_1, umsatz_netto, umsatz_mwst_betrag, bezugsweg_id, posten_id
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
            WHEN R.anz_aktion = 1 -- wenn genau eine_1 Aktion_1 vorhanden ist, diese eintragen

                THEN R.aktion_id
            ELSE ''
        END AS aktion_id,
        l.promo_fg,
        l.ean_kasse,
        -1 AS einkaufsorganisation_id,
        -1 AS herst_id,
        l.lkp_mwst_id AS mwst_id,
        l.menge_ AS menge,
        l.lkp_wrg AS wrg_1,
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
        FROM dbp_etl.kmo_artbew_bon_1 AS Z
        LEFT JOIN (
            SELECT
                mandant_id,
                bon_id,
                dat_booking,
                bon_zeile,
                SUM(umsatz_brutto) AS promotion_brutto
            FROM dbp_etl.kmo_artbew_bon_promotion_1
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
        dbp_etl.kmo_artbew_bon_aktion_relevant_1
            AS R
        ON
            l.mandant_id = R.mandant_id AND l.lkp_art_id =
            R.art_id AND l.wup_id = R.wup_id AND l.lkp_nb_id = R.nb_id AND l.dat_booking = R.dat
);


/*2021-09-21 mfialkiewicz adding missing script*/


-- ,umrechnungskurs
-- ,umrechnungskurs
-- ,umrechnungskurs
INSERT INTO dbp_data.artbew_1 (
    mandant_id,
    wup_id, nb_id, dat, bewart_id, gp_id, art_id, aktion_id, promo_fg, ean_kasse, einkaufsorganisation_id, herst_id,
    mwst_id, menge, wrg_1, umsatz_netto, umsatz_mwst_betrag, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep,
    einstandspreis, logkostenzuschlag, bezugsweg_id, ek_netto_bnk, ek_netto_bnk_sachk, posten_id, td_update, td_insert
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
    ean_kasse -- ,umrechnungskurs
    ,
    einkaufsorganisation_id,
    herst_id,
    mwst_id,
    menge_sum,
    wrg_1,
    umsatz_netto_sum,
    umsatz_mwst_betrag_sum,
    zero_enc AS ek_brutto,
    zero_enc AS ek_netto,
    zero_enc AS ek_nettonetto,
    zero_enc AS ek_kal_basis,
    zero_enc AS ek_mep,
    zero_enc AS einstandspreis,
    0 AS logkostenzuschlag,
    bezugsweg_id,
    zero_enc AS ek_netto_bnk,
    zero_enc AS ek_netto_bnk_sachk,
    posten_id,
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
        wrg_1,
        posten_id,
        bezugsweg_id,
        0 AS zero_enc,
        ean_kasse,
        SUM(menge) AS menge_sum,
        SUM(umsatz_netto) AS umsatz_netto_sum,
        SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum
    FROM dbp_etl.artbew_kmo_tmp_1
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
        wrg_1,
        posten_id,
        bezugsweg_id,
        zero_enc,
        ean_kasse
) AS t0);


--translated statement


DELETE FROM dbp_data.artbew_promotion_zu_1 AS A
WHERE dat IN (
    SELECT dat
    FROM dbp_etl.kmo_artbew_bon_dat_1) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_kmo_tmp_1
    WHERE promo_fg = 1
) AND konditionsart_id <> 'RB19';


--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.


INSERT INTO dbp_data.artbew_promotion_zu_1 (
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
    FROM dbp_etl.kmo_artbew_bon_1 AS L
    INNER JOIN dbp_etl.kmo_artbew_bon_promotion_1 AS P
        ON
            L.mandant_id = P.mandant_id AND L.bon_id = P.bon_id
            AND L.dat_booking = P.dat_booking AND L.bon_zeile = P.bon_zeile
    -- Ermittlung System_id fuer oben eingetragene Konditionsarten

    LEFT JOIN dbp_data.l_konditionsart_1 AS K ON P.mandant_id = K.mandant_id AND P.konditionsart_id = K.konditionsart_id

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


/*2021-09-22 mfialkiewicz adding missing insert*/


INSERT INTO dbp_etl.kmo_wpuums_art_gp_wup_zu_1 (
    mandant_id, art_id, wup_id, nb_id, dat, bezugsweg_id,
    anz_ek_infosatz, anz_ek_orderbuch, bq_gp_id, bq_ekorg, bq_findung_id, regel_gp_id, regel_ekorg, ref_wup_id, ref_nb_id,
    kreistyp_gruppe_id, wg_id, umrechnungskurs
)
(
    SELECT
        mandant_id,
        lkp_art_id,
        wup_id,
        lkp_nb_id,
        dat_booking,
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
    FROM dbp_etl.kmo_artbew_bon_1 AS A
    WHERE (
        mandant_id, wup_id, lkp_nb_id, lkp_art_id, dat_booking) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, art_id, dat)
        FROM dbp_etl.kmo_wpuums_art_gp_wup_zu_1
    )
    GROUP BY -- gruppierung wg. Ean_1 und Promoflag erforderlich
        mandant_id,
        dat_booking,
        wup_id,
        lkp_art_id,
        lkp_nb_id,
        lkp_umrechnungskurs
);


UPDATE dbp_ods.bon_load_status_1 SET
    artbew_fg = 1
WHERE xml_name IN (
    SELECT xml_name
    FROM dbp_etl.kmo_artbew_bon_delta_1
);


--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)


CREATE OR REPLACE TABLE dbp_etl.`_kill_duplicates_${TRANSIENT_TABLE_SUFFIX}` AS
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
FROM dbp_data.artbew_promotion_zu_1
WHERE konditionsart_id <> 'RB19'
GROUP BY
    art_id,
    mandant_id,
    wup_id,
    dat,
    bonuskauf_id,
    konditionsart_id
HAVING anzahl > 1 AND min_ean_kasse = 0 AND max_ean_kasse <> 0 AND min_menge_promo = 0 AND max_menge_promo <> 0;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.artbew_promotion_zu_1
WHERE (mandant_id, wup_id, art_id, dat, bonuskauf_id, konditionsart_id) IN (SELECT (
    mandant_id, wup_id, art_id, dat,
    bonuskauf_id, konditionsart_id
)
FROM dbp_etl.`_kill_duplicates_${TRANSIENT_TABLE_SUFFIX}`) AND ean_kasse = 0;


DROP TABLE IF EXISTS dbp_etl.`_kill_duplicates_${TRANSIENT_TABLE_SUFFIX}`;
