/* AW check 2021-05-17*/


TRUNCATE TABLE dbp_data.marktabschriften_coi_2;


INSERT INTO dbp_data.marktabschriften_coi_2 (
    wup_id, wup_abschrift_id, positionsnummer_id, nb_id, dat,
    mandant_id,
    lastupd_dat,
    woche_id,
    menge_abschrift,
    abschriftart_id,
    art_id,
    abschriftbetrag_netto,
    abschriftbetrag_brutto,
    wrg_id,
    wv_kz,
    wv_grund_id,
    vk_aktion_brutto,
    vk_brutto
)
(SELECT
    wup_id,
    wup_abschrift_id,
    positionsnummer_id,
    nb_id,
    dat,
    mandant_id,
    lastupd_dat,
    woche_id,
    menge_abschrift,
    abschriftart_id,
    art_id,
    abschriftbetrag_netto,
    abschriftbetrag_brutto,
    wrg_id,
    wv_kz,
    wv_grund_id,
    vk_aktion_brutto,
    vk_brutto
FROM dbp_data.marktabschriften_2
WHERE dat BETWEEN (
    SELECT MIN(dat)
    FROM dbp_data.tag_2
    WHERE akt_mo = -24
) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
)
AND (mandant_id = 1 AND abschriftart_id IN (
    5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120, 121, 122, 151,
    152, 153, 154, 155, 156, 157, 158
)
OR abschriftart_id IS NULL
OR mandant_id > 1 AND abschriftart_id IN (
    905,
    906,
    917,
    918,
    919,
    920,
    935,
    936,
    947,
    948,
    949,
    950,
    953,
    954,
    963,
    964,
    971,
    972,
    973,
    974,
    975,
    976,
    981,
    982,
    983, 984, 985, 986, 987, 988
)));


INSERT INTO dbp_data.marktabschriften_coi_2 (
    wup_id, wup_abschrift_id, positionsnummer_id, nb_id, dat,
    mandant_id,
    lastupd_dat,
    woche_id,
    menge_abschrift,
    abschriftart_id,
    art_id,
    abschriftbetrag_netto,
    abschriftbetrag_brutto,
    wrg_id,
    wv_kz,
    wv_grund_id,
    vk_aktion_brutto,
    vk_brutto
)
(
    SELECT
        wup_id,
        -1 AS wup_abschrift_id,
        -1 AS positionsnummer,
        nb_id,
        dat_umbew AS dat,
        mandant_id,
        DATE('1900-01-01') AS lastupd_dat,
        999999 AS woche_id,
        SUM(0) AS menge_abschrift,
        preis_aend_grund_id AS abschriftart_id,
        art_id,
        SUM(diff_wert_bestand_netto) AS abschriftbetrag_netto,
        SUM(diff_wert_bestand_brutto) AS abschriftbetrag_brutto,
        wrg_id,
        '' AS wv_kz,
        0 AS wv_grund_id,
        0 AS vk_aktion_brutto,
        0 AS vk_aktion_netto
    FROM dbp_data.art_umbewertung_2 AS A
    WHERE
        mandant_id > 1
        AND (
            mandant_id IN (2, 5) AND preis_aend_grund_id IN (7, 10)
            OR mandant_id IN (6) AND preis_aend_grund_id IN (2)
            OR mandant_id IN (3) AND preis_aend_grund_id IN (11) OR mandant_id IN (4, 7, 8) AND preis_aend_grund_id IN (7)
        )
        AND dat_umbew BETWEEN (
            SELECT MIN(dat)
            FROM dbp_data.tag_2
            WHERE akt_mo = -24
        ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY)
        )
    GROUP BY
        wup_id,
        wup_abschrift_id,
        positionsnummer,
        nb_id,
        dat,
        mandant_id,
        lastupd_dat,
        woche_id,
        abschriftart_id,
        art_id,
        wrg_id,
        wv_kz,
        wv_grund_id,
        vk_aktion_brutto,
        vk_aktion_netto
);


TRUNCATE TABLE dbp_msi_data.marktabschriften_coi_mo_2;


