-- KMO


CREATE OR REPLACE TEMPORARY TABLE _werbeartikel_1_kmo_neu AS
SELECT
    X1.kjwo,
    akt.dat_von,
    akt.dat_bis,
    akta.wup_id,
    akta.mandant_id,
    akta.art_id,
    X1.akt_wo,
    CASE
        WHEN akt.mandant_id = 2 AND akt.dat_bis >= DATE '2019-02-27' OR akt.mandant_id IN (4, 7)
            THEN 6
        WHEN akt.mandant_id = 8
            THEN 7
        ELSE 5
    END AS werbetyp_id,
    akt.avq_relevant_fg
FROM (SELECT
    aktion_id,
    mandant_id,
    bewart_id,
    aktionsart_id,
    werbe_kat_id,
    dat_von,
    dat_bis,
    preisaktiviert_fg,
    kjwo_von,
    aktion_typ_id,
    td_update,
    td_insert,
    CASE
        WHEN aktion_typ_id IS NOT NULL
            THEN 0
        ELSE 1
    END AS avq_relevant_fg
FROM dbp_data.aktion_1 AS A
WHERE mandant_id > 1) AS akt
INNER JOIN (
    SELECT *
    FROM dbp_data.aktion_art_wup_zu_1
    WHERE
        mandant_id > 1
        AND COALESCE(geloescht_sap_fg, 0) <> 1
) AS akta
    ON akt.aktion_id = akta.aktion_id AND akt.mandant_id = akta.mandant_id

INNER JOIN dbp_data.tag_1 AS X1
    ON akt.dat_von = X1.dat AND X1.wtag_id = CASE
        WHEN akt.mandant_id = 2 AND akt.dat_bis >= DATE '2019-02-27' OR akt.mandant_id IN (4, 7)
            THEN 3
        WHEN akt.mandant_id = 8
            THEN 1
        ELSE 4
    END
INNER JOIN dbp_data.tag_1 AS X2
    ON akt.dat_bis = X2.dat AND X2.wtag_id = CASE
        WHEN akt.mandant_id = 2 AND akt.dat_bis >= DATE '2019-02-27' OR akt.mandant_id IN (4, 7)
            THEN 2
        WHEN akt.mandant_id = 8
            THEN 7
        ELSE 3
    END AND DATE_SUB(X2.dat, INTERVAL 6 DAY) = X1.dat
WHERE (
    akta.grund_sperrung IS NULL AND akt.mandant_id IN (2, 5, 6) AND X1.akt_wo = 0 OR akta.grund_sperrung IS NULL AND
    akt.mandant_id IN (
        3) AND X1.akt_wo = 0 AND SUBSTR(akt.aktion_id, 9, 2) NOT IN ('DN', 'DV', 'DP', 'DW', 'DS',
    'DK') OR akta.grund_sperrung IS NULL AND akt.mandant_id IN (4, 7) AND SUBSTR(akt.aktion_id, 9, 2) IN (
        'MM_1', 'HG',
        'NF'
    ) AND X1.akt_wo = 0 OR akta.grund_sperrung IS NULL AND akt.mandant_id IN (8
    ) AND INSTR(akt.aktion_id, 'D1'
    ) = 0 AND INSTR(akt.aktion_id, 'D2') = 0 AND INSTR(akt.aktion_id, 'DS') = 0 AND INSTR(akt.aktion_id, 'J') = 0
    AND X1.akt_wo = 0
)
AND (akt.mandant_id = 8 AND 2 IN (
    SELECT wtag_id
    FROM dbp_data.tag_1
    WHERE dat = CURRENT_DATE("Europe/Berlin")) OR akt.mandant_id = 2 AND 4 IN (SELECT wtag_id
FROM dbp_data.tag_1
WHERE dat = CURRENT_DATE("Europe/Berlin")) OR akt.mandant_id = 7 AND 4 IN (SELECT wtag_id
FROM dbp_data.tag_1
WHERE dat = CURRENT_DATE("Europe/Berlin")) OR akt.mandant_id = 3 AND 5 IN (SELECT wtag_id
FROM dbp_data.tag_1
WHERE dat = CURRENT_DATE("Europe/Berlin")) OR akt.mandant_id = 5 AND 5 IN (SELECT wtag_id
FROM dbp_data.tag_1
WHERE dat = CURRENT_DATE("Europe/Berlin")) OR akt.mandant_id = 6 AND 5 IN (
    SELECT wtag_id
    FROM dbp_data.tag_1
    WHERE dat = CURRENT_DATE("Europe/Berlin")
))
GROUP BY
    X1.kjwo,
    akt.dat_von,
    akt.dat_bis,
    akta.wup_id,
    akta.mandant_id,
    akta.art_id,
    X1.akt_wo,
    werbetyp_id,
    akt.avq_relevant_fg;


CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_kmo_neu AS
SELECT
    mandant_id,
    art_id,
    COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
FROM dbp_data.art_1 AS A
WHERE
    dat_bis = DATE '9999-12-31'
    AND (
        mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM `_werbeartikel_1_kmo_neu`
        GROUP BY mandant_id,
        art_id
    )
GROUP BY
    mandant_id,
    art_id,
    mutter_wb_id;


DELETE FROM dbp_process.werbung_kennzahlen_kopf_1
WHERE (
    mandant_id, kjwo) IN (
    SELECT (mandant_id, kjwo)
    FROM `_werbeartikel_1_kmo_neu`
);


INSERT INTO dbp_process.werbung_kennzahlen_kopf_1 (
    kjwo, wup_id, nb_id, mandant_id, art_id, werbe_typ_id,
    posten_id, faktor_flaki, mutter_wb_id, wtag_id_start, wtag_id_ende, avq_relevant_fg
)
(
    SELECT
        A.kjwo,
        A.wup_id,
        0 AS nb_id,
        A.mandant_id,
        A.art_id,
        A.werbetyp_id AS werbe_typ_id,
        '' AS posten_id,
        1 AS faktor_flaki,
        D.mutter_wb_id AS mutter_wb_id,
        B.wtag_id AS wtag_id_start,
        C.wtag_id AS wtag_id_ende,
        A.avq_relevant_fg
    FROM `_werbeartikel_1_kmo_neu` AS A
    INNER JOIN dbp_data.tag_1 AS B ON A.dat_von = B.dat
    INNER JOIN dbp_data.tag_1 AS C ON A.dat_bis = C.dat
    INNER JOIN `_ff_mutter_art_kmo_neu` AS D ON A.mandant_id = D.mandant_id AND A.art_id = D.art_id
);


DELETE FROM dbp_process.werbung_kennzahlen_kopf_1
WHERE (kjwo, wup_id, nb_id, mandant_id, art_id, werbe_typ_id) IN (
    SELECT (
        A.kjwo, A.wup_id, A.nb_id, A.mandant_id, A.art_id,
        A.werbe_typ_id
    )
    FROM dbp_process.werbung_kennzahlen_kopf_1 AS A
    INNER JOIN dbp_data.art_wg_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    WHERE
        B.wg_id IN (260, 292)
        AND (
            A.mandant_id, A.kjwo) IN (
            SELECT (mandant_id, kjwo)
            FROM `_werbeartikel_1_kmo_neu`
        )
);


-- DE


CREATE OR REPLACE TEMPORARY TABLE _werbeartikel_1_neu AS
SELECT
    X1.kjwo,
    akt.dat_von,
    akt.dat_bis,
    AKTA.wup_id,
    AKTA.mandant_id,
    AKTA.art_id,
    X1.akt_wo,
    1 AS werbetyp_id,
    akt.avq_relevant_fg
FROM (
    SELECT
        A.aktion_id,
        A.mandant_id,
        A.bewart_id,
        A.aktionsart_id,
        A.werbe_kat_id,
        A.dat_von,
        A.dat_bis,
        A.preisaktiviert_fg,
        A.kjwo_von,
        A.aktion_typ_id,
        A.td_update,
        A.td_insert,
        CASE
            WHEN b.bonuskauf_id IS NOT NULL
                THEN 0
            ELSE 1
        END AS avq_relevant_fg
    FROM dbp_data.aktion_1 AS A
    LEFT JOIN (
        SELECT *
        FROM dbp_data.l_bonuskauf_1
        WHERE mandant_id = 1
    ) AS b
        ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
    WHERE
        A.mandant_id = 1
        AND CASE
            WHEN b.bonuskauf_id IS NOT NULL OR b.bonuskauf_id IS NULL AND A.preisaktiviert_fg = 1
                THEN 1
            ELSE 0
        END = 1
) AS akt
INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AKTA
    ON
        akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
        AKTA.mandant_id
