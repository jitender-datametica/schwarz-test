--AW 2021-04-22 check OK


DROP TABLE IF EXISTS dbp_etl.ek01;


DROP TABLE IF EXISTS dbp_etl.ek02;


DROP TABLE IF EXISTS dbp_etl.ek03;


DROP TABLE IF EXISTS dbp_etl.ek04;


DROP TABLE IF EXISTS dbp_etl.ek05;


DROP TABLE IF EXISTS dbp_etl.ek06;


DROP TABLE IF EXISTS dbp_etl.ek07;


DROP TABLE IF EXISTS dbp_etl.ek08;


DROP TABLE IF EXISTS dbp_etl.ek09;


DROP TABLE IF EXISTS dbp_etl.ek10;


DROP TABLE IF EXISTS dbp_etl.ek11;


DROP TABLE IF EXISTS dbp_etl.ek12;


DROP TABLE IF EXISTS dbp_etl.ek01_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek02_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek03_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek04_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek05_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek06_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek07_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek08_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek09_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek10_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek11_ekpo;


DROP TABLE IF EXISTS dbp_etl.ek12_ekpo;


CREATE TABLE IF NOT EXISTS dbp_etl.ek01 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek02 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek03 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek04 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek05 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek06 (
    art_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek07 (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek08 (
    art_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek09 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek10 (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek11 (
    art_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek12 (
    art_id INTEGER NOT NULL,
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek01_ekpo (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek02_ekpo (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek03_ekpo (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek04_ekpo (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek05_ekpo (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek06_ekpo (
    art_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek07_ekpo (
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek08_ekpo (
    art_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek09_ekpo (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek10_ekpo (
    art_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek11_ekpo (
    art_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE NOT NULL,
    komponentenmenge NUMERIC(29, 4),
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4)
);


CREATE TABLE IF NOT EXISTS dbp_etl.ek12_ekpo (
    art_id INTEGER NOT NULL,
    ek_netto_bnk NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    komponentenmenge NUMERIC(29, 4)
);


INSERT INTO dbp_etl.ek01 (
    art_id, wup_id, gp_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk,
    ek_netto, ek_mep
)
(
    SELECT
        art_id,
        wup_id,
        gp_id,
        dat_von,
        dat_bis,
        komponentenmenge,
        ek_netto_bnk,
        ek_netto,
        ek_mep
    FROM dbp_data.art_gp_wup_zu_per
    WHERE
        nb_id IN (99, -111) /* Lager */
        AND bezugsweg_id = 4 /* zentral */
        AND CAST(ek_kal_basis AS NUMERIC)
        > 0 /* der ek_kal_basis muss positiv sein */
        AND mandant_id = 1
        AND einkaufsorganisation_id = 1000
);


INSERT INTO dbp_etl.ek02 (
    art_id, gp_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto,
    ek_mep
)
(SELECT
    art_id,
    gp_id,
    dat_von,
    dat_bis,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per
WHERE
    nb_id IN (99, -111) /* Lager */
    AND bezugsweg_id = 4 /* zentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
/* GROUP BY art_id, dat_von, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC, gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, dat_von, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


INSERT INTO dbp_etl.ek03 (
    art_id, wup_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep
)
(SELECT
    art_id,
    wup_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per
WHERE
    nb_id IN (99, -111) /* Lager */
    AND bezugsweg_id = 4 /* zentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
/* GROUP BY art_id, gp_id, wup_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC, gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id, wup_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


INSERT INTO dbp_etl.ek04 (
    art_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep
)
(SELECT
    art_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per
WHERE
    nb_id IN (99, -111) /* Lager */
    AND bezugsweg_id = 4 /* zentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
/* GROUP BY art_id, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC,   gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


INSERT INTO dbp_etl.ek05 (
    art_id, wup_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto,
    ek_mep
)
(
    SELECT
        AGW5_1.art_id,
        AGW5_1.wup_id,
        CASE
            WHEN AGW5_1.dat_von > AGW5_2.dat_von
                THEN AGW5_1.dat_von
            ELSE AGW5_2.dat_von
        END AS dat_von,
        CASE
            WHEN AGW5_1.dat_bis < AGW5_2.dat_bis
                THEN AGW5_1.dat_bis
            ELSE AGW5_2.dat_bis
        END AS dat_bis,
        AGW5_1.komponentenmenge,
        AGW5_1.ek_netto_bnk,
        AGW5_1.ek_netto,
        AGW5_1.ek_mep
    FROM dbp_data.art_gp_wup_zu_per AS AGW5_1
    INNER JOIN dbp_data.art_gp_zu_per AS AGW5_2
        ON
            AGW5_1.art_id = AGW5_2.art_id AND AGW5_1.gp_id = AGW5_2
            .gp_id AND (
                AGW5_1.dat_von BETWEEN AGW5_2.dat_von AND AGW5_2.dat_bis
                OR AGW5_2.dat_von BETWEEN AGW5_1.dat_von AND
                AGW5_1.dat_bis
            )
            AND AGW5_1.mandant_id = AGW5_2.mandant_id
            AND AGW5_1.einkaufsorganisation_id
            = AGW5_2.einkaufsorganisation_id

    WHERE
        AGW5_1.nb_id IN (99, -111) /* Lager */
        AND AGW5_1.bezugsweg_id = 4 /* zentral */
        AND CAST(AGW5_1.ek_kal_basis AS NUMERIC)
        > 0 /* der ek_kal_basis muss positiv sein */
        AND AGW5_1.mandant_id = 1
        AND AGW5_1.einkaufsorganisation_id = 1000
);


INSERT INTO dbp_etl.ek06 (
    art_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep
)
(
    SELECT
        AGW6_1.art_id,
        CASE
            WHEN AGW6_1.dat_von > AGW6_2.dat_von
                THEN AGW6_1.dat_von
            ELSE AGW6_2.dat_von
        END AS dat_von,
        CASE
            WHEN AGW6_1.dat_bis < AGW6_2.dat_bis
                THEN AGW6_1.dat_bis
            ELSE AGW6_2.dat_bis
        END AS dat_bis,
        AGW6_1.komponentenmenge,
        AGW6_1.ek_netto_bnk,
        AGW6_1.ek_netto,
        AGW6_1.ek_mep
    FROM dbp_data.art_gp_wup_zu_per AS AGW6_1
    INNER JOIN dbp_data.art_gp_zu_per AS AGW6_2
        ON
            AGW6_1.art_id = AGW6_2.art_id AND AGW6_1.gp_id = AGW6_2
            .gp_id AND (
                AGW6_1.dat_von BETWEEN AGW6_2.dat_von AND AGW6_2.dat_bis
                OR AGW6_2.dat_von BETWEEN AGW6_1.dat_von AND
                AGW6_1.dat_bis
            )
            AND AGW6_1.mandant_id = AGW6_2.mandant_id
            AND AGW6_1.einkaufsorganisation_id
            = AGW6_2.einkaufsorganisation_id

    WHERE
        AGW6_1.nb_id IN (99, -111) /* Lager */
        AND AGW6_1.bezugsweg_id = 4 /* zentral */
        AND CAST(AGW6_1.ek_kal_basis AS NUMERIC)
        > 0 /* der ek_kal_basis muss positiv sein */
        AND AGW6_1.mandant_id = 1
        AND AGW6_1.einkaufsorganisation_id = 1000
);


INSERT INTO dbp_etl.ek07 (
    art_id, wup_id, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep
)
(SELECT
    art_id,
    wup_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per
WHERE
    nb_id IN (99, -111) /* Lager */
    AND bezugsweg_id = 4 /* zentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
/* GROUP BY art_id, wup_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC,   gp_id,
             CAST((ek_mep    ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, wup_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


INSERT INTO dbp_etl.ek08 (
    art_id, komponentenmenge, ek_netto_bnk, ek_netto, ek_mep
)
(SELECT
    art_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per
WHERE
    nb_id IN (99, -111) /* Lager */
    AND bezugsweg_id = 4 /* zentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
/* GROUP BY art_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC,   gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


/* kein Lager */ INSERT INTO dbp_etl.ek09 (
    art_id, gp_id, dat_von, dat_bis, komponentenmenge,
    ek_netto_bnk, ek_netto, ek_mep
)
(
    SELECT
        art_id,
        gp_id,
        dat_von,
        dat_bis,
        komponentenmenge,
        ek_netto_bnk,
        ek_netto,
        ek_mep
    FROM dbp_data.art_gp_wup_zu_per
    WHERE
        (nb_id NOT IN (99, -111) OR nb_id IS NULL)
        AND bezugsweg_id = 1 /* dezentral */
        AND CAST(ek_kal_basis AS NUMERIC)
        > 0 /* der ek_kal_basis muss positiv sein */
        AND mandant_id = 1
        AND einkaufsorganisation_id = 1000
);


/* kein Lager */ INSERT INTO dbp_etl.ek10 (
    art_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto,
    ek_mep
)
(SELECT
    art_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto,
    ek_mep
FROM dbp_data.art_gp_wup_zu_per
WHERE
    (nb_id NOT IN (99, -111) OR nb_id IS NULL)
    AND bezugsweg_id = 1 /* dezentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
/* GROUP BY art_id, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC,   gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


/* kein Lager */ INSERT INTO dbp_etl.ek11 (
    art_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk,
    ek_netto, ek_mep
)
(
    SELECT
        AGW11_1.art_id,
        CASE
            WHEN AGW11_1.dat_von > AGW11_2.dat_von
                THEN AGW11_1.dat_von
            ELSE AGW11_2.dat_von
        END AS dat_von,
        CASE
            WHEN AGW11_1.dat_bis < AGW11_2.dat_bis
                THEN AGW11_1.dat_bis
            ELSE AGW11_2.dat_bis
        END AS dat_bis,
        AGW11_1.komponentenmenge,
        AGW11_1.ek_netto_bnk,
        AGW11_1.ek_netto,
        AGW11_1.ek_mep
    FROM dbp_data.art_gp_wup_zu_per AS AGW11_1
    INNER JOIN dbp_data.art_gp_zu_per AS AGW11_2
        ON
            AGW11_1.art_id = AGW11_2.art_id AND AGW11_1.gp_id
            = AGW11_2.gp_id AND (
                AGW11_1.dat_von BETWEEN AGW11_2.dat_von AND AGW11_2.dat_bis
                OR AGW11_2.dat_von BETWEEN AGW11_1
                .dat_von AND AGW11_1.dat_bis
            )
            AND AGW11_1.mandant_id = AGW11_2.mandant_id
            AND AGW11_1.einkaufsorganisation_id
            = AGW11_2.einkaufsorganisation_id
    WHERE
        (AGW11_1.nb_id NOT IN (99, -111) OR AGW11_1.nb_id IS NULL)
        AND AGW11_1.bezugsweg_id = 1 /* dezentral */
        AND CAST(AGW11_1.ek_kal_basis AS NUMERIC)
        > 0 /* der ek_kal_basis muss positiv sein */
        AND AGW11_1.mandant_id = 1
        AND AGW11_1.einkaufsorganisation_id = 1000
);


/* kein Lager */ INSERT INTO dbp_etl.ek12 (
    art_id, ek_netto_bnk, ek_netto, ek_mep, komponentenmenge
)
(SELECT
    art_id,
    ek_netto_bnk,
    ek_netto,
    ek_mep,
    komponentenmenge
FROM dbp_data.art_gp_wup_zu_per
WHERE
    (nb_id NOT IN (99, -111) OR nb_id IS NULL)
    AND bezugsweg_id = 1 /* dezentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
    AND einkaufsorganisation_id = 1000
/* GROUP BY art_id
QUALIFY CSUM (1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC,   gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


INSERT INTO dbp_etl.ek01_ekpo (
    art_id, wup_id, gp_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk,
    ek_netto
)
(
    SELECT
        art_id,
        wup_id,
        gp_id,
        dat_von,
        dat_bis,
        komponentenmenge,
        ek_netto_bnk,
        ek_netto
    FROM dbp_data.art_gp_wup_zu_per
    WHERE
        nb_id IN (99, -111) /* Lager */
        AND bezugsweg_id = 4 /* zentral */
        AND CAST(ek_kal_basis AS NUMERIC)
        > 0 /* der ek_kal_basis muss positiv sein */
        AND mandant_id = 1
);


INSERT INTO dbp_etl.ek02_ekpo (
    art_id, gp_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto
)
(SELECT
    art_id,
    gp_id,
    dat_von,
    dat_bis,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per
WHERE
    nb_id IN (99, -111) /* Lager */
    AND bezugsweg_id = 4 /* zentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
/* GROUP BY art_id, dat_von, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC, gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, dat_von, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


INSERT INTO dbp_etl.ek03_ekpo (
    art_id, wup_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto
)
(SELECT
    art_id,
    wup_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per
WHERE
    nb_id IN (99, -111) /* Lager */
    AND bezugsweg_id = 4 /* zentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
/* GROUP BY art_id, gp_id, wup_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC, gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id, wup_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


INSERT INTO dbp_etl.ek04_ekpo (
    art_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto
)
(SELECT
    art_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per
WHERE
    nb_id IN (99, -111) /* Lager */
    AND bezugsweg_id = 4 /* zentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
/* GROUP BY art_id, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC,   gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


INSERT INTO dbp_etl.ek05_ekpo (
    art_id, wup_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto
)
(
    SELECT
        AGW5_1.art_id,
        AGW5_1.wup_id,
        CASE
            WHEN AGW5_1.dat_von > AGW5_2.dat_von
                THEN AGW5_1.dat_von
            ELSE AGW5_2.dat_von
        END AS dat_von,
        CASE
            WHEN AGW5_1.dat_bis < AGW5_2.dat_bis
                THEN AGW5_1.dat_bis
            ELSE AGW5_2.dat_bis
        END AS dat_bis,
        AGW5_1.komponentenmenge,
        AGW5_1.ek_netto_bnk,
        AGW5_1.ek_netto
    FROM dbp_data.art_gp_wup_zu_per AS AGW5_1
    INNER JOIN dbp_data.art_gp_zu_per AS AGW5_2
        ON
            AGW5_1.art_id = AGW5_2.art_id AND AGW5_1.gp_id = AGW5_2
            .gp_id AND (
                AGW5_1.dat_von BETWEEN AGW5_2.dat_von AND AGW5_2.dat_bis
                OR AGW5_2.dat_von BETWEEN AGW5_1.dat_von AND
                AGW5_1.dat_bis
            )
            AND AGW5_1.mandant_id = AGW5_2.mandant_id
            AND AGW5_1.einkaufsorganisation_id
            = AGW5_2.einkaufsorganisation_id

    WHERE
        AGW5_1.nb_id IN (99, -111) /* Lager */
        AND AGW5_1.bezugsweg_id = 4 /* zentral */
        AND CAST(AGW5_1.ek_kal_basis AS NUMERIC)
        > 0 /* der ek_kal_basis muss positiv sein */
        AND AGW5_1.mandant_id = 1
);


INSERT INTO dbp_etl.ek06_ekpo (
    art_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk, ek_netto
)
(
    SELECT
        AGW6_1.art_id,
        CASE
            WHEN AGW6_1.dat_von > AGW6_2.dat_von
                THEN AGW6_1.dat_von
            ELSE AGW6_2.dat_von
        END AS dat_von,
        CASE
            WHEN AGW6_1.dat_bis < AGW6_2.dat_bis
                THEN AGW6_1.dat_bis
            ELSE AGW6_2.dat_bis
        END AS dat_bis,
        AGW6_1.komponentenmenge,
        AGW6_1.ek_netto_bnk,
        AGW6_1.ek_netto
    FROM dbp_data.art_gp_wup_zu_per AS AGW6_1
    INNER JOIN dbp_data.art_gp_zu_per AS AGW6_2
        ON
            AGW6_1.art_id = AGW6_2.art_id AND AGW6_1.gp_id = AGW6_2
            .gp_id AND (
                AGW6_1.dat_von BETWEEN AGW6_2.dat_von AND AGW6_2.dat_bis
                OR AGW6_2.dat_von BETWEEN AGW6_1.dat_von AND
                AGW6_1.dat_bis
            )
            AND AGW6_1.mandant_id = AGW6_2.mandant_id
            AND AGW6_1.einkaufsorganisation_id
            = AGW6_2.einkaufsorganisation_id

    WHERE
        AGW6_1.nb_id IN (99, -111) /* Lager */
        AND AGW6_1.bezugsweg_id = 4 /* zentral */
        AND CAST(AGW6_1.ek_kal_basis AS NUMERIC)
        > 0 /* der ek_kal_basis muss positiv sein */
        AND AGW6_1.mandant_id = 1
);


INSERT INTO dbp_etl.ek07_ekpo (
    art_id, wup_id, komponentenmenge, ek_netto_bnk, ek_netto
)
(SELECT
    art_id,
    wup_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per
WHERE
    nb_id IN (99, -111) /* Lager */
    AND bezugsweg_id = 4 /* zentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
/* GROUP BY art_id, wup_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC,   gp_id,
             CAST((ek_mep    ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, wup_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


INSERT INTO dbp_etl.ek08_ekpo (art_id, komponentenmenge, ek_netto_bnk, ek_netto)
(SELECT
    art_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per
WHERE
    nb_id IN (99, -111) /* Lager */
    AND bezugsweg_id = 4 /* zentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
/* GROUP BY art_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC,   gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


/* kein Lager */ INSERT INTO dbp_etl.ek09_ekpo (
    art_id, gp_id, dat_von, dat_bis, komponentenmenge,
    ek_netto_bnk, ek_netto
)
(
    SELECT
        art_id,
        gp_id,
        dat_von,
        dat_bis,
        komponentenmenge,
        ek_netto_bnk,
        ek_netto
    FROM dbp_data.art_gp_wup_zu_per
    WHERE
        (nb_id NOT IN (99, -111) OR nb_id IS NULL)
        AND bezugsweg_id = 1 /* dezentral */
        AND CAST(ek_kal_basis AS NUMERIC)
        > 0 /* der ek_kal_basis muss positiv sein */
        AND mandant_id = 1
);


/* kein Lager */ INSERT INTO dbp_etl.ek10_ekpo (
    art_id, gp_id, komponentenmenge, ek_netto_bnk, ek_netto
)
(SELECT
    art_id,
    gp_id,
    komponentenmenge,
    ek_netto_bnk,
    ek_netto
FROM dbp_data.art_gp_wup_zu_per
WHERE
    (nb_id NOT IN (99, -111) OR nb_id IS NULL)
    AND bezugsweg_id = 1 /* dezentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
/* GROUP BY art_id, gp_id
QUALIFY CSUM(1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC,   gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id, gp_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);


/* kein Lager */ INSERT INTO dbp_etl.ek11_ekpo (
    art_id, dat_von, dat_bis, komponentenmenge, ek_netto_bnk,
    ek_netto
)
(
    SELECT
        AGW11_1.art_id,
        CASE
            WHEN AGW11_1.dat_von > AGW11_2.dat_von
                THEN AGW11_1.dat_von
            ELSE AGW11_2.dat_von
        END AS dat_von,
        CASE
            WHEN AGW11_1.dat_bis < AGW11_2.dat_bis
                THEN AGW11_1.dat_bis
            ELSE AGW11_2.dat_bis
        END AS dat_bis,
        AGW11_1.komponentenmenge,
        AGW11_1.ek_netto_bnk,
        AGW11_1.ek_netto
    FROM dbp_data.art_gp_wup_zu_per AS AGW11_1
    INNER JOIN dbp_data.art_gp_zu_per AS AGW11_2
        ON
            AGW11_1.art_id = AGW11_2.art_id AND AGW11_1.gp_id
            = AGW11_2.gp_id AND (
                AGW11_1.dat_von BETWEEN AGW11_2.dat_von AND AGW11_2.dat_bis
                OR AGW11_2.dat_von BETWEEN AGW11_1
                .dat_von AND AGW11_1.dat_bis
            )
            AND AGW11_1.mandant_id = AGW11_2.mandant_id
            AND AGW11_1.einkaufsorganisation_id
            = AGW11_2.einkaufsorganisation_id
    WHERE
        (AGW11_1.nb_id NOT IN (99, -111) OR AGW11_1.nb_id IS NULL)
        AND AGW11_1.bezugsweg_id = 1 /* dezentral */
        AND CAST(AGW11_1.ek_kal_basis AS NUMERIC)
        > 0 /* der ek_kal_basis muss positiv sein */
        AND AGW11_1.mandant_id = 1
);


/* kein Lager */ INSERT INTO dbp_etl.ek12_ekpo (
    art_id, ek_netto_bnk, ek_netto, komponentenmenge
)
(SELECT
    art_id,
    ek_netto_bnk,
    ek_netto,
    komponentenmenge
FROM dbp_data.art_gp_wup_zu_per
WHERE
    (nb_id NOT IN (99, -111) OR nb_id IS NULL)
    AND bezugsweg_id = 1 /* dezentral */
    AND CAST(ek_kal_basis AS NUMERIC)
    > 0 /* der ek_kal_basis muss positiv sein */
    AND mandant_id = 1
/* GROUP BY art_id
QUALIFY CSUM (1, dat_von DESC,
             CAST((ek_brutto ) AS NUMERIC(29,4)) DESC,   gp_id,
             CAST((ek_mep ) AS NUMERIC(29,4)) DESC,
             CAST((ek_kal_basis ) AS NUMERIC(29,4)) DESC) = 1 */

QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        art_id ORDER BY
        dat_von IS NULL DESC, dat_von DESC, CAST(ek_brutto AS NUMERIC)
        IS NULL DESC,
        CAST(ek_brutto AS NUMERIC) DESC,
        gp_id IS NULL,
        gp_id,
        CAST(ek_mep AS NUMERIC) IS NULL DESC,
        CAST(ek_mep AS NUMERIC)
        DESC,
        CAST(ek_kal_basis AS NUMERIC) IS NULL DESC,
        CAST(ek_kal_basis AS NUMERIC) DESC
)) = 1);