-- Vorjahr
INSERT INTO dbp_msi_data.marktabschriften_coi_mo_2 (
    wup_id, nb_id, kjmo, mandant_id,
    abschriftart_id,
    art_id,
    abschriftbetrag_netto,
    abschriftbetrag_netto_vj,
    wrg_id,
    wup_bereinigt_fg
)
(SELECT
    wup_id,
    nb_id,
    kjmo,
    mandant_id,
    abschriftart_id,
    art_id,
    CAST(abschriftbetrag_netto AS NUMERIC) AS abschriftbetrag_netto,
    CAST(abschriftbetrag_netto_vj AS NUMERIC) AS abschriftbetrag_netto_vj,
    wrg_id,
    wup_bereinigt_fg
FROM (
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        TAG.kjmo,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1
            ELSE FACT.abschriftbetrag_netto
        END AS abschriftbetrag_netto,
        0 AS abschriftbetrag_netto_vj,
        FACT.wrg_id,
        0 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    WHERE
        FACT.mandant_id = 1
        AND FACT.abschriftart_id IN (
            5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
            121, 122, 151, 152, 153, 154, 155, 156, 157, 158
        )
        OR FACT.abschriftart_id IS NULL
        OR FACT.mandant_id > 1 AND FACT.abschriftart_id IN (
            905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950, 953,
            954,
            963,
            964,
            971,
            972,
            973,
            974,
            975,
            976,
            981,
            982,
            983,
            984,
            985,
            986,
            987,
            988
        )
        OR FACT.mandant_id = 2 AND FACT.abschriftart_id IN (7, 10)
        OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11)
        OR FACT.mandant_id = 4 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
        OR FACT.mandant_id = 6 AND FACT.abschriftart_id IN (2)
        OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id = 8 AND FACT.abschriftart_id IN (7)
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        TAG.kjmo,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1 * KU.umrechnungskurs
            ELSE FACT.abschriftbetrag_netto * KU.umrechnungskurs
        END AS abschriftbetrag_netto,
        0 AS abschriftbetrag_netto_vj,
        'EUR' AS wrg_id,
        0 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.kurs_2 AS KU
        ON
            FACT.wrg_id = KU.von_wrg_id AND KU.kurstyp_id = 3 AND KU.dat_bis
            = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    WHERE
        FACT.wrg_id <> 'EUR'
        AND (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
            5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
            121, 122, 151, 152, 153, 154, 155, 156, 157, 158
        ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
        > 1 AND FACT.abschriftart_id IN (
            905,
            906,
            917,
            918,
            919,
            920,
            935,
            936,
            947,
            948,
            949,
            950,
            953,
            954,
            963,
            964,
            971,
            972,
            973,
            974,
            975,
            976,
            981,
            982,
            983,
            984,
            985,
            986,
            987,
            988
        ) OR FACT.mandant_id = 2
        AND FACT.abschriftart_id IN (7, 10) OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11) OR FACT.mandant_id
        = 4 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
        OR FACT.mandant_id
        = 6 AND FACT.abschriftart_id IN (2)
        OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id
        = 8 AND FACT.abschriftart_id IN (7))
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        TAG.kjmo,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1
            ELSE FACT.abschriftbetrag_netto
        END AS abschriftbetrag_netto,
        0 AS abschriftbetrag_netto_vj,
        FACT.wrg_id,
        1 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    INNER JOIN dbp_data.wup_2 AS WUP_2
        ON
            FACT.mandant_id = WUP.mandant_id AND FACT.nb_id = WUP.nb_id
            AND FACT.wup_id = WUP.wup_id
    WHERE (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
        5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
        121, 122, 151, 152, 153, 154, 155, 156, 157, 158
    ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
    > 1 AND FACT.abschriftart_id IN (
        905,
        906,
        917,
        918,
        919,
        920,
        935,
        936,
        947,
        948,
        949,
        950,
        953,
        954,
        963,
        964,
        971,
        972,
        973,
        974,
        975,
        976,
        981,
        982,
        983,
        984,
        985,
        986,
        987,
        988
    ) OR FACT.mandant_id = 2
    AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11)
    OR FACT.mandant_id
    = 4 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id
    = 6 AND FACT.abschriftart_id IN (2)
    OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id
    = 8 AND FACT.abschriftart_id IN (7))
    AND TAG.wo_dat_von > IF(
        WUP.dat_von = LAST_DAY(WUP.dat_von),
        LAST_DAY(DATE_ADD(WUP.dat_von, INTERVAL 12 MONTH)),
        DATE_ADD(WUP.dat_von, INTERVAL 12 MONTH)
    )
    AND TAG.wo_dat_bis < WUP.dat_bis
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        TAG.kjmo,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1 * KU.umrechnungskurs
            ELSE FACT.abschriftbetrag_netto * KU.umrechnungskurs
        END AS abschriftbetrag_netto,
        0 AS abschriftbetrag_netto_vj,
        'EUR' AS wrg_id,
        1 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.kurs_2 AS KU
        ON
            FACT.wrg_id = KU.von_wrg_id AND KU.kurstyp_id = 3 AND KU.dat_bis
            = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    INNER JOIN dbp_data.wup_2 AS WUP_2
        ON
            FACT.mandant_id = WUP.mandant_id AND FACT.nb_id = WUP.nb_id
            AND FACT.wup_id = WUP.wup_id
    WHERE
        FACT.wrg_id <> 'EUR'
        AND (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
            5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
            121, 122, 151, 152, 153, 154, 155, 156, 157, 158
        ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
        > 1 AND FACT.abschriftart_id IN (
            905,
            906,
            917,
            918,
            919,
            920,
            935,
            936,
            947,
            948,
            949,
            950,
            953,
            954,
            963,
            964,
            971,
            972,
            973,
            974,
            975,
            976,
            981,
            982,
            983,
            984,
            985,
            986,
            987,
            988
        ) OR FACT.mandant_id = 2
        AND FACT.abschriftart_id IN (7, 10) OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11) OR FACT.mandant_id
        = 4 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
        OR FACT.mandant_id
        = 6 AND FACT.abschriftart_id IN (2)
        OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id
        = 8 AND FACT.abschriftart_id IN (7))
        AND TAG.wo_dat_von > IF(
            WUP.dat_von = LAST_DAY(WUP.dat_von),
            LAST_DAY(DATE_ADD(WUP.dat_von, INTERVAL 12 MONTH)),
            DATE_ADD(WUP.dat_von, INTERVAL 12 MONTH)
        )
        AND TAG.wo_dat_bis < WUP.dat_bis
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        TAG.kjmo + 100,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        0 AS abschriftbetrag_netto,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1
            ELSE FACT.abschriftbetrag_netto
        END AS abschriftbetrag_netto_vj,
        FACT.wrg_id,
        0 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    WHERE (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
        5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
        121, 122, 151, 152, 153, 154, 155, 156, 157, 158
    ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
    > 1 AND FACT.abschriftart_id IN (
        905,
        906,
        917,
        918,
        919,
        920,
        935,
        936,
        947,
        948,
        949,
        950,
        953,
        954,
        963,
        964,
        971,
        972,
        973,
        974,
        975,
        976,
        981,
        982,
        983,
        984,
        985,
        986,
        987,
        988
    ) OR FACT.mandant_id = 2
    AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11)
    OR FACT.mandant_id
    = 4 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id
    = 6 AND FACT.abschriftart_id IN (2)
    OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id
    = 8 AND FACT.abschriftart_id IN (7))
    AND TAG.akt_tag <= -365
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        TAG.kjmo + 100,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        0 AS abschriftbetrag_netto,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1 * KU.umrechnungskurs
            ELSE FACT.abschriftbetrag_netto * KU.umrechnungskurs
        END AS abschriftbetrag_netto_vj,
        'EUR' AS wrg_id,
        0 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.kurs_2 AS KU
        ON
            FACT.wrg_id = KU.von_wrg_id AND KU.kurstyp_id = 3 AND KU.dat_bis
            = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    WHERE
        FACT.wrg_id <> 'EUR'
        AND (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
            5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
            121, 122, 151, 152, 153, 154, 155, 156, 157, 158
        ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
        > 1 AND FACT.abschriftart_id IN (
            905,
            906,
            917,
            918,
            919,
            920,
            935,
            936,
            947,
            948,
            949,
            950,
            953,
            954,
            963,
            964,
            971,
            972,
            973,
            974,
            975,
            976,
            981,
            982,
            983,
            984,
            985,
            986,
            987,
            988
        ) OR FACT.mandant_id = 2
        AND FACT.abschriftart_id IN (7, 10) OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11) OR FACT.mandant_id
        = 4 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
        OR FACT.mandant_id
        = 6 AND FACT.abschriftart_id IN (2)
        OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id
        = 8 AND FACT.abschriftart_id IN (7))
        AND TAG.akt_tag <= -365
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        TAG.kjmo + 100,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        0 AS abschriftbetrag_netto,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1
            ELSE FACT.abschriftbetrag_netto
        END AS abschriftbetrag_netto_vj,
        FACT.wrg_id,
        1 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    INNER JOIN dbp_data.wup_2 AS WUP_2
        ON
            FACT.mandant_id = WUP.mandant_id AND FACT.nb_id = WUP.nb_id
            AND FACT.wup_id = WUP.wup_id
    WHERE (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
        5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
        121, 122, 151, 152, 153, 154, 155, 156, 157, 158
    ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
    > 1 AND FACT.abschriftart_id IN (
        905,
        906,
        917,
        918,
        919,
        920,
        935,
        936,
        947,
        948,
        949,
        950,
        953,
        954,
        963,
        964,
        971,
        972,
        973,
        974,
        975,
        976,
        981,
        982,
        983,
        984,
        985,
        986,
        987,
        988
    ) OR FACT.mandant_id = 2
    AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11)
    OR FACT.mandant_id
    = 4 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id
    = 6 AND FACT.abschriftart_id IN (2)
    OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id
    = 8 AND FACT.abschriftart_id IN (7))
    AND TAG.wo_dat_von > IF(
        WUP.dat_von = LAST_DAY(WUP.dat_von),
        LAST_DAY(DATE_ADD(WUP.dat_von, INTERVAL 12 MONTH)),
        DATE_ADD(WUP.dat_von, INTERVAL 12 MONTH)
    )
    AND TAG.wo_dat_bis < WUP.dat_bis
    AND TAG.akt_tag <= -365
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        TAG.kjmo + 100,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        0 AS abschriftbetrag_netto,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1 * KU.umrechnungskurs
            ELSE FACT.abschriftbetrag_netto * KU.umrechnungskurs
        END AS abschriftbetrag_netto_vj,
        'EUR' AS wrg_id,
        1 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.kurs_2 AS KU
        ON
            FACT.wrg_id = KU.von_wrg_id AND KU.kurstyp_id = 3 AND KU.dat_bis
            = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    INNER JOIN dbp_data.wup_2 AS WUP_2
        ON
            FACT.mandant_id = WUP.mandant_id AND FACT.nb_id = WUP.nb_id
            AND FACT.wup_id = WUP.wup_id
    WHERE
        FACT.wrg_id <> 'EUR'
        AND (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
            5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
            121, 122, 151, 152, 153, 154, 155, 156, 157, 158
        ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
        > 1 AND FACT.abschriftart_id IN (
            905,
            906,
            917,
            918,
            919,
            920,
            935,
            936,
            947,
            948,
            949,
            950,
            953,
            954,
            963,
            964,
            971,
            972,
            973,
            974,
            975,
            976,
            981,
            982,
            983,
            984,
            985,
            986,
            987,
            988
        ) OR FACT.mandant_id = 2
        AND FACT.abschriftart_id IN (7, 10) OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11) OR FACT.mandant_id
        = 4 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
        OR FACT.mandant_id
        = 6 AND FACT.abschriftart_id IN (2)
        OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id
        = 8 AND FACT.abschriftart_id IN (7))
        AND TAG.wo_dat_von > IF(
            WUP.dat_von = LAST_DAY(WUP.dat_von),
            LAST_DAY(DATE_ADD(WUP.dat_von, INTERVAL 12 MONTH)),
            DATE_ADD(WUP.dat_von, INTERVAL 12 MONTH)
        )
        AND TAG.wo_dat_bis < WUP.dat_bis
        AND TAG.akt_tag <= -365
) AS t15);