INNER JOIN dbp_data.tag_1 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 7
INNER JOIN dbp_data.tag_1 AS X2
    ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
        X2.dat, INTERVAL 6
        DAY
    ) = X1.dat
WHERE
    AKTA.dat_sperrung IS NULL
    AND akt.mandant_id = 1
    AND X1.akt_wo = 0
    AND 5 IN (
        SELECT wtag_id
        FROM dbp_data.tag_1
        WHERE dat = CURRENT_DATE("Europe/Berlin")
    )
GROUP BY
    X1.kjwo,
    akt.dat_von,
    akt.dat_bis,
    AKTA.wup_id,
    AKTA.mandant_id,
    AKTA.art_id,
    X1.akt_wo,
    werbetyp_id,
    akt.avq_relevant_fg;


INSERT INTO `_werbeartikel_1_neu`
(
    SELECT
        X1.kjwo,
        DATE_SUB(akt.dat_von, INTERVAL 1 DAY),
        akt.dat_bis,
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        1 AS werbetyp_id,
        akt.avq_relevant_fg
    FROM (
        SELECT
            A.aktion_id,
            A.mandant_id,
            A.bewart_id,
            A.aktionsart_id,
            A.werbe_kat_id,
            A.dat_von,
            A.dat_bis,
            A.preisaktiviert_fg,
            A.kjwo_von,
            A.aktion_typ_id,
            A.td_update,
            A.td_insert,
            CASE
                WHEN b.bonuskauf_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_1 AS A
        LEFT JOIN (
            SELECT *
            FROM dbp_data.l_bonuskauf_1
            WHERE mandant_id = 1
        ) AS b
            ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
        WHERE
            A.mandant_id = 1
            AND CASE
                WHEN b.bonuskauf_id IS NOT NULL OR b.bonuskauf_id IS NULL AND A.preisaktiviert_fg = 1
                    THEN 1
                ELSE 0
            END = 1
    ) AS akt
    INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AKTA
        ON
            akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
            AKTA.mandant_id
    INNER JOIN dbp_data.tag_1 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 1
    INNER JOIN dbp_data.tag_1 AS X2
        ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
            X2.dat, INTERVAL
            5 DAY
        ) = X1.dat
    WHERE
        AKTA.dat_sperrung IS NULL
        AND akt.mandant_id = 1
        AND X1.akt_wo = 0
        AND 5 IN (
            SELECT wtag_id
            FROM dbp_data.tag_1
            WHERE dat = CURRENT_DATE("Europe/Berlin")
        )
        AND (X1.kjwo, AKTA.wup_id, AKTA.mandant_id, AKTA.art_id, 1) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_neu`)
    GROUP BY
        X1.kjwo,
        DATE_SUB(akt.dat_von, INTERVAL 1 DAY),
        akt.dat_bis,
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        werbetyp_id,
        akt.avq_relevant_fg
);


INSERT INTO `_werbeartikel_1_neu`
(
    SELECT
        X1.kjwo,
        akt.dat_von,
        akt.dat_bis,
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        2 AS werbetyp_id,
        akt.avq_relevant_fg
    FROM (
        SELECT
            A.aktion_id,
            A.mandant_id,
            A.bewart_id,
            A.aktionsart_id,
            A.werbe_kat_id,
            A.dat_von,
            A.dat_bis,
            A.preisaktiviert_fg,
            A.kjwo_von,
            A.aktion_typ_id,
            A.td_update,
            A.td_insert,
            CASE
                WHEN b.bonuskauf_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_1 AS A
        LEFT JOIN (
            SELECT *
            FROM dbp_data.l_bonuskauf_1
            WHERE mandant_id = 1
        ) AS b
            ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
        WHERE
            A.mandant_id = 1
            AND CASE
                WHEN b.bonuskauf_id IS NOT NULL OR b.bonuskauf_id IS NULL AND A.preisaktiviert_fg = 1
                    THEN 1
                ELSE 0
            END = 1
    ) AS akt
    INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AKTA
        ON
            akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
            AKTA.mandant_id
    INNER JOIN dbp_data.tag_1 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 4
    INNER JOIN dbp_data.tag_1 AS X2
        ON akt.dat_bis = X2.dat AND X2.wtag_id = 3 AND DATE_SUB(
            X2.dat, INTERVAL
            6 DAY
        ) = X1.dat
    WHERE
        AKTA.dat_sperrung IS NULL
        AND akt.mandant_id = 1
        AND X1.akt_wo = 0
        AND 5 IN (
            SELECT wtag_id
            FROM dbp_data.tag_1
            WHERE dat = CURRENT_DATE("Europe/Berlin")
        )
    GROUP BY
        X1.kjwo,
        akt.dat_von,
        akt.dat_bis,
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        werbetyp_id,
        akt.avq_relevant_fg
);


INSERT INTO `_werbeartikel_1_neu`
(
    SELECT
        X1.kjwo,
        akt.dat_von,
        akt.dat_bis,
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        3 AS werbetyp_id,
        akt.avq_relevant_fg
    FROM (
        SELECT
            A.aktion_id,
            A.mandant_id,
            A.bewart_id,
            A.aktionsart_id,
            A.werbe_kat_id,
            A.dat_von,
            A.dat_bis,
            A.preisaktiviert_fg,
            A.kjwo_von,
            A.aktion_typ_id,
            A.td_update,
            A.td_insert,
            CASE
                WHEN b.bonuskauf_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_1 AS A
        LEFT JOIN (
            SELECT *
            FROM dbp_data.l_bonuskauf_1
            WHERE mandant_id = 1
        ) AS b
            ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
        WHERE
            A.mandant_id = 1
            AND CASE
                WHEN b.bonuskauf_id IS NOT NULL OR b.bonuskauf_id IS NULL AND A.preisaktiviert_fg = 1
                    THEN 1
                ELSE 0
            END = 1
    ) AS akt
    INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AKTA
        ON
            akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
            AKTA.mandant_id
    INNER JOIN dbp_data.tag_1 AS X1 ON akt.dat_von = DATE_ADD(X1.dat, INTERVAL 7 DAY) AND X1.wtag_id = 1
    INNER JOIN dbp_data.tag_1 AS X2
        ON
            akt.dat_bis = DATE_ADD(X2.dat, INTERVAL 7 DAY) AND X2.wtag_id = 3 AND
            DATE_SUB(X2.dat, INTERVAL 2 DAY) = X1.dat
    WHERE
        AKTA.dat_sperrung IS NULL
        AND akt.mandant_id = 1
        AND X1.akt_wo = 0
        AND 5 IN (
            SELECT wtag_id
            FROM dbp_data.tag_1
            WHERE dat = CURRENT_DATE("Europe/Berlin")
        )
    GROUP BY
        X1.kjwo,
        akt.dat_von,
        akt.dat_bis,
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        werbetyp_id,
        akt.avq_relevant_fg
);


INSERT INTO `_werbeartikel_1_neu`
(
    SELECT
        X1.kjwo,
        DATE_ADD(akt.dat_von, INTERVAL 1 DAY),
        akt.dat_bis,
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        3 AS werbetyp_id,
        akt.avq_relevant_fg
    FROM (
        SELECT
            A.aktion_id,
            A.mandant_id,
            A.bewart_id,
            A.aktionsart_id,
            A.werbe_kat_id,
            A.dat_von,
            A.dat_bis,
            A.preisaktiviert_fg,
            A.kjwo_von,
            A.aktion_typ_id,
            A.td_update,
            A.td_insert,
            CASE
                WHEN b.bonuskauf_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_1 AS A
        LEFT JOIN (
            SELECT *
            FROM dbp_data.l_bonuskauf_1
            WHERE mandant_id = 1
        ) AS b
            ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
        WHERE
            A.mandant_id = 1
            AND CASE
                WHEN b.bonuskauf_id IS NOT NULL OR b.bonuskauf_id IS NULL AND A.preisaktiviert_fg = 1
                    THEN 1
                ELSE 0
            END = 1
    ) AS akt
    INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AKTA
        ON
            akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
            AKTA.mandant_id
    INNER JOIN dbp_data.tag_1 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 7
    INNER JOIN dbp_data.tag_1 AS X2
        ON akt.dat_bis = X2.dat AND X2.wtag_id = 3 AND DATE_SUB(
            X2.dat, INTERVAL
            3 DAY
        ) = X1.dat
    WHERE
        AKTA.dat_sperrung IS NULL
        AND akt.mandant_id = 1
        AND X1.akt_wo = 0
        AND 5 IN (
            SELECT wtag_id
            FROM dbp_data.tag_1
            WHERE dat = CURRENT_DATE("Europe/Berlin")
        )
        AND (X1.kjwo, AKTA.wup_id, AKTA.mandant_id, AKTA.art_id, 3) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_neu`)
    GROUP BY
        X1.kjwo,
        DATE_ADD(akt.dat_von, INTERVAL 1 DAY),
        akt.dat_bis,
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        werbetyp_id,
        akt.avq_relevant_fg
);


INSERT INTO `_werbeartikel_1_neu`
(
    SELECT
        X1.kjwo,
        akt.dat_von,
        akt.dat_bis,
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        4 AS werbetyp_id,
        akt.avq_relevant_fg
    FROM (
        SELECT
            A.aktion_id,
            A.mandant_id,
            A.bewart_id,
            A.aktionsart_id,
            A.werbe_kat_id,
            A.dat_von,
            A.dat_bis,
            A.preisaktiviert_fg,
            A.kjwo_von,
            A.aktion_typ_id,
            A.td_update,
            A.td_insert,
            CASE
                WHEN b.bonuskauf_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_1 AS A
        LEFT JOIN (
            SELECT *
            FROM dbp_data.l_bonuskauf_1
            WHERE mandant_id = 1
        ) AS b
            ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
        WHERE
            A.mandant_id = 1
            AND CASE
                WHEN b.bonuskauf_id IS NOT NULL OR b.bonuskauf_id IS NULL AND A.preisaktiviert_fg = 1
                    THEN 1
                ELSE 0
            END = 1
    ) AS akt
    INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AKTA
        ON
            akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
            AKTA.mandant_id
    INNER JOIN dbp_data.tag_1 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 4
    INNER JOIN dbp_data.tag_1 AS X2
        ON akt.dat_bis = X2.dat AND X2.wtag_id = 6 AND DATE_SUB(
            X2.dat, INTERVAL
            2 DAY
        ) = X1.dat
    WHERE
        AKTA.dat_sperrung IS NULL
        AND akt.mandant_id = 1
        AND X1.akt_wo = 0
        AND 5 IN (
            SELECT wtag_id
            FROM dbp_data.tag_1
            WHERE dat = CURRENT_DATE("Europe/Berlin")
        )
    GROUP BY
        X1.kjwo,
        akt.dat_von,
        akt.dat_bis,
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        werbetyp_id,
        akt.avq_relevant_fg
);