TRUNCATE TABLE dbp_msi_data.marktabschriften_coi_dat_2;


-- Vorjahr
INSERT INTO dbp_msi_data.marktabschriften_coi_dat_2 (
    wup_id, nb_id, dat, mandant_id,
    abschriftart_id,
    art_id,
    abschriftbetrag_netto,
    abschriftbetrag_netto_vj,
    wrg_id,
    wup_bereinigt_fg
)
(SELECT
    wup_id,
    nb_id,
    dat,
    mandant_id,
    abschriftart_id,
    art_id,
    CAST(abschriftbetrag_netto AS NUMERIC) AS abschriftbetrag_netto,
    CAST(abschriftbetrag_netto_vj AS NUMERIC) AS abschriftbetrag_netto_vj,
    wrg_id,
    wup_bereinigt_fg
FROM (
    SELECT
        wup_id,
        nb_id,
        dat,
        mandant_id,
        abschriftart_id,
        art_id,
        CASE
            WHEN
                mandant_id > 1
                AND abschriftart_id IN (
                    905,
                    906,
                    917,
                    918,
                    919,
                    920,
                    935,
                    936,
                    947,
                    948,
                    949,
                    950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR mandant_id = 1
                THEN abschriftbetrag_netto * -1
            ELSE abschriftbetrag_netto
        END AS abschriftbetrag_netto,
        0 AS abschriftbetrag_netto_vj,
        wrg_id,
        0 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    WHERE
        mandant_id = 1
        AND abschriftart_id IN (
            5,
            7,
            9,
            10,
            23,
            32,
            100,
            101,
            102,
            103,
            104,
            105,
            107,
            120,
            121,
            122,
            151, 152, 153, 154, 155, 156, 157, 158
        )
        OR abschriftart_id IS NULL
        OR mandant_id > 1 AND abschriftart_id IN (
            905,
            906,
            917,
            918,
            919,
            920,
            935,
            936,
            947,
            948,
            949,
            950,
            953,
            954,
            963,
            964,
            971,
            972,
            973,
            974,
            975,
            976,
            981,
            982,
            983,
            984,
            985,
            986,
            987,
            988
        )
        OR mandant_id = 2 AND abschriftart_id IN (7, 10)
        OR mandant_id = 3 AND abschriftart_id IN (11)
        OR mandant_id = 4 AND abschriftart_id IN (7)
        OR mandant_id = 5 AND abschriftart_id IN (7, 10)
        OR mandant_id = 6 AND abschriftart_id IN (2)
        OR mandant_id = 7 AND abschriftart_id IN (7)
        OR mandant_id = 8 AND abschriftart_id IN (7)
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        FACT.dat,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1 * KU.umrechnungskurs
            ELSE FACT.abschriftbetrag_netto * KU.umrechnungskurs
        END AS abschriftbetrag_netto,
        0 AS abschriftbetrag_netto_vj,
        'EUR' AS wrg_id,
        0 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.kurs_2 AS KU
        ON
            FACT.wrg_id = KU.von_wrg_id AND KU.kurstyp_id = 3 AND KU.dat_bis
            = PARSE_DATE('%F', '9999-12-31')
    WHERE
        FACT.wrg_id <> 'EUR'
        AND (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
            5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
            121, 122, 151, 152, 153, 154, 155, 156, 157, 158
        ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
        > 1 AND FACT.abschriftart_id IN (
            905,
            906,
            917,
            918,
            919,
            920,
            935,
            936,
            947,
            948,
            949,
            950,
            953,
            954,
            963,
            964,
            971,
            972,
            973,
            974,
            975,
            976,
            981,
            982,
            983,
            984,
            985,
            986,
            987,
            988
        ) OR FACT.mandant_id = 2
        AND FACT.abschriftart_id IN (7, 10) OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11) OR FACT.mandant_id
        = 4 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
        OR FACT.mandant_id
        = 6 AND FACT.abschriftart_id IN (2)
        OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id
        = 8 AND FACT.abschriftart_id IN (7))
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        FACT.dat,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1
            ELSE FACT.abschriftbetrag_netto
        END AS abschriftbetrag_netto,
        0 AS abschriftbetrag_netto_vj,
        FACT.wrg_id,
        1 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    INNER JOIN dbp_data.wup_2 AS WUP_2
        ON
            FACT.mandant_id = WUP.mandant_id AND FACT.nb_id = WUP.nb_id
            AND FACT.wup_id = WUP.wup_id
    WHERE (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
        5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
        121, 122, 151, 152, 153, 154, 155, 156, 157, 158
    ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
    > 1 AND FACT.abschriftart_id IN (
        905,
        906,
        917,
        918,
        919,
        920,
        935,
        936,
        947,
        948,
        949,
        950,
        953,
        954,
        963,
        964,
        971,
        972,
        973,
        974,
        975,
        976,
        981,
        982,
        983,
        984,
        985,
        986,
        987,
        988
    ) OR FACT.mandant_id = 2
    AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11)
    OR FACT.mandant_id
    = 4 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id
    = 6 AND FACT.abschriftart_id IN (2)
    OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id
    = 8 AND FACT.abschriftart_id IN (7))
    AND TAG.wo_dat_von > DATE_ADD(WUP.dat_von, INTERVAL 364 DAY)
    AND TAG.wo_dat_bis < WUP.dat_bis
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        FACT.dat,
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1 * KU.umrechnungskurs
            ELSE FACT.abschriftbetrag_netto * KU.umrechnungskurs
        END AS abschriftbetrag_netto,
        0 AS abschriftbetrag_netto_vj,
        'EUR' AS wrg_id,
        1 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.kurs_2 AS KU
        ON
            FACT.wrg_id = KU.von_wrg_id AND KU.kurstyp_id = 3 AND KU.dat_bis
            = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    INNER JOIN dbp_data.wup_2 AS WUP_2
        ON
            FACT.mandant_id = WUP.mandant_id AND FACT.nb_id = WUP.nb_id
            AND FACT.wup_id = WUP.wup_id
    WHERE
        FACT.wrg_id <> 'EUR'
        AND (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
            5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
            121, 122, 151, 152, 153, 154, 155, 156, 157, 158
        ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
        > 1 AND FACT.abschriftart_id IN (
            905,
            906,
            917,
            918,
            919,
            920,
            935,
            936,
            947,
            948,
            949,
            950,
            953,
            954,
            963,
            964,
            971,
            972,
            973,
            974,
            975,
            976,
            981,
            982,
            983,
            984,
            985,
            986,
            987,
            988
        ) OR FACT.mandant_id = 2
        AND FACT.abschriftart_id IN (7, 10) OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11) OR FACT.mandant_id
        = 4 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
        OR FACT.mandant_id
        = 6 AND FACT.abschriftart_id IN (2)
        OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id
        = 8 AND FACT.abschriftart_id IN (7))
        AND TAG.wo_dat_von > DATE_ADD(WUP.dat_von, INTERVAL 364 DAY)
        AND TAG.wo_dat_bis < WUP.dat_bis
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        DATE_ADD(FACT.dat, INTERVAL 364 DAY),
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        0 AS abschriftbetrag_netto,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1
            ELSE FACT.abschriftbetrag_netto
        END AS abschriftbetrag_netto_vj,
        FACT.wrg_id,
        0 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    WHERE (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
        5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
        121, 122, 151, 152, 153, 154, 155, 156, 157, 158
    ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
    > 1 AND FACT.abschriftart_id IN (
        905,
        906,
        917,
        918,
        919,
        920,
        935,
        936,
        947,
        948,
        949,
        950,
        953,
        954,
        963,
        964,
        971,
        972,
        973,
        974,
        975,
        976,
        981,
        982,
        983,
        984,
        985,
        986,
        987,
        988
    ) OR FACT.mandant_id = 2
    AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11)
    OR FACT.mandant_id
    = 4 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id
    = 6 AND FACT.abschriftart_id IN (2)
    OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id
    = 8 AND FACT.abschriftart_id IN (7))
    AND TAG.akt_tag <= -364
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        DATE_ADD(FACT.dat, INTERVAL 364 DAY),
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        0 AS abschriftbetrag_netto,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1 * KU.umrechnungskurs
            ELSE FACT.abschriftbetrag_netto * KU.umrechnungskurs
        END AS abschriftbetrag_netto_vj,
        'EUR' AS wrg_id,
        0 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.kurs_2 AS KU
        ON
            FACT.wrg_id = KU.von_wrg_id AND KU.kurstyp_id = 3 AND KU.dat_bis
            = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    WHERE
        FACT.wrg_id <> 'EUR'
        AND (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
            5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
            121, 122, 151, 152, 153, 154, 155, 156, 157, 158
        ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
        > 1 AND FACT.abschriftart_id IN (
            905,
            906,
            917,
            918,
            919,
            920,
            935,
            936,
            947,
            948,
            949,
            950,
            953,
            954,
            963,
            964,
            971,
            972,
            973,
            974,
            975,
            976,
            981,
            982,
            983,
            984,
            985,
            986,
            987,
            988
        ) OR FACT.mandant_id = 2
        AND FACT.abschriftart_id IN (7, 10) OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11) OR FACT.mandant_id
        = 4 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
        OR FACT.mandant_id
        = 6 AND FACT.abschriftart_id IN (2)
        OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id
        = 8 AND FACT.abschriftart_id IN (7))
        AND TAG.akt_tag <= -364
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        DATE_ADD(FACT.dat, INTERVAL 364 DAY),
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        0 AS abschriftbetrag_netto,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1
            ELSE FACT.abschriftbetrag_netto
        END AS abschriftbetrag_netto_vj,
        FACT.wrg_id,
        1 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    INNER JOIN dbp_data.wup_2 AS WUP_2
        ON
            FACT.mandant_id = WUP.mandant_id AND FACT.nb_id = WUP.nb_id
            AND FACT.wup_id = WUP.wup_id
    WHERE (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
        5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
        121, 122, 151, 152, 153, 154, 155, 156, 157, 158
    ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
    > 1 AND FACT.abschriftart_id IN (
        905,
        906,
        917,
        918,
        919,
        920,
        935,
        936,
        947,
        948,
        949,
        950,
        953,
        954,
        963,
        964,
        971,
        972,
        973,
        974,
        975,
        976,
        981,
        982,
        983,
        984,
        985,
        986,
        987,
        988
    ) OR FACT.mandant_id = 2
    AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11)
    OR FACT.mandant_id
    = 4 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
    OR FACT.mandant_id
    = 6 AND FACT.abschriftart_id IN (2)
    OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
    OR FACT.mandant_id
    = 8 AND FACT.abschriftart_id IN (7))
    AND TAG.wo_dat_von > DATE_ADD(WUP.dat_von, INTERVAL 364 DAY)
    AND TAG.wo_dat_bis < WUP.dat_bis
    AND TAG.akt_tag <= -364
    UNION ALL
    SELECT
        FACT.wup_id,
        FACT.nb_id,
        DATE_ADD(FACT.dat, INTERVAL 364 DAY),
        FACT.mandant_id,
        FACT.abschriftart_id,
        FACT.art_id,
        0 AS abschriftbetrag_netto,
        CASE
            WHEN
                FACT.mandant_id > 1
                AND FACT.abschriftart_id IN (
                    905, 906, 917, 918, 919, 920, 935, 936, 947, 948, 949, 950,
                    953,
                    954,
                    963,
                    964,
                    971,
                    972,
                    973,
                    974,
                    975,
                    976,
                    981,
                    982,
                    983,
                    984,
                    985,
                    986,
                    987,
                    988
                )
                OR FACT.mandant_id
                = 1
                THEN FACT.abschriftbetrag_netto * -1 * KU.umrechnungskurs
            ELSE FACT.abschriftbetrag_netto * KU.umrechnungskurs
        END AS abschriftbetrag_netto_vj,
        'EUR' AS wrg_id,
        1 AS wup_bereinigt_fg
    FROM dbp_data.marktabschriften_coi_2 AS FACT
    INNER JOIN dbp_data.kurs_2 AS KU
        ON
            FACT.wrg_id = KU.von_wrg_id AND KU.kurstyp_id = 3 AND KU.dat_bis
            = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.tag_2 AS TAG_2 ON FACT.dat = TAG.dat
    INNER JOIN dbp_data.wup_2 AS WUP_2
        ON
            FACT.mandant_id = WUP.mandant_id AND FACT.nb_id = WUP.nb_id
            AND FACT.wup_id = WUP.wup_id
    WHERE
        FACT.wrg_id <> 'EUR'
        AND (FACT.mandant_id = 1 AND FACT.abschriftart_id IN (
            5, 7, 9, 10, 23, 32, 100, 101, 102, 103, 104, 105, 107, 120,
            121, 122, 151, 152, 153, 154, 155, 156, 157, 158
        ) OR FACT.abschriftart_id IS NULL OR FACT.mandant_id
        > 1 AND FACT.abschriftart_id IN (
            905,
            906,
            917,
            918,
            919,
            920,
            935,
            936,
            947,
            948,
            949,
            950,
            953,
            954,
            963,
            964,
            971,
            972,
            973,
            974,
            975,
            976,
            981,
            982,
            983,
            984,
            985,
            986,
            987,
            988
        ) OR FACT.mandant_id = 2
        AND FACT.abschriftart_id IN (7, 10) OR FACT.mandant_id = 3 AND FACT.abschriftart_id IN (11) OR FACT.mandant_id
        = 4 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id = 5 AND FACT.abschriftart_id IN (7, 10)
        OR FACT.mandant_id
        = 6 AND FACT.abschriftart_id IN (2)
        OR FACT.mandant_id = 7 AND FACT.abschriftart_id IN (7)
        OR FACT.mandant_id
        = 8 AND FACT.abschriftart_id IN (7))
        AND TAG.wo_dat_von > DATE_ADD(WUP.dat_von, INTERVAL 364 DAY)
        AND TAG.wo_dat_bis < WUP.dat_bis
        AND TAG.akt_tag <= -364
) AS t15);