INSERT INTO `_werbeartikel_1_neu` (
    kjwo, dat_von, dat_bis, wup_id, mandant_id, art_id, akt_wo, werbetyp_id,
    avq_relevant_fg
)
(
    SELECT
        X1.kjwo,
        akt.dat_von,
        DATE_SUB(akt.dat_bis, INTERVAL 1 DAY),
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        4 AS werbetyp_id,
        akt.avq_relevant_fg
    FROM (
        SELECT
            A.aktion_id,
            A.mandant_id,
            A.bewart_id,
            A.aktionsart_id,
            A.werbe_kat_id,
            A.dat_von,
            A.dat_bis,
            A.preisaktiviert_fg,
            A.kjwo_von,
            A.aktion_typ_id,
            A.td_update,
            A.td_insert,
            CASE
                WHEN b.bonuskauf_id IS NOT NULL
                    THEN 0
                ELSE 1
            END AS avq_relevant_fg
        FROM dbp_data.aktion_1 AS A
        LEFT JOIN (
            SELECT *
            FROM dbp_data.l_bonuskauf_1
            WHERE mandant_id = 1
        ) AS b
            ON A.mandant_id = b.mandant_id AND A.aktion_id = b.aktion_id
        WHERE
            A.mandant_id = 1
            AND CASE
                WHEN b.bonuskauf_id IS NOT NULL OR b.bonuskauf_id IS NULL AND A.preisaktiviert_fg = 1
                    THEN 1
                ELSE 0
            END = 1
    ) AS akt
    INNER JOIN dbp_data.aktion_art_wup_zu_1 AS AKTA
        ON
            akt.aktion_id = AKTA.aktion_id AND akt.mandant_id =
            AKTA.mandant_id
    INNER JOIN dbp_data.tag_1 AS X1 ON akt.dat_von = X1.dat AND X1.wtag_id = 4
    INNER JOIN dbp_data.tag_1 AS X2
        ON akt.dat_bis = X2.dat AND X2.wtag_id = 7 AND DATE_SUB(
            X2.dat, INTERVAL
            3 DAY
        ) = X1.dat
    WHERE
        AKTA.dat_sperrung IS NULL
        AND akt.mandant_id = 1
        AND X1.akt_wo = 0
        AND 5 IN (
            SELECT wtag_id
            FROM dbp_data.tag_1
            WHERE dat = CURRENT_DATE("Europe/Berlin")
        )
        AND (X1.kjwo, AKTA.wup_id, AKTA.mandant_id, AKTA.art_id, 4) NOT IN (SELECT (
            kjwo, wup_id, mandant_id, art_id,
            werbetyp_id
        )
        FROM `_werbeartikel_1_neu`)
    GROUP BY
        X1.kjwo,
        werbetyp_id,
        akt.dat_von,
        DATE_SUB(akt.dat_bis, INTERVAL 1 DAY),
        AKTA.wup_id,
        AKTA.mandant_id,
        AKTA.art_id,
        X1.akt_wo,
        akt.avq_relevant_fg
);


CREATE OR REPLACE TEMPORARY TABLE _ff_mutter_art_neu AS
SELECT
    mandant_id,
    art_id,
    COALESCE(mutter_wb_id, art_id) AS mutter_wb_id
FROM dbp_data.art_1 AS A
WHERE
    dat_bis = DATE '9999-12-31'
    AND (
        mandant_id, art_id) IN (
        SELECT (mandant_id, art_id)
        FROM `_werbeartikel_1_neu`
        GROUP BY mandant_id,
        art_id
    )
GROUP BY
    mandant_id,
    art_id,
    mutter_wb_id;


DELETE FROM dbp_process.werbung_kennzahlen_kopf_1
WHERE (
    mandant_id, kjwo) IN (
    SELECT (mandant_id, kjwo)
    FROM `_werbeartikel_1_neu`
);


INSERT INTO dbp_process.werbung_kennzahlen_kopf_1 (
    kjwo, wup_id, nb_id, mandant_id, art_id, werbe_typ_id,
    posten_id, faktor_flaki, mutter_wb_id, wtag_id_start, wtag_id_ende, avq_relevant_fg
)
(
    SELECT
        A.kjwo,
        A.wup_id,
        0 AS nb_id,
        A.mandant_id,
        A.art_id,
        A.werbetyp_id AS werbe_typ_id,
        '' AS posten_id,
        1 AS faktor_flaki,
        D.mutter_wb_id AS mutter_wb_id,
        B.wtag_id AS wtag_id_start,
        C.wtag_id AS wtag_id_ende,
        A.avq_relevant_fg
    FROM `_werbeartikel_1_neu` AS A
    INNER JOIN dbp_data.tag_1 AS B
        ON CASE
            WHEN A.werbetyp_id = 1
                THEN DATE_ADD(A.dat_von, INTERVAL 1 DAY)
            ELSE A.dat_von
        END = B.dat
    INNER JOIN dbp_data.tag_1 AS C ON A.dat_bis = C.dat
    INNER JOIN `_ff_mutter_art_neu` AS D ON A.mandant_id = D.mandant_id AND A.art_id = D.art_id
    WHERE
        5 IN (
            SELECT wtag_id
            FROM dbp_data.tag_1
            WHERE dat = CURRENT_DATE("Europe/Berlin")
        )
);


-- 06.12.2016, -dbay-
--
-- Warengruppe 260 fuer DE komplett raus


DELETE FROM dbp_process.werbung_kennzahlen_kopf_1
WHERE (kjwo, wup_id, nb_id, mandant_id, art_id, werbe_typ_id) IN (
    SELECT (
        A.kjwo, A.wup_id, A.nb_id, A.mandant_id, A.art_id,
        A.werbe_typ_id
    )
    FROM dbp_process.werbung_kennzahlen_kopf_1 AS A
    INNER JOIN dbp_data.art_wg_zu_per_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
            = 2 AND B.dat_bis = DATE '9999-12-31'
    WHERE
        A.mandant_id = 1
        AND B.wg_id IN (260)
        AND A.kjwo IN (
            SELECT kjwo
            FROM dbp_data.tag_1
            WHERE akt_wo = 0
        )
) AND 5 IN (
    SELECT wtag_id
    FROM dbp_data.tag_1
    WHERE dat = CURRENT_DATE("Europe/Berlin")
);
