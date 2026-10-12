/* Neu fuer die Filialumgliederung */
CREATE OR REPLACE TEMPORARY TABLE _backshop_umgliederung AS
SELECT
    a.mandant_id,
    a.art_id,
    c.wup_id,
    c.nb_id,
    a.art_id AS art_id_ref,
    c.orig_wup_id AS wup_id_ref,
    c.nb_id AS nb_id_ref,
    DATE_ADD(c.dat_von, INTERVAL '50' DAY) AS dat_bis_ref,
    1.00 AS faktor_ref,
    CURRENT_TIMESTAMP() AS td_insert,
    CURRENT_TIMESTAMP() AS td_update
FROM dbp_data.art_wg_zu_per_2 AS a
INNER JOIN dbp_data.wg_filter_zu_2 AS b
    ON
        a.wg_id = b.wg_id
        AND a.mandant_id = b.mandant_id
        AND b.wg_filter_id = 3
        AND b.arthiertyp_id = 2
INNER JOIN dbp_data.wup_2 AS c
    ON
        c.wup_aenderung_grund_id = 0
        AND c.wup_id <> c.orig_wup_id
        AND CURRENT_DATE("Europe/Berlin") <= DATE_ADD(c.dat_von, INTERVAL '50' DAY)
WHERE
    a.dat_bis = CAST('9999-12-31' AS DATE)
    AND a.arthiertyp_id = 2
    AND a.mandant_id = 1;

UPDATE dbp_data.art_wup_status_referenz_2 SET dat_bis_ref = t0.dat_bis_ref
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        wup_id_ref,
        dat_bis_ref
    FROM `_backshop_umgliederung`
    GROUP BY
        mandant_id,
        art_id,
        wup_id,
        wup_id_ref,
        dat_bis_ref
) AS t0
WHERE
    art_wup_status_referenz.mandant_id = t0.mandant_id
    AND art_wup_status_referenz.wup_id = t0.wup_id
    AND art_wup_status_referenz.art_id = t0.art_id
    AND art_wup_status_referenz.wup_id_ref = t0.wup_id_ref;

DELETE FROM dbp_data.art_wup_status_referenz_2
WHERE
    (mandant_id, wup_id, art_id, wup_id_ref, art_id_ref) IN (
        SELECT (mandant_id, wup_id, art_id, wup_id_ref, art_id_ref)
        FROM `_backshop_umgliederung`
    );

INSERT INTO dbp_data.art_wup_status_referenz_2 (
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    art_id_ref,
    wup_id_ref,
    nb_id_ref,
    dat_bis_ref,
    faktor_ref,
    td_insert,
    td_update
)
(
    SELECT
        mandant_id,
        art_id,
        wup_id,
        nb_id,
        art_id_ref,
        wup_id_ref,
        nb_id_ref,
        dat_bis_ref,
        CAST(faktor_ref AS NUMERIC),
        td_insert,
        td_update
    FROM `_backshop_umgliederung`
    WHERE
        NOT (mandant_id, wup_id, art_id, wup_id_ref) IN (
            SELECT (mandant_id, wup_id, art_id, wup_id_ref)
            FROM dbp_data.art_wup_status_referenz_2
        )
);

CREATE OR REPLACE TABLE dbp_etl.vis_agg_tmp_2 (
    art_id INT64 NOT NULL,
    mandant_id INT64 NOT NULL,
    wup_id INT64 NOT NULL,
    nb_id INT64 NOT NULL,
    dat DATE NOT NULL,
    menge_prognose NUMERIC(29, 3) NOT NULL,
    menge_prognose_max NUMERIC(29, 3) NOT NULL,
    menge_prognose_aktion NUMERIC(29, 3) NOT NULL,
    min_sicherh_bestand NUMERIC(29, 3) NOT NULL,
    listung_id INT64 NOT NULL,
    aktion_fg INT64 NOT NULL,
    menge_check NUMERIC(29, 3) NOT NULL,
    anteil_01 NUMERIC(29, 2) NOT NULL,
    anteil_02 NUMERIC(29, 2) NOT NULL,
    anteil_03 NUMERIC(29, 2) NOT NULL,
    anteil_04 NUMERIC(29, 2) NOT NULL,
    tagesmenge INT64 NOT NULL,
    gff_menge_stueck INT64 NOT NULL,
    fs1_menge_stueck INT64 NOT NULL,
    fs2_menge_stueck INT64 NOT NULL,
    erw_absatz_spaet INT64 NOT NULL,
    erw_absatz_abend INT64 NOT NULL,
    avg_menge_abschrift INT64 NOT NULL,
    wup_cluster_id INT64 DEFAULT -1 NOT NULL,
    wug_cluster_id INT64 DEFAULT -1 NOT NULL,
    back_drehklasse_id STRING(2) COLLATE 'und:ci' DEFAULT '  ' NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
    menge_schnitt NUMERIC(29, 3)
);

CREATE OR REPLACE TABLE dbp_etl.vis_fur_tmp_2 (
    mandant_id INT64 NOT NULL,
    art_id INT64 NOT NULL,
    wup_id INT64 NOT NULL,
    dat DATE NOT NULL,
    menge_fur_mean NUMERIC(29, 3) NOT NULL,
    menge_fur_max NUMERIC(29, 3) NOT NULL,
    menge_fur_aktion NUMERIC(29, 3) NOT NULL
);

CREATE OR REPLACE TABLE dbp_etl.vis_ods_tmp_2 (
    mandant_id INT64 NOT NULL,
    art_id INT64 NOT NULL,
    wup_id INT64 NOT NULL,
    wtag_id INT64 NOT NULL,
    aktion_fg INT64 NOT NULL,
    menge_ods NUMERIC(29, 3) NOT NULL,
    anz_ods INT64 NOT NULL,
    menge_schnitt NUMERIC(29, 3) NOT NULL,
    back_drehklasse_id STRING(2) NOT NULL,
    menge_01 NUMERIC(29, 3) NOT NULL,
    menge_02 NUMERIC(29, 3) NOT NULL,
    menge_03 NUMERIC(29, 3) NOT NULL,
    menge_04 NUMERIC(29, 3) NOT NULL,
    menge_16 NUMERIC(29, 3) NOT NULL,
    anz_16 INT64 NOT NULL
);

CREATE OR REPLACE TEMPORARY TABLE _vaus AS
SELECT *
FROM dbp_data.vaus_wup_oeffnung_zu_per_2;

UPDATE `_vaus` SET zeit_von = 28800, zeit_bis = 72000
WHERE
    mandant_id = 7
    AND wup_oeffnungs_typ_id = 7
    AND wup_id = 4400
    AND zeit_von = 0
    AND zeit_bis = 0;

INSERT INTO dbp_etl.vis_agg_tmp_2 (
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    dat,
    menge_prognose,
    menge_prognose_max,
    menge_prognose_aktion,
    min_sicherh_bestand,
    listung_id,
    aktion_fg,
    menge_check,
    anteil_01,
    anteil_02,
    anteil_03,
    anteil_04,
    tagesmenge,
    gff_menge_stueck,
    fs1_menge_stueck,
    fs2_menge_stueck,
    erw_absatz_spaet,
    erw_absatz_abend,
    avg_menge_abschrift,
    wup_cluster_id,
    wug_cluster_id,
    back_drehklasse_id,
    aktion_id,
    menge_schnitt
)
(
    SELECT
        a.art_id,
        a.mandant_id,
        awsp.wup_id,
        awsp.nb_id,
        zeit.dat,
        0 AS menge_prognose,
        0 AS menge_prognose_max,
        0 AS menge_prognose_aktion,
        awsp.min_sicherh_bestand,
        awzp.listung_id,
        0 AS aktion_fg,
        0 AS menge_check,
        0 AS anteil_01,
        0 AS anteil_02,
        0 AS anteil_03,
        0 AS anteil_04,
        0 AS tagesmenge,
        0 AS gff_menge_stueck,
        0 AS fs1_menge_stueck,
        0 AS fs2_menge_stueck,
        0 AS erw_absatz_spaet,
        0 AS erw_absatz_abend,
        0 AS avg_menge_abschrift,
        0 AS wup_cluster_id,
        0 AS wug_cluser_id,
        '' AS back_drehklasse_id,
        '' AS aktion_id,
        0 AS menge_schnitt
    FROM dbp_data.art_2 AS a
    INNER JOIN dbp_data.art_wup_status_per_2 AS awsp
        ON
            a.art_id = awsp.art_id
            AND a.mandant_id = awsp.mandant_id
            AND awsp.dat_bis = CAST('9999-12-31' AS DATE)
            AND awsp.nb_id = 0
    INNER JOIN dbp_data.art_wup_zu_per_2 AS awzp
        ON
            awsp.art_id = awzp.art_id
            AND awsp.mandant_id = awzp.mandant_id
            AND awsp.wup_id = awzp.wup_id
            AND awzp.dat_bis = CAST('9999-12-31' AS DATE)
            AND awzp.nb_id = 0
    INNER JOIN (
        SELECT b.dat
        FROM (
            SELECT *
            FROM dbp_data.tag_2
            WHERE
                dat = CURRENT_DATE("Europe/Berlin")
        ) AS a
        INNER JOIN dbp_data.tag_2 AS b
            ON DATE_ADD(a.wo_dat_bis, INTERVAL '1' DAY) = b.wo_dat_von
        GROUP BY
            b.dat
    ) AS zeit_2
        ON TRUE
    WHERE
        (a.mandant_id, a.art_id) IN (
            SELECT (awzp0.mandant_id, awzp0.art_id)
            FROM dbp_data.art_wg_zu_per_2 AS awzp0
            INNER JOIN dbp_data.wg_filter_zu_2 AS wfz
                ON
                    awzp0.wg_id = wfz.wg_id
                    AND awzp0.mandant_id = wfz.mandant_id
                    AND wfz.wg_filter_id = 3
                    AND wfz.arthiertyp_id = 2
            WHERE
                awzp0.dat_bis = CAST('9999-12-31' AS DATE) AND awzp0.arthiertyp_id = 2
        )
        AND (awsp.mandant_id, awsp.wup_id) IN (
            SELECT (mandant_id, wup_id)
            FROM dbp_data.wup_2
            WHERE
                nb_id = 0
                AND DATE_SUB(dat_eroeffnung, INTERVAL '10' DAY) < CURRENT_DATE("Europe/Berlin")
                AND (mandant_id, wup_id) IN (
                    SELECT (mandant_id, wup_id)
                    FROM dbp_data.wup_backshop_per_2
                    WHERE
                        dat_bis = CAST('9999-12-31' AS DATE)
                )
            GROUP BY
                mandant_id,
            wup_id
        )
        AND a.dat_bis = CAST('9999-12-31' AS DATE)
);

DELETE FROM dbp_etl.vis_agg_tmp_2
WHERE
    mandant_id = 3 AND wup_id = 1031;

INSERT INTO dbp_etl.vis_agg_tmp_2 (
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    dat,
    menge_prognose,
    menge_prognose_max,
    menge_prognose_aktion,
    min_sicherh_bestand,
    listung_id,
    aktion_fg,
    menge_check,
    anteil_01,
    anteil_02,
    anteil_03,
    anteil_04,
    tagesmenge,
    gff_menge_stueck,
    fs1_menge_stueck,
    fs2_menge_stueck,
    erw_absatz_spaet,
    erw_absatz_abend,
    avg_menge_abschrift,
    wup_cluster_id,
    wug_cluster_id,
    back_drehklasse_id,
    aktion_id,
    menge_schnitt
)
(
    SELECT DISTINCT
        a.art_id,
        a.mandant_id,
        awzp.wup_id,
        awzp.nb_id,
        zeit.dat,
        0 AS menge_prognose,
        0 AS menge_prognose_max,
        0 AS menge_prognose_aktion,
        0,
        awzp.listung_id,
        0 AS aktion_fg,
        0 AS menge_check,
        0 AS anteil_01,
        0 AS anteil_02,
        0 AS anteil_03,
        0 AS anteil_04,
        0 AS tagesmenge,
        0 AS gff_menge_stueck,
        0 AS fs1_menge_stueck,
        0 AS fs2_menge_stueck,
        0 AS erw_absatz_spaet,
        0 AS erw_absatz_abend,
        0 AS avg_menge_abschrift,
        0 AS wup_cluster_id,
        0 AS wug_cluser_id,
        '' AS back_drehklasse_id,
        '' AS aktion_id,
        0 AS menge_schnitt
    FROM dbp_data.art_2 AS a
    INNER JOIN dbp_data.art_wup_zu_per_2 AS awzp
        ON
            a.art_id = awzp.art_id
            AND a.mandant_id = awzp.mandant_id
            AND awzp.dat_bis = CAST('9999-12-31' AS DATE)
            AND awzp.nb_id = 0
    INNER JOIN (
        SELECT b.dat
        FROM (
            SELECT *
            FROM dbp_data.tag_2
            WHERE
                dat = CURRENT_DATE("Europe/Berlin")
        ) AS a
        INNER JOIN dbp_data.tag_2 AS b
            ON DATE_ADD(a.wo_dat_bis, INTERVAL '1' DAY) = b.wo_dat_von
        GROUP BY
            b.dat
    ) AS zeit_2
        ON TRUE
    WHERE
        (a.mandant_id, a.art_id) IN (
            SELECT (awzp0.mandant_id, awzp0.art_id)
            FROM dbp_data.art_wg_zu_per_2 AS awzp0
            INNER JOIN dbp_data.wg_filter_zu_2 AS wfz
                ON
                    awzp0.wg_id = wfz.wg_id
                    AND awzp0.mandant_id = wfz.mandant_id
                    AND wfz.wg_filter_id = 3
                    AND wfz.arthiertyp_id = 2
            WHERE
                awzp0.dat_bis = CAST('9999-12-31' AS DATE) AND awzp0.arthiertyp_id = 2
        )
        AND (awzp.mandant_id, awzp.wup_id) IN (
            SELECT (mandant_id, wup_id)
            FROM dbp_data.wup_2
            WHERE
                nb_id = 0
                AND DATE_SUB(dat_eroeffnung, INTERVAL '10' DAY) < CURRENT_DATE("Europe/Berlin")
                AND (mandant_id, wup_id) IN (
                    SELECT (mandant_id, wup_id)
                    FROM dbp_data.wup_backshop_per_2
                    WHERE
                        dat_bis = CAST('9999-12-31' AS DATE)
                )
            GROUP BY
                mandant_id,
            wup_id
        )
        AND a.dat_bis = CAST('9999-12-31' AS DATE)
        AND awzp.mandant_id = 3
        AND awzp.wup_id = 1031
);

UPDATE dbp_etl.vis_agg_tmp_2 SET listung_id = 2
FROM (
    SELECT
        a.mandant_id,
        a.wup_id,
        a.art_id,
        MIN(a.dat) AS min_dat,
        MIN(b.dat_von) AS min_dat_von
    FROM dbp_etl.vis_agg_tmp_2 AS a
    INNER JOIN dbp_data.art_wup_zu_per_2 AS b
        ON a.art_id = b.art_id AND a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id
    WHERE
        b.listung_id = 1
    GROUP BY
        a.art_id,
        a.mandant_id,
        a.wup_id
    HAVING
        min_dat_von >= DATE_SUB(min_dat, INTERVAL '21' DAY)
) AS t2
WHERE
    vis_agg_tmp.mandant_id = t2.mandant_id
    AND vis_agg_tmp.wup_id = t2.wup_id
    AND vis_agg_tmp.art_id = t2.art_id;

CREATE OR REPLACE TEMPORARY TABLE _upd_posten AS
SELECT
    b.art_id,
    b.mandant_id,
    b.wup_id,
    b.nb_id,
    b.dat,
    b.menge_prognose,
    b.menge_prognose_max,
    b.menge_prognose_aktion,
    b.min_sicherh_bestand,
    b.listung_id,
    b.aktion_fg,
    b.menge_check,
    b.anteil_01,
    b.anteil_02,
    b.anteil_03,
    b.anteil_04,
    b.tagesmenge,
    b.gff_menge_stueck,
    b.fs1_menge_stueck,
    b.fs2_menge_stueck,
    b.erw_absatz_spaet,
    b.erw_absatz_abend,
    b.avg_menge_abschrift,
    b.wup_cluster_id,
    b.wug_cluster_id,
    b.back_drehklasse_id,
    b.aktion_id,
    b.menge_schnitt,
    MAX(a.aktion_id) AS aktion_id_
FROM dbp_data.aktion_art_wup_zu_2 AS a
INNER JOIN dbp_etl.vis_agg_tmp_2 AS b
    ON
        a.art_id = b.art_id
        AND a.mandant_id = b.mandant_id
        AND a.wup_id = b.wup_id
        AND a.nb_id = b.nb_id
INNER JOIN dbp_data.aktion_2 AS c
    ON
        a.mandant_id = c.mandant_id
        AND a.aktion_id = c.aktion_id
        AND b.dat BETWEEN c.dat_von AND (
            DATE_ADD(c.dat_bis, INTERVAL '7' DAY)
        )
INNER JOIN dbp_data.art_2 AS d
    ON
        a.mandant_id = d.mandant_id
        AND a.art_id = d.art_id
        AND d.dat_bis = CAST('9999-12-31' AS DATE)
        AND d.posten_id IN ('PN', 'SP', 'PS', '1')
WHERE
    a.grund_sperrung IS NULL
    AND CASE
        WHEN c.mandant_id = 1
            THEN c.preisaktiviert_fg
        WHEN
            c.mandant_id > 1
            AND a.dat_preisaktiviert <> CAST('1900-01-01' AS DATE)
            AND NOT (c.mandant_id, c.aktion_id) IN (
                SELECT (mandant_id, aktion_id)
                FROM dbp_data.l_bonuskauf_2
            )
            THEN 1
        ELSE 0
    END = 1
GROUP BY
    b.art_id,
    b.mandant_id,
    b.wup_id,
    b.nb_id,
    b.dat,
    b.menge_prognose,
    b.menge_prognose_max,
    b.menge_prognose_aktion,
    b.min_sicherh_bestand,
    b.listung_id,
    b.aktion_fg,
    b.menge_check,
    b.anteil_01,
    b.anteil_02,
    b.anteil_03,
    b.anteil_04,
    b.tagesmenge,
    b.gff_menge_stueck,
    b.fs1_menge_stueck,
    b.fs2_menge_stueck,
    b.erw_absatz_spaet,
    b.erw_absatz_abend,
    b.avg_menge_abschrift,
    b.wup_cluster_id,
    b.wug_cluster_id,
    b.back_drehklasse_id,
    b.aktion_id,
    b.menge_schnitt;

UPDATE dbp_etl.vis_agg_tmp_2 SET listung_id = 4
FROM (
    SELECT
        mandant_id,
        art_id,
        wup_id
    FROM `_upd_posten`
    GROUP BY
        art_id,
        mandant_id,
        wup_id
) AS t0
WHERE
    vis_agg_tmp.mandant_id = t0.mandant_id
    AND vis_agg_tmp.wup_id = t0.wup_id
    AND vis_agg_tmp.art_id = t0.art_id;

CREATE OR REPLACE TEMPORARY TABLE _snapshot_2 AS
SELECT
    a.mandant_id,
    a.wup_id,
    a.art_id,
    a.dat
FROM dbp_msi_data.backshop_prognose_neu_2 AS a
INNER JOIN (
    SELECT b.dat
    FROM (
        SELECT *
        FROM dbp_data.tag_2
        WHERE
            dat = CURRENT_DATE("Europe/Berlin")
    ) AS a
    INNER JOIN dbp_data.tag_2 AS b
        ON DATE_SUB(a.wo_dat_von, INTERVAL '1' DAY) = b.wo_dat_bis
    GROUP BY
        b.dat
) AS x
    ON a.dat = x.dat
WHERE
    a.listung_id_backshop = 4
    AND NOT (a.mandant_id, a.art_id, a.wup_id) IN (
        SELECT (mandant_id, art_id, wup_id)
        FROM `_upd_posten`
    )
GROUP BY
    a.mandant_id,
    a.wup_id,
    a.art_id,
    a.dat;

UPDATE dbp_etl.vis_agg_tmp_2 SET listung_id = 5
FROM (
    SELECT
        a.mandant_id,
        a.wup_id,
        a.art_id,
        MIN(a.dat) AS min_dat,
        MAX(t4.max_dat_bis) AS max_dat_bis_
    FROM `_snapshot_2` AS a
    INNER JOIN (
        SELECT
            y.mandant_id,
            y.wup_id,
            y.art_id,
            y.dat_von,
            MAX(y.dat_bis) AS max_dat_bis
        FROM dbp_data.art_list_wup_zu_per_2 AS y
        INNER JOIN (
            SELECT
                mandant_id,
                wup_id,
                art_id,
                MIN(dat_von) AS min_dat_von
            FROM dbp_data.art_list_wup_zu_per_2
            WHERE
                list_quelle_id = 'c'
                AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND (
                    DATE_ADD(dat_bis, INTERVAL '28' DAY)
                )
            GROUP BY
                art_id,
                wup_id,
                mandant_id
        ) AS t1_2
            ON
                y.mandant_id = t1.mandant_id
                AND y.wup_id = t1.wup_id
                AND y.art_id = t1.art_id
                AND y.dat_von = t1.min_dat_von
        WHERE
            y.list_quelle_id = 'C'
        GROUP BY
            y.art_id,
            y.wup_id,
            y.dat_von,
            y.mandant_id
    ) AS t4
        ON a.art_id = t4.art_id AND a.mandant_id = t4.mandant_id AND a.wup_id = t4.wup_id
    GROUP BY
        a.mandant_id,
        a.wup_id,
        a.art_id
    HAVING
        max_dat_bis_ <= DATE_ADD(min_dat, INTERVAL '28' DAY)
) AS b
WHERE
    vis_agg_tmp.mandant_id = b.mandant_id
    AND vis_agg_tmp.wup_id = b.wup_id
    AND vis_agg_tmp.art_id = b.art_id;

UPDATE dbp_etl.vis_agg_tmp_2 SET listung_id = 3
FROM (
    SELECT
        a.mandant_id,
        a.wup_id,
        a.art_id,
        MIN(a.dat) AS min_dat,
        MAX(t4.max_dat_bis) AS max_dat_bis_
    FROM dbp_etl.vis_agg_tmp_2 AS a
    INNER JOIN (
        SELECT
            y.mandant_id,
            y.wup_id,
            y.art_id,
            y.dat_von,
            MAX(y.dat_bis) AS max_dat_bis
        FROM dbp_data.art_list_wup_zu_per_2 AS y
        INNER JOIN (
            SELECT
                mandant_id,
                wup_id,
                art_id,
                MIN(dat_von) AS min_dat_von
            FROM dbp_data.art_list_wup_zu_per_2
            WHERE
                list_quelle_id = 'C'
                AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND (
                    DATE_ADD(dat_bis, INTERVAL '28' DAY)
                )
            GROUP BY
                art_id,
                wup_id,
                mandant_id
        ) AS t1_2
            ON
                y.mandant_id = t1.mandant_id
                AND y.wup_id = t1.wup_id
                AND y.art_id = t1.art_id
                AND y.dat_von = t1.min_dat_von
        WHERE
            y.list_quelle_id = 'c'
        GROUP BY
            y.art_id,
            y.wup_id,
            y.dat_von,
            y.mandant_id
    ) AS t4
        ON a.art_id = t4.art_id AND a.mandant_id = t4.mandant_id AND a.wup_id = t4.wup_id
    GROUP BY
        a.art_id,
        a.mandant_id,
        a.wup_id
    HAVING
        max_dat_bis_ <= DATE_ADD(min_dat, INTERVAL '28' DAY)
) AS t7
WHERE
    vis_agg_tmp.mandant_id = t7.mandant_id
    AND vis_agg_tmp.wup_id = t7.wup_id
    AND vis_agg_tmp.art_id = t7.art_id
    AND NOT vis_agg_tmp.listung_id IN (2, 4, 5);

DELETE FROM dbp_etl.vis_agg_tmp_2
WHERE
    listung_id = 0;

CREATE OR REPLACE TEMPORARY TABLE _update AS
SELECT
    b.art_id,
    b.mandant_id,
    b.wup_id,
    b.nb_id,
    b.dat,
    b.menge_prognose,
    b.menge_prognose_max,
    b.menge_prognose_aktion,
    b.min_sicherh_bestand,
    b.listung_id,
    b.aktion_fg,
    b.menge_check,
    b.anteil_01,
    b.anteil_02,
    b.anteil_03,
    b.anteil_04,
    b.tagesmenge,
    b.gff_menge_stueck,
    b.fs1_menge_stueck,
    b.fs2_menge_stueck,
    b.erw_absatz_spaet,
    b.erw_absatz_abend,
    b.avg_menge_abschrift,
    b.wup_cluster_id,
    b.wug_cluster_id,
    b.back_drehklasse_id,
    b.aktion_id,
    b.menge_schnitt,
    MAX(a.aktion_id) AS aktion_id_
FROM dbp_data.aktion_art_wup_zu_2 AS a
INNER JOIN dbp_etl.vis_agg_tmp_2 AS b
    ON
        a.art_id = b.art_id
        AND a.mandant_id = b.mandant_id
        AND a.wup_id = b.wup_id
        AND a.nb_id = b.nb_id
INNER JOIN dbp_data.aktion_2 AS c
    ON
        a.mandant_id = c.mandant_id
        AND a.aktion_id = c.aktion_id
        AND b.dat BETWEEN c.dat_von AND c.dat_bis
WHERE
    a.grund_sperrung IS NULL
    AND CASE
        WHEN c.mandant_id = 1
            THEN c.preisaktiviert_fg
        WHEN
            c.mandant_id > 1
            AND a.dat_preisaktiviert <> CAST('1900-01-01' AS DATE)
            AND NOT (c.mandant_id, c.aktion_id) IN (
                SELECT (mandant_id, aktion_id)
                FROM dbp_data.l_bonuskauf_2
            )
            THEN 1
        ELSE 0
    END = 1
GROUP BY
    b.art_id,
    b.mandant_id,
    b.wup_id,
    b.nb_id,
    b.dat,
    b.menge_prognose,
    b.menge_prognose_max,
    b.menge_prognose_aktion,
    b.min_sicherh_bestand,
    b.listung_id,
    b.aktion_fg,
    b.menge_check,
    b.anteil_01,
    b.anteil_02,
    b.anteil_03,
    b.anteil_04,
    b.tagesmenge,
    b.gff_menge_stueck,
    b.fs1_menge_stueck,
    b.fs2_menge_stueck,
    b.erw_absatz_spaet,
    b.erw_absatz_abend,
    b.avg_menge_abschrift,
    b.wup_cluster_id,
    b.wug_cluster_id,
    b.back_drehklasse_id,
    b.aktion_id,
    b.menge_schnitt;

UPDATE dbp_etl.vis_agg_tmp_2 SET aktion_fg = 1, aktion_id = b.aktion_id_
FROM `_update` AS b
WHERE
    vis_agg_tmp.mandant_id = b.mandant_id
    AND vis_agg_tmp.wup_id = b.wup_id
    AND vis_agg_tmp.nb_id = b.nb_id
    AND vis_agg_tmp.art_id = b.art_id
    AND vis_agg_tmp.dat = b.dat;

CREATE OR REPLACE TEMPORARY TABLE _zwischentabelle (
    mandant_id INT64,
    wup_id INT64,
    kl_art_id INT64,
    dat DATE,
    letzter_abverkauf TIME,
    wtag_id INT64,
    back_intervall INT64,
    menge NUMERIC(29, 3),
    menge_abschrift INT64
);

CREATE OR REPLACE TEMPORARY TABLE _track_bake_articles AS
SELECT
    awzp.mandant_id,
    CASE
        WHEN awzp.mandant_id > 1
            THEN CAST(FLOOR(awzp.art_id / 10) AS INT64)
        ELSE CAST(FLOOR(awzp.art_id / 100) AS INT64)
    END AS kl_art_id
FROM dbp_data.art_wg_zu_per_2 AS awzp
INNER JOIN dbp_data.wg_filter_zu_2 AS wfz
    ON
        awzp.wg_id = wfz.wg_id
        AND awzp.mandant_id = wfz.mandant_id
        AND wfz.wg_filter_id = 3
        AND wfz.arthiertyp_id = 2
WHERE
    awzp.dat_bis = CAST('9999-12-31' AS DATE) AND awzp.arthiertyp_id = 2;

CREATE OR REPLACE TEMPORARY TABLE _track_bons AS
SELECT
    a.bon_id,
    a.bon_zeile,
    a.mandant_id,
    a.wup_id,
    a.bon_dat,
    a.kl_art_id,
    a.ean_kasse,
    a.wg_id,
    a.menge,
    a.einh_id,
    a.umsatz_brutto,
    a.mwst_id,
    a.erfassung_id,
    a.aktion_id,
    a.talon_id,
    a.start_bon_zeile,
    a.bon_nr_extern,
    a.kpos_erfassung_id,
    a.umsatz_brutto_norm,
    a.vk_brutto_obb,
    a.bon_vorgang_id,
    a.barcode_string,
    a.barcode_leergut,
    a.zeilenstorno_fg,
    a.td_update,
    a.td_insert
FROM dbp_ods.ods_bon_verkauf_2 AS a
INNER JOIN `_track_bake_articles` AS b
    ON a.mandant_id = b.mandant_id AND a.kl_art_id = b.kl_art_id
WHERE
    a.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '49' DAY) AND (
        DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '1' DAY)
    )
    AND (a.mandant_id, a.wup_id) IN (
        SELECT (mandant_id, wup_id)
        FROM dbp_data.wup_backshop_per_2
        WHERE
            dat_bis = CAST('9999-12-31' AS DATE)
    );

INSERT INTO `_zwischentabelle`
(
    SELECT
        t01.mandant_id,
        x.wup_id,
        CAST(CASE
            WHEN t01.mandant_id > 1
                THEN CAST(FLOOR(x.art_id / 10) AS INT64)
            ELSE CAST(FLOOR(x.art_id / 100) AS INT64)
        END AS INT64) AS kl_art_id,
        t01.bon_dat AS dat,
        PARSE_TIME('%T', CAST(EXTRACT(HOUR FROM t01.start_bon_zeile) AS STRING) || ':00:00') AS letzer_abverkauf,
        MOD(DATE_DIFF(t01.bon_dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 AS wtag_id,
        EXTRACT(HOUR FROM t01.start_bon_zeile) AS back_intervall,
        SUM(CAST(t01.menge * x.faktor_ref AS NUMERIC)) AS menge,
        SUM(0) AS menge_abschrift
    FROM `_track_bons` AS t01
    INNER JOIN dbp_data.art_wup_status_referenz_2 AS x
        ON
            t01.mandant_id = x.mandant_id
            AND t01.wup_id = x.wup_id_ref
            AND t01.kl_art_id = CASE
                WHEN t01.mandant_id > 1
                    THEN CAST(FLOOR(x.art_id_ref / 10) AS INT64)
                ELSE CAST(FLOOR(x.art_id_ref / 100) AS INT64)
            END
            AND t01.bon_dat <= x.dat_bis_ref
    GROUP BY
        t01.mandant_id,
        x.wup_id,
        kl_art_id,
        dat,
        letzer_abverkauf,
        wtag_id,
        back_intervall
);

INSERT INTO `_zwischentabelle`
(
    SELECT
        t01.mandant_id,
        t02.aktuell_wup_id AS wup_id,
        t01.kl_art_id,
        t01.bon_dat AS dat,
        PARSE_TIME('%T', CAST(EXTRACT(HOUR FROM t01.start_bon_zeile) AS STRING) || ':00:00') AS letzer_abverkauf,
        MOD(DATE_DIFF(t01.bon_dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 AS wtag_id,
        EXTRACT(HOUR FROM t01.start_bon_zeile) AS back_intervall,
        SUM(t01.menge) AS menge,
        SUM(0) AS menge_abschrift
    FROM `_track_bons` AS t01
    INNER JOIN dbp_data.wup_2 AS t02
        ON t01.wup_id = t02.wup_id AND t01.mandant_id = t02.mandant_id
    WHERE
        NOT (t01.mandant_id, t02.aktuell_wup_id, t01.kl_art_id, t01.bon_dat) IN (
            SELECT (mandant_id, wup_id, kl_art_id, dat)
            FROM `_zwischentabelle`
        )
    GROUP BY
        t01.mandant_id,
        wup_id,
        t01.kl_art_id,
        dat,
        letzer_abverkauf,
        wtag_id,
        back_intervall
);

UPDATE `_zwischentabelle` SET
    letzter_abverkauf = CASE
        WHEN
            ROUND(
                CAST(SUBSTR(CAST(`_zwischentabelle`.letzter_abverkauf AS STRING), 1, 2) AS NUMERIC),
                0
            ) <= 21
            THEN PARSE_TIME(
                '%T',
                CAST(TRIM(
                    SUBSTR(
                        CAST(ROUND(
                            CAST(SUBSTR(CAST(`_zwischentabelle`.letzter_abverkauf AS STRING), 1, 2) AS NUMERIC),
                            0
                        ) + 1 AS STRING),
                        1,
                        39
                    )
                ) || ':00:00' AS STRING)
            )
        ELSE PARSE_TIME('%T', '22:00:00')
    END
WHERE
    TRUE;

INSERT INTO dbp_etl.vis_fur_tmp_2 (
    mandant_id,
    art_id,
    wup_id,
    dat,
    menge_fur_mean,
    menge_fur_max,
    menge_fur_aktion
)
(
    SELECT
        t01.mandant_id,
        t01.art_id,
        t01.wup_id,
        t01.dat,
        CASE
            WHEN t01.menge_prognose = 0 AND t01.menge_prognose_max <> 0
                THEN t01.menge_prognose_max
            ELSE t01.menge_prognose
        END AS menge_fur_mean,
        CASE
            WHEN t01.menge_prognose_max = 0 AND t01.menge_prognose <> 0
                THEN t01.menge_prognose
            ELSE t01.menge_prognose_max
        END AS menge_fur_max,
        t01.menge_prognose_aktion AS menge_fur_aktion
    FROM dbp_data.fur_prognose_2 AS t01
    INNER JOIN (
        SELECT
            MIN(b.dat) AS min_dat,
            MAX(b.dat) AS max_dat
        FROM (
            SELECT *
            FROM dbp_data.tag_2
            WHERE
                dat = CURRENT_DATE("Europe/Berlin")
        ) AS a
        INNER JOIN dbp_data.tag_2 AS b
            ON DATE_ADD(a.wo_dat_bis, INTERVAL '1' DAY) = b.wo_dat_von
    ) AS t02
        ON TRUE
    WHERE
        (t01.mandant_id, t01.art_id) IN (
            SELECT (awzp.mandant_id, awzp.art_id)
            FROM dbp_data.art_wg_zu_per_2 AS awzp
            INNER JOIN dbp_data.wg_filter_zu_2 AS wfz
                ON
                    awzp.wg_id = wfz.wg_id
                    AND awzp.mandant_id = wfz.mandant_id
                    AND wfz.wg_filter_id = 3
                    AND wfz.arthiertyp_id = 2
            WHERE
                awzp.dat_bis = PARSE_DATE('%F', '9999-12-31') AND awzp.arthiertyp_id = 2
        )
        AND t01.dat BETWEEN t02.min_dat AND t02.max_dat
);

DELETE FROM dbp_etl.vis_fur_tmp_2
WHERE
    (mandant_id, art_id, wup_id, dat) IN (
        SELECT (x.mandant_id, x.art_id, x.wup_id, z.dat)
        FROM dbp_data.fur_prognose_2 AS x
        INNER JOIN (
            SELECT
                mandant_id,
                art_id,
                wup_id,
                MOD(DATE_DIFF(dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 AS wtag_id,
                MAX(dat) AS max_dat
            FROM dbp_data.fur_prognose_2
            WHERE
                (mandant_id, art_id) IN (
                    SELECT (mandant_id, art_id)
                    FROM dbp_etl.vis_agg_tmp_2
                    WHERE
                        listung_id = 3
                )
                AND dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '60' DAY) AND (
                    SELECT MAX(b.dat) AS max_dat
                    FROM (
                        SELECT *
                        FROM dbp_data.tag_2
                        WHERE
                            dat = CURRENT_DATE("Europe/Berlin")
                    ) AS t1_2
                    INNER JOIN dbp_data.tag_2 AS b
                        ON DATE_ADD(t1.wo_dat_bis, INTERVAL '1' DAY) = b.wo_dat_von
                )
                AND (
                    menge_prognose <> 0 OR menge_prognose_max <> 0
                )
            GROUP BY
                mandant_id,
                art_id,
                wup_id,
                wtag_id
        ) AS y
            ON
                x.mandant_id = y.mandant_id
                AND x.art_id = y.art_id
                AND x.wup_id = y.wup_id
                AND x.dat = y.max_dat
        INNER JOIN (
            SELECT
                b0.wtag_id,
                b0.dat
            FROM (
                SELECT *
                FROM dbp_data.tag_2
                WHERE
                    dat = CURRENT_DATE("Europe/Berlin")
            ) AS t6
            INNER JOIN dbp_data.tag_2 AS b0
                ON DATE_ADD(t6.wo_dat_bis, INTERVAL '1' DAY) = b0.wo_dat_von
        ) AS z
            ON y.wtag_id = z.wtag_id
    )
    AND menge_fur_mean = 0
    AND menge_fur_max = 0
    AND menge_fur_aktion = 0;

INSERT INTO dbp_etl.vis_fur_tmp_2 (
    mandant_id,
    art_id,
    wup_id,
    dat,
    menge_fur_mean,
    menge_fur_max,
    menge_fur_aktion
)
(
    SELECT
        t01.mandant_id,
        t01.art_id,
        t01.wup_id,
        t03.dat,
        CASE
            WHEN t01.menge_prognose = 0
                THEN t01.menge_prognose_max
            ELSE t01.menge_prognose
        END AS menge_fur_mean,
        CASE
            WHEN t01.menge_prognose_max = 0
                THEN t01.menge_prognose
            ELSE t01.menge_prognose_max
        END AS menge_fur_max,
        t01.menge_prognose_aktion AS menge_fur_aktion
    FROM dbp_data.fur_prognose_2 AS t01
    INNER JOIN (
        SELECT
            mandant_id,
            art_id,
            wup_id,
            MOD(DATE_DIFF(dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 AS wtag_id,
            MAX(dat) AS max_dat
        FROM dbp_data.fur_prognose_2
        WHERE
            (mandant_id, art_id) IN (
                SELECT (mandant_id, art_id)
                FROM dbp_etl.vis_agg_tmp_2
                WHERE
                    listung_id = 3
            )
            AND dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '60' DAY) AND (
                SELECT MAX(b.dat) AS max_dat
                FROM (
                    SELECT *
                    FROM dbp_data.tag_2
                    WHERE
                        dat = CURRENT_DATE("Europe/Berlin")
                ) AS a
                INNER JOIN dbp_data.tag_2 AS b
                    ON DATE_ADD(a.wo_dat_bis, INTERVAL '1' DAY) = b.wo_dat_von
            )
            AND (
                menge_prognose <> 0 OR menge_prognose_max <> 0
            )
        GROUP BY
            mandant_id,
            art_id,
            wup_id,
            wtag_id
    ) AS t02
        ON
            t01.mandant_id = t02.mandant_id
            AND t01.art_id = t02.art_id
            AND t01.wup_id = t02.wup_id
            AND t01.dat = t02.max_dat
    INNER JOIN (
        SELECT
            b0.wtag_id,
            b0.dat
        FROM (
            SELECT *
            FROM dbp_data.tag_2
            WHERE
                dat = CURRENT_DATE("Europe/Berlin")
        ) AS a
        INNER JOIN dbp_data.tag_2 AS b0
            ON DATE_ADD(a.wo_dat_bis, INTERVAL '1' DAY) = b0.wo_dat_von
    ) AS t03
        ON t02.wtag_id = t03.wtag_id
    WHERE
        NOT (t01.mandant_id, t01.wup_id, t01.art_id, t03.dat) IN (
            SELECT (mandant_id, wup_id, art_id, dat)
            FROM dbp_etl.vis_fur_tmp_2
        )
);

INSERT INTO dbp_etl.vis_ods_tmp_2 (
    mandant_id,
    art_id,
    wup_id,
    wtag_id,
    aktion_fg,
    menge_ods,
    anz_ods,
    menge_schnitt,
    back_drehklasse_id,
    menge_01,
    menge_02,
    menge_03,
    menge_04,
    menge_16,
    anz_16
)
(
    SELECT
        x.mandant_id,
        c.art_id,
        x.wup_id,
        x.wtag_id,
        0 AS aktion_fg,
        CAST(SUM(
            x.menge * COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END, 1)
        ) AS NUMERIC) AS menge_ods,
        COUNT(DISTINCT x.dat) AS anz_ods,
        SUM(
            x.menge * COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END, 1)
        ) / COUNT(DISTINCT x.dat) AS menge_schnitt,
        '' AS back_drehklasse_id,
        CAST(SUM(
            CASE
                WHEN x.back_intervall IN (4, 5, 6, 7, 8, 9)
                    THEN x.menge * COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END, 1)
                ELSE 0
            END
        ) AS NUMERIC) AS menge_01,
        CAST(SUM(
            CASE
                WHEN x.back_intervall IN (4, 5, 6, 7, 8, 9, 10, 11, 12, 13)
                    THEN x.menge * COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END, 1)
                ELSE 0
            END
        ) AS NUMERIC) AS menge_02,
        CAST(SUM(
            CASE
                WHEN x.back_intervall IN (11, 12, 13, 14, 15, 16, 17)
                    THEN x.menge * COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END, 1)
                ELSE 0
            END
        ) AS NUMERIC) AS menge_03,
        CAST(SUM(
            CASE
                WHEN x.back_intervall IN (0, 1, 2, 3, 16, 17, 18, 19, 20, 21, 22, 23, 24)
                    THEN x.menge * COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END, 1)
                ELSE 0
            END
        ) AS NUMERIC) AS menge_04,
        CAST(SUM(
            CASE
                WHEN x.back_intervall BETWEEN 4 AND 16
                    THEN x.menge * COALESCE(CASE WHEN y.inhalt_menge = 0 OR x.mandant_id = 1 THEN 1 ELSE y.inhalt_menge END, 1)
                ELSE 0
            END
        ) AS NUMERIC) AS menge_16,
        COUNT(DISTINCT CASE WHEN x.back_intervall BETWEEN 4 AND 16 THEN x.dat ELSE NULL END) AS anz_16
    FROM `_zwischentabelle` AS x
    INNER JOIN dbp_data.art_2 AS c
        ON
            x.mandant_id = c.mandant_id
            AND x.kl_art_id = c.kl_art_id
            AND c.dat_bis = PARSE_DATE('%F', '9999-12-31')
    LEFT JOIN (
        SELECT
            a.mandant_id,
            a.art_id,
            b.inhalt_menge
        FROM dbp_data.art_backshop_zu_2 AS a
        INNER JOIN dbp_data.art_backshop_2 AS b
            ON a.mandant_id = b.mandant_id AND a.bestell_art_id = b.bestell_art_id
    ) AS y
        ON c.mandant_id = y.mandant_id AND c.art_id = y.art_id
    GROUP BY
        x.mandant_id,
        x.wup_id,
        c.art_id,
        x.wtag_id
);

UPDATE dbp_etl.vis_ods_tmp_2 SET back_drehklasse_id = b.back_drehklasse_id
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        MOD(DATE_DIFF(dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 AS wtag_id,
        CASE
            WHEN menge_fur_aktion <> 0
                THEN menge_fur_aktion
            WHEN menge_fur_max <> 0
                THEN menge_fur_max
            ELSE menge_fur_mean
        END AS prognose_menge,
        CASE
            WHEN
                CASE
                    WHEN menge_fur_aktion <> 0
                        THEN menge_fur_aktion
                    WHEN menge_fur_max <> 0
                        THEN menge_fur_max
                    ELSE menge_fur_mean
                END >= 0
                AND CASE
                    WHEN menge_fur_aktion <> 0
                        THEN menge_fur_aktion
                    WHEN menge_fur_max <> 0
                        THEN menge_fur_max
                    ELSE menge_fur_mean
                END < 10
                THEN 'LD'
            WHEN
                CASE
                    WHEN menge_fur_aktion <> 0
                        THEN menge_fur_aktion
                    WHEN menge_fur_max <> 0
                        THEN menge_fur_max
                    ELSE menge_fur_mean
                END >= 10
                AND CASE
                    WHEN menge_fur_aktion <> 0
                        THEN menge_fur_aktion
                    WHEN menge_fur_max <> 0
                        THEN menge_fur_max
                    ELSE menge_fur_mean
                END < 25
                THEN 'MD'
            ELSE 'SD'
        END AS back_drehklasse_id
    FROM dbp_etl.vis_fur_tmp_2 AS x
    GROUP BY
        mandant_id,
        wup_id,
        art_id,
        wtag_id,
        prognose_menge,
        back_drehklasse_id
) AS b
WHERE
    vis_ods_tmp.mandant_id = b.mandant_id
    AND vis_ods_tmp.wup_id = b.wup_id
    AND vis_ods_tmp.art_id = b.art_id
    AND vis_ods_tmp.wtag_id = b.wtag_id;

UPDATE dbp_etl.vis_ods_tmp_2 SET back_drehklasse_id = 'LD'
WHERE
    back_drehklasse_id = '';

CREATE OR REPLACE TEMPORARY TABLE _markt_oeffnungen (
    mandant_id INT64,
    wup_id INT64,
    wtag_id INT64,
    offen_von TIME,
    offen_bis TIME
);

INSERT INTO `_markt_oeffnungen`
(
    SELECT
        mandant_id,
        wup_id,
        wup_oeffnungs_typ_id AS wtag_id,
        CAST(CASE
            WHEN (
                safe.PARSE_TIME('%H%M%S', LPAD(CAST(CAST(zeit_von AS NUMERIC) AS STRING), 6, '0'))
            ) = CAST('000000' AS TIME)
                THEN '00:00:00'
            ELSE CAST(safe.PARSE_TIME('%H%M%S', LPAD(CAST(CAST(zeit_von AS NUMERIC) AS STRING), 6, '0')) AS STRING)
        END AS TIME) AS offen_von,
        CAST(CASE
            WHEN (
                safe.PARSE_TIME('%H%M%S', LPAD(CAST(CAST(zeit_bis AS NUMERIC) AS STRING), 6, '0'))
            ) = CAST('000000' AS TIME)
                THEN '00:00:00'
            ELSE CAST(safe.PARSE_TIME('%H%M%S', LPAD(CAST(CAST(zeit_bis AS NUMERIC) AS STRING), 6, '0')) AS STRING)
        END AS TIME) AS offen_bis
    FROM `_vaus` AS a
    GROUP BY
        mandant_id,
        wup_id,
        wtag_id,
        offen_von,
        offen_bis
);

CREATE OR REPLACE TEMPORARY TABLE _x_abs AS
SELECT
    mandant_id,
    wup_id,
    art_id,
    CASE WHEN wtag_id IN (7, 1) THEN 6 ELSE wtag_id - 1 END AS wtag_id_,
    CASE
        WHEN wtag_id IN (1)
            THEN DATE_SUB(dat, INTERVAL '2' DAY)
        ELSE DATE_SUB(dat, INTERVAL '1' DAY)
    END AS dat_,
    SUM(menge_abschrift) AS menge_abschrift
FROM (
    SELECT
        a.mandant_id,
        a.wup_id,
        a.art_id,
        MOD(DATE_DIFF(a.dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 AS wtag_id,
        a.dat,
        COUNT(DISTINCT a.dat) AS anzahl,
        SUM(a.menge_abschrift) AS menge_abschrift
    FROM dbp_data.marktabschriften_2 AS a
    INNER JOIN (
        SELECT
            a0.mandant_id,
            a0.wup_id,
            b.art_id
        FROM `_zwischentabelle` AS a0
        INNER JOIN dbp_data.art_2 AS b
            ON
                a0.kl_art_id = b.kl_art_id
                AND a0.mandant_id = b.mandant_id
                AND b.dat_bis = PARSE_DATE('%F', '9999-12-31')
        WHERE
            a0.mandant_id = 1
        GROUP BY
            a0.mandant_id,
            a0.wup_id,
            b.art_id
    ) AS b
        ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.art_id = b.art_id
    WHERE
        a.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '49' DAY) AND (
            DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '1' DAY)
        )
        AND a.abschriftart_id IN (
            SELECT b0.abschriftart_id
            FROM dbp_data.l_abschriftart_int_2 AS a1
            INNER JOIN dbp_data.abschriftart_int_zu_2 AS b0
                ON a1.abschriftart_int_id = b0.abschriftart_int_id
            WHERE
                a1.abschriftart_thema_int_id = 1 AND b0.mandant_id = 1
            GROUP BY
                b0.abschriftart_id
        )
    GROUP BY
        a.mandant_id,
        a.wup_id,
        a.art_id,
        wtag_id,
        a.dat
) AS a1
GROUP BY
    mandant_id,
    wup_id,
    art_id,
    wtag_id_,
    dat_;

CREATE OR REPLACE TEMPORARY TABLE _x_abs_kmo AS
SELECT
    mandant_id,
    wup_id,
    art_id,
    CASE WHEN mandant_id = 8 THEN wtag_id - 1 ELSE wtag_id END AS wtag_id_,
    CASE WHEN mandant_id = 8 THEN DATE_SUB(dat, INTERVAL '1' DAY) ELSE dat END AS dat_,
    SUM(menge_abschrift) AS menge_abschrift
FROM (
    SELECT
        a.mandant_id,
        a.wup_id,
        a.art_id,
        MOD(DATE_DIFF(a.dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 AS wtag_id,
        a.dat,
        COUNT(DISTINCT a.dat) AS anzahl,
        SUM(a.menge_abschrift) AS menge_abschrift
    FROM dbp_data.marktabschriften_2 AS a
    INNER JOIN (
        SELECT
            a0.mandant_id,
            a0.wup_id,
            b.art_id
        FROM `_zwischentabelle` AS a0
        INNER JOIN dbp_data.art_2 AS b
            ON
                a0.kl_art_id = b.kl_art_id
                AND a0.mandant_id = b.mandant_id
                AND b.dat_bis = PARSE_DATE('%F', '9999-12-31')
        WHERE
            a0.mandant_id > 1
        GROUP BY
            a0.mandant_id,
            a0.wup_id,
            b.art_id
    ) AS b
        ON a.mandant_id = b.mandant_id AND a.wup_id = b.wup_id AND a.art_id = b.art_id
    WHERE
        a.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '49' DAY) AND (
            DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '1' DAY)
        )
        AND a.abschriftart_id IN (
            SELECT b0.abschriftart_id
            FROM dbp_data.l_abschriftart_int_2 AS a1
            INNER JOIN dbp_data.abschriftart_int_zu_2 AS b0
                ON a1.abschriftart_int_id = b0.abschriftart_int_id
            WHERE
                a1.abschriftart_thema_int_id = 1 AND b0.mandant_id > 1
            GROUP BY
                b0.abschriftart_id
        )
    GROUP BY
        a.mandant_id,
        a.wup_id,
        a.art_id,
        wtag_id,
        a.dat
) AS a1
GROUP BY
    mandant_id,
    wup_id,
    art_id,
    wtag_id_,
    dat_;

UPDATE `_zwischentabelle` SET menge_abschrift = CAST(b.menge_abschrift AS INT64)
FROM `_x_abs` AS b
WHERE
    `_zwischentabelle`.mandant_id = b.mandant_id
    AND `_zwischentabelle`.wup_id = b.wup_id
    AND `_zwischentabelle`.kl_art_id = CASE
        WHEN b.mandant_id = 1
            THEN CAST(FLOOR(b.art_id / 100) AS INT64)
        ELSE CAST(FLOOR(b.art_id / 10) AS INT64)
    END
    AND `_zwischentabelle`.dat = b.dat_;

UPDATE `_zwischentabelle` SET menge_abschrift = CAST(b.menge_abschrift AS INT64)
FROM `_x_abs_kmo` AS b
WHERE
    `_zwischentabelle`.mandant_id = b.mandant_id
    AND `_zwischentabelle`.wup_id = b.wup_id
    AND `_zwischentabelle`.kl_art_id = CASE
        WHEN b.mandant_id = 1
            THEN CAST(FLOOR(b.art_id / 100) AS INT64)
        ELSE CAST(FLOOR(b.art_id / 10) AS INT64)
    END
    AND `_zwischentabelle`.dat = b.dat_;

UPDATE `_zwischentabelle` SET
    letzter_abverkauf = CASE
        WHEN `_zwischentabelle`.menge_abschrift <> 0
            THEN TIME(CAST('22:00:00' AS TIME))
        ELSE `_zwischentabelle`.letzter_abverkauf
    END
WHERE
    TRUE;

CREATE OR REPLACE TEMPORARY TABLE _max_abv (
    mandant_id INT64,
    wup_id INT64,
    art_id INT64,
    dat DATE,
    wtag_id INT64,
    aktion_fg INT64,
    back_drehklasse_id STRING(2),
    wug_cluster_id INT64,
    wup_cluster_id INT64,
    letzter_abverkauf_avg TIME,
    offen_von TIME,
    offen_bis TIME,
    menge_schnitt NUMERIC(29, 3)
);

INSERT INTO `_max_abv` (
    mandant_id,
    wup_id,
    art_id,
    dat,
    wtag_id,
    aktion_fg,
    back_drehklasse_id,
    wug_cluster_id,
    wup_cluster_id,
    letzter_abverkauf_avg,
    offen_von,
    offen_bis,
    menge_schnitt
)
(
    SELECT
        a.mandant_id,
        a.wup_id,
        c.art_id,
        c.dat,
        a.wtag_id,
        c.aktion_fg,
        c.back_drehklasse_id,
        c.wug_cluster_id,
        c.wup_cluster_id,
        a.letzter_abverkauf,
        d0.offen_von,
        d0.offen_bis,
        c.menge_schnitt
    FROM (
        SELECT
            mandant_id,
            wup_id,
            kl_art_id,
            wtag_id,
            TIME(
                CAST(TRIM(
                    LPAD(CAST(ROUND(CAST(AVG(`a11866`) AS BIGNUMERIC), 0) AS STRING), 2, '0') || ':' || LPAD(
                        CAST(ROUND(
                            CAST(ABS((
                                AVG(`a11866`) - ROUND(CAST(AVG(`a11866`) AS BIGNUMERIC), 0)
                            ) * 60) AS BIGNUMERIC),
                            0
                        ) AS STRING),
                        2,
                        '0'
                    ) || ':' || LPAD(
                        CAST(ABS(
                            3600 * ROUND(
                                CAST(AVG(`a11866`) - ROUND(CAST(AVG(`a11866`) AS BIGNUMERIC), 0) - (
                                    AVG(`a11866`) - ROUND(CAST(AVG(`a11866`) AS BIGNUMERIC), 0)
                                ) * 60 / 60 AS BIGNUMERIC),
                                0
                            )
                        ) AS STRING),
                        2,
                        '0'
                    )
                ) AS TIME)
            ) AS letzter_abverkauf
        FROM (
            SELECT
                mandant_id,
                wup_id,
                kl_art_id,
                wtag_id,
                CAST(SUBSTR(
                    CASE
                        WHEN MAX(letzter_abverkauf) < '14:00:00'
                            THEN '14:00:00'
                        ELSE CAST(MAX(letzter_abverkauf) AS STRING)
                    END,
                    1,
                    2
                ) AS FLOAT64) AS `a11866`
            FROM `_zwischentabelle`
            GROUP BY
                mandant_id,
                wup_id,
                kl_art_id,
                dat,
                wtag_id
        ) AS t0
        GROUP BY
            mandant_id,
            wup_id,
            kl_art_id,
            wtag_id
    ) AS a
    INNER JOIN (
        SELECT
            x.mandant_id,
            x.wup_id,
            x.art_id,
            d.dat,
            x.wtag_id,
            d.aktion_fg,
            x.back_drehklasse_id,
            COALESCE(b.wug_cluster_id, b1.wug_cluster_id, 5) AS wug_cluster_id,
            COALESCE(e.wup_cluster_id, f.wup_cluster_id, 1) AS wup_cluster_id,
            x.menge_schnitt
        FROM dbp_etl.vis_ods_tmp_2 AS x
        INNER JOIN dbp_etl.vis_agg_tmp_2 AS d
            ON
                x.mandant_id = d.mandant_id
                AND x.art_id = d.art_id
                AND x.wup_id = d.wup_id
                AND MOD(DATE_DIFF(d.dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 = x.wtag_id
        INNER JOIN dbp_data.art_wg_zu_per_2 AS a
            ON
                x.mandant_id = a.mandant_id
                AND x.art_id = a.art_id
                AND a.arthiertyp_id = 2
                AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
        LEFT JOIN dbp_data.back_wug_cluster_zu_2 AS b
            ON a.mandant_id = b.mandant_id AND a.wug_id = b.wug_id AND a.wg_id = b.wg_id
        LEFT JOIN (
            SELECT
                x0.mandant_id,
                MAX(x0.wug_cluster_id) AS wug_cluster_id
            FROM dbp_data.back_wug_cluster_zu_2 AS x0
            INNER JOIN (
                SELECT
                    mandant_id,
                    wg_id,
                    wug_id
                FROM dbp_data.back_wug_cluster_zu_2
                WHERE
                    (mandant_id, wug_cluster_id) IN (
                        SELECT (mandant_id, wug_cluster_id)
                        FROM dbp_data.back_vorgabe_2
                    )
                GROUP BY
                    wg_id,
                    mandant_id,
                    wug_id
            ) AS t6
                ON x0.mandant_id = t6.mandant_id AND x0.wg_id = t6.wg_id AND x0.wug_id = t6.wug_id
            GROUP BY
                x0.mandant_id
        ) AS b1
            ON a.mandant_id = b1.mandant_id
        LEFT JOIN dbp_data.back_vorgabe_2 AS c
            ON
                a.mandant_id = c.mandant_id
                AND b.wug_cluster_id = c.wug_cluster_id
                AND x.back_drehklasse_id = c.back_drehklasse_id
                AND d.aktion_fg = c.aktion_fg
        LEFT JOIN (
            SELECT
                x1.mandant_id,
                x1.wup_id,
                x1.nb_id,
                MAX(x1.wup_cluster_id) AS wup_cluster_id
            FROM dbp_data.back_wup_cluster_zu_2 AS x1
            INNER JOIN (
                SELECT
                    mandant_id,
                    wup_id,
                    nb_id,
                    MIN(prio) AS prio
                FROM dbp_data.back_wup_cluster_zu_2
                WHERE
                    (mandant_id, wup_cluster_id) IN (
                        SELECT (mandant_id, wup_cluster_id)
                        FROM dbp_data.back_vorgabe_2
                    )
                GROUP BY
                    mandant_id,
                    wup_id,
                    nb_id
            ) AS y
                ON
                    x1.mandant_id = y.mandant_id
                    AND x1.wup_id = y.wup_id
                    AND x1.nb_id = y.nb_id
                    AND x1.prio = y.prio
            GROUP BY
                x1.mandant_id,
                x1.wup_id,
                x1.nb_id
        ) AS e
            ON x.mandant_id = e.mandant_id AND x.wup_id = e.wup_id
        LEFT JOIN (
            SELECT
                x2.mandant_id,
                MAX(x2.wup_cluster_id) AS wup_cluster_id
            FROM dbp_data.back_wup_cluster_zu_2 AS x2
            INNER JOIN (
                SELECT
                    mandant_id,
                    wup_id,
                    nb_id,
                    MIN(prio) AS prio
                FROM dbp_data.back_wup_cluster_zu_2
                WHERE
                    (mandant_id, wup_cluster_id) IN (
                        SELECT (mandant_id, wup_cluster_id)
                        FROM dbp_data.back_vorgabe_2
                    )
                GROUP BY
                    mandant_id,
                    wup_id,
                    nb_id
            ) AS y
                ON
                    x2.mandant_id = y.mandant_id
                    AND x2.wup_id = y.wup_id
                    AND x2.nb_id = y.nb_id
                    AND x2.prio = y.prio
            GROUP BY
                x2.mandant_id
        ) AS f
            ON x.mandant_id = f.mandant_id
    ) AS c
        ON
            a.mandant_id = c.mandant_id
            AND a.wup_id = c.wup_id
            AND a.kl_art_id = CASE
                WHEN c.mandant_id > 1
                    THEN CAST(FLOOR(c.art_id / 10) AS INT64)
                ELSE CAST(FLOOR(c.art_id / 100) AS INT64)
            END
            AND a.wtag_id = c.wtag_id
    INNER JOIN `_markt_oeffnungen` AS d0
        ON a.mandant_id = d0.mandant_id AND a.wup_id = d0.wup_id AND a.wtag_id = d0.wtag_id
    GROUP BY
        a.mandant_id,
        a.wup_id,
        a.wtag_id,
        a.letzter_abverkauf,
        c.art_id,
        c.dat,
        c.aktion_fg,
        c.back_drehklasse_id,
        c.wug_cluster_id,
        c.wup_cluster_id,
        c.menge_schnitt,
        d0.offen_von,
        d0.offen_bis
);

CREATE OR REPLACE TEMPORARY TABLE _max_abv2 (
    mandant_id INT64,
    wup_id INT64,
    art_id INT64,
    dat DATE,
    wtag_id INT64,
    aktion_fg INT64,
    back_drehklasse_id STRING(2),
    wug_cluster_id INT64,
    wup_cluster_id INT64,
    letzter_abverkauf_avg TIME,
    menge_schnitt NUMERIC(29, 3),
    menge_pro_min NUMERIC(29, 3),
    aufschlag_uhrzeit_tmp INT64,
    aufschlag_uhrzeit_la_prozent NUMERIC(29, 4),
    aufschlag_zeit NUMERIC(29, 2),
    ant_mag NUMERIC(29, 2),
    faktor_ist NUMERIC(29, 2),
    min_gesamt_fs NUMERIC(29, 2),
    ant_min_fs NUMERIC(29, 2),
    prognoseart STRING(10) COLLATE 'und:ci'
);

INSERT INTO `_max_abv2` (
    mandant_id,
    wup_id,
    art_id,
    dat,
    wtag_id,
    aktion_fg,
    back_drehklasse_id,
    wug_cluster_id,
    wup_cluster_id,
    letzter_abverkauf_avg,
    menge_schnitt,
    menge_pro_min,
    aufschlag_uhrzeit_tmp,
    aufschlag_uhrzeit_la_prozent,
    aufschlag_zeit,
    ant_mag,
    faktor_ist,
    min_gesamt_fs,
    ant_min_fs,
    prognoseart
)
(
    SELECT
        a.mandant_id,
        a.wup_id,
        a.art_id,
        a.dat,
        a.wtag_id,
        a.aktion_fg,
        a.back_drehklasse_id,
        a.wug_cluster_id,
        a.wup_cluster_id,
        a.letzter_abverkauf_avg,
        a.menge_schnitt,
        IFNULL(
            a.menge_schnitt / IF(
                ROUND(
                    CAST(CASE
                        WHEN ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 4, 2) AS BIGNUMERIC), 0) <> 0
                            THEN (
                                CAST(SUBSTR(
                                    SUBSTR(
                                        CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                        1,
                                        16
                                    ),
                                    1,
                                    INSTR(
                                        CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                        '.',
                                        1
                                    ) - 1
                                ) AS FLOAT64) - CAST(SUBSTR(
                                    SUBSTR(
                                        CAST((
                                            CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                        ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                        1,
                                        16
                                    ),
                                    1,
                                    (
                                        INSTR(
                                            CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                            '.',
                                            1
                                        ) - 1
                                    )
                                ) AS FLOAT64)
                            ) / 3600 + 0.5
                        ELSE (
                            CAST(SUBSTR(
                                SUBSTR(
                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                    1,
                                    16
                                ),
                                1,
                                INSTR(
                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                    '.',
                                    1
                                ) - 1
                            ) AS FLOAT64) - CAST(SUBSTR(
                                SUBSTR(
                                    CAST((
                                        CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                    ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                    1,
                                    16
                                ),
                                1,
                                (
                                    INSTR(
                                        CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                        '.',
                                        1
                                    ) - 1
                                )
                            ) AS FLOAT64)
                        ) / 3600
                    END AS NUMERIC),
                    8
                ) = 0,
                NULL,
                ROUND(
                    CAST(CASE
                        WHEN ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 4, 2) AS BIGNUMERIC), 0) <> 0
                            THEN (
                                CAST(SUBSTR(
                                    SUBSTR(
                                        CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                        1,
                                        16
                                    ),
                                    1,
                                    INSTR(
                                        CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                        '.',
                                        1
                                    ) - 1
                                ) AS FLOAT64) - CAST(SUBSTR(
                                    SUBSTR(
                                        CAST((
                                            CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                        ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                        1,
                                        16
                                    ),
                                    1,
                                    (
                                        INSTR(
                                            CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                            '.',
                                            1
                                        ) - 1
                                    )
                                ) AS FLOAT64)
                            ) / 3600 + 0.5
                        ELSE (
                            CAST(SUBSTR(
                                SUBSTR(
                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                    1,
                                    16
                                ),
                                1,
                                INSTR(
                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                    '.',
                                    1
                                ) - 1
                            ) AS FLOAT64) - CAST(SUBSTR(
                                SUBSTR(
                                    CAST((
                                        CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                    ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                    1,
                                    16
                                ),
                                1,
                                (
                                    INSTR(
                                        CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                        '.',
                                        1
                                    ) - 1
                                )
                            ) AS FLOAT64)
                        ) / 3600
                    END AS NUMERIC),
                    8
                )
            ),
            0
        ) / 60 AS menge_pro_min,
        CAST(ROUND(
            (
                (
                    ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 1, 2) AS BIGNUMERIC), 0) - 1 - ROUND(CAST(SUBSTR(CAST(a.letzter_abverkauf_avg AS STRING), 1, 2) AS BIGNUMERIC), 0)
                ) * 60 - ROUND(CAST(SUBSTR(CAST(a.letzter_abverkauf_avg AS STRING), 4, 2) AS BIGNUMERIC), 0)
            ) * (
                IFNULL(
                    a.menge_schnitt / IF(
                        ROUND(
                            CAST(CASE
                                WHEN ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 4, 2) AS BIGNUMERIC), 0) <> 0
                                    THEN (
                                        CAST(SUBSTR(
                                            SUBSTR(
                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                1,
                                                16
                                            ),
                                            1,
                                            INSTR(
                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                '.',
                                                1
                                            ) - 1
                                        ) AS FLOAT64) - CAST(SUBSTR(
                                            SUBSTR(
                                                CAST((
                                                    CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                                ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                1,
                                                16
                                            ),
                                            1,
                                            (
                                                INSTR(
                                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                    '.',
                                                    1
                                                ) - 1
                                            )
                                        ) AS FLOAT64)
                                    ) / 3600 + 0.5
                                ELSE (
                                    CAST(SUBSTR(
                                        SUBSTR(
                                            CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                            1,
                                            16
                                        ),
                                        1,
                                        INSTR(
                                            CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                            '.',
                                            1
                                        ) - 1
                                    ) AS FLOAT64) - CAST(SUBSTR(
                                        SUBSTR(
                                            CAST((
                                                CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                            ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                            1,
                                            16
                                        ),
                                        1,
                                        (
                                            INSTR(
                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                '.',
                                                1
                                            ) - 1
                                        )
                                    ) AS FLOAT64)
                                ) / 3600
                            END AS NUMERIC),
                            8
                        ) = 0,
                        NULL,
                        ROUND(
                            CAST(CASE
                                WHEN ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 4, 2) AS BIGNUMERIC), 0) <> 0
                                    THEN (
                                        CAST(SUBSTR(
                                            SUBSTR(
                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                1,
                                                16
                                            ),
                                            1,
                                            INSTR(
                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                '.',
                                                1
                                            ) - 1
                                        ) AS FLOAT64) - CAST(SUBSTR(
                                            SUBSTR(
                                                CAST((
                                                    CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                                ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                1,
                                                16
                                            ),
                                            1,
                                            (
                                                INSTR(
                                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                    '.',
                                                    1
                                                ) - 1
                                            )
                                        ) AS FLOAT64)
                                    ) / 3600 + 0.5
                                ELSE (
                                    CAST(SUBSTR(
                                        SUBSTR(
                                            CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                            1,
                                            16
                                        ),
                                        1,
                                        INSTR(
                                            CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                            '.',
                                            1
                                        ) - 1
                                    ) AS FLOAT64) - CAST(SUBSTR(
                                        SUBSTR(
                                            CAST((
                                                CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                            ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                            1,
                                            16
                                        ),
                                        1,
                                        (
                                            INSTR(
                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                '.',
                                                1
                                            ) - 1
                                        )
                                    ) AS FLOAT64)
                                ) / 3600
                            END AS NUMERIC),
                            8
                        )
                    ),
                    0
                ) / 60
            ),
            0
        ) AS INT64) AS aufschlag_uhrzeit_tmp,
        CAST(CASE
            WHEN
                CASE
                    WHEN
                        a.letzter_abverkauf_avg > CAST(TRIM(
                            FORMAT_TIME(
                                '%T',
                                TIME(
                                    CAST(TIMESTAMP_SECONDS(
                                        CAST(CAST(SUBSTR(
                                            CAST(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR('17:00:00', 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(CAST(a.offen_bis AS STRING), 7, 2) AS FLOAT64) AS STRING),
                                            1,
                                            INSTR(
                                                CAST(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(CAST(a.offen_bis AS STRING), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(CAST(a.offen_bis AS STRING), 7, 2) AS FLOAT64) AS STRING),
                                                '.',
                                                1
                                            ) - 1
                                        ) AS FLOAT64) - 3600 AS INT64)
                                    ) AS DATETIME)
                                )
                            )
                        ) AS TIME)
                        THEN 0
                    ELSE ROUND(
                        IFNULL(
                            CAST(ROUND(
                                (
                                    (
                                        ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 1, 2) AS BIGNUMERIC), 0) - 1 - ROUND(CAST(SUBSTR(CAST(a.letzter_abverkauf_avg AS STRING), 1, 2) AS BIGNUMERIC), 0)
                                    ) * 60 - ROUND(CAST(SUBSTR(CAST(a.letzter_abverkauf_avg AS STRING), 4, 2) AS BIGNUMERIC), 0)
                                ) * (
                                    IFNULL(
                                        a.menge_schnitt / IF(
                                            ROUND(
                                                CAST(CASE
                                                    WHEN ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 4, 2) AS BIGNUMERIC), 0) <> 0
                                                        THEN (
                                                            CAST(SUBSTR(
                                                                SUBSTR(
                                                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                    1,
                                                                    16
                                                                ),
                                                                1,
                                                                INSTR(
                                                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                    '.',
                                                                    1
                                                                ) - 1
                                                            ) AS FLOAT64) - CAST(SUBSTR(
                                                                SUBSTR(
                                                                    CAST((
                                                                        CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                                                    ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                    1,
                                                                    16
                                                                ),
                                                                1,
                                                                (
                                                                    INSTR(
                                                                        CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                        '.',
                                                                        1
                                                                    ) - 1
                                                                )
                                                            ) AS FLOAT64)
                                                        ) / 3600 + 0.5
                                                    ELSE (
                                                        CAST(SUBSTR(
                                                            SUBSTR(
                                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                1,
                                                                16
                                                            ),
                                                            1,
                                                            INSTR(
                                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                '.',
                                                                1
                                                            ) - 1
                                                        ) AS FLOAT64) - CAST(SUBSTR(
                                                            SUBSTR(
                                                                CAST((
                                                                    CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                                                ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                1,
                                                                16
                                                            ),
                                                            1,
                                                            (
                                                                INSTR(
                                                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                    '.',
                                                                    1
                                                                ) - 1
                                                            )
                                                        ) AS FLOAT64)
                                                    ) / 3600
                                                END AS NUMERIC),
                                                8
                                            ) = 0,
                                            NULL,
                                            ROUND(
                                                CAST(CASE
                                                    WHEN ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 4, 2) AS BIGNUMERIC), 0) <> 0
                                                        THEN (
                                                            CAST(SUBSTR(
                                                                SUBSTR(
                                                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                    1,
                                                                    16
                                                                ),
                                                                1,
                                                                INSTR(
                                                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                    '.',
                                                                    1
                                                                ) - 1
                                                            ) AS FLOAT64) - CAST(SUBSTR(
                                                                SUBSTR(
                                                                    CAST((
                                                                        CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                                                    ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                    1,
                                                                    16
                                                                ),
                                                                1,
                                                                (
                                                                    INSTR(
                                                                        CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                        '.',
                                                                        1
                                                                    ) - 1
                                                                )
                                                            ) AS FLOAT64)
                                                        ) / 3600 + 0.5
                                                    ELSE (
                                                        CAST(SUBSTR(
                                                            SUBSTR(
                                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                1,
                                                                16
                                                            ),
                                                            1,
                                                            INSTR(
                                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                '.',
                                                                1
                                                            ) - 1
                                                        ) AS FLOAT64) - CAST(SUBSTR(
                                                            SUBSTR(
                                                                CAST((
                                                                    CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                                                ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                1,
                                                                16
                                                            ),
                                                            1,
                                                            (
                                                                INSTR(
                                                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                    '.',
                                                                    1
                                                                ) - 1
                                                            )
                                                        ) AS FLOAT64)
                                                    ) / 3600
                                                END AS NUMERIC),
                                                8
                                            )
                                        ),
                                        0
                                    ) / 60
                                ),
                                0
                            ) AS INT64) / IF(a.menge_schnitt = 0, NULL, a.menge_schnitt),
                            0
                        ),
                        2
                    )
                END > 0.6
                THEN 0.6
            ELSE CASE
                WHEN
                    a.letzter_abverkauf_avg > CAST(TRIM(
                        FORMAT_TIME(
                            '%T',
                            TIME(
                                CAST(TIMESTAMP_SECONDS(
                                    CAST(CAST(SUBSTR(
                                        CAST(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR('17:00:00', 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(CAST(a.offen_bis AS STRING), 7, 2) AS FLOAT64) AS STRING),
                                        1,
                                        INSTR(
                                            CAST(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(CAST(a.offen_bis AS STRING), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(CAST(a.offen_bis AS STRING), 7, 2) AS FLOAT64) AS STRING),
                                            '.',
                                            1
                                        ) - 1
                                    ) AS FLOAT64) - 3600 AS INT64)
                                ) AS DATETIME)
                            )
                        )
                    ) AS TIME)
                    THEN 0
                ELSE ROUND(
                    IFNULL(
                        CAST(ROUND(
                            (
                                (
                                    ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 1, 2) AS BIGNUMERIC), 0) - 1 - ROUND(CAST(SUBSTR(CAST(a.letzter_abverkauf_avg AS STRING), 1, 2) AS BIGNUMERIC), 0)
                                ) * 60 - ROUND(CAST(SUBSTR(CAST(a.letzter_abverkauf_avg AS STRING), 4, 2) AS BIGNUMERIC), 0)
                            ) * (
                                IFNULL(
                                    a.menge_schnitt / IF(
                                        ROUND(
                                            CAST(CASE
                                                WHEN ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 4, 2) AS BIGNUMERIC), 0) <> 0
                                                    THEN (
                                                        CAST(SUBSTR(
                                                            SUBSTR(
                                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                1,
                                                                16
                                                            ),
                                                            1,
                                                            INSTR(
                                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                '.',
                                                                1
                                                            ) - 1
                                                        ) AS FLOAT64) - CAST(SUBSTR(
                                                            SUBSTR(
                                                                CAST((
                                                                    CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                                                ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                1,
                                                                16
                                                            ),
                                                            1,
                                                            (
                                                                INSTR(
                                                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                    '.',
                                                                    1
                                                                ) - 1
                                                            )
                                                        ) AS FLOAT64)
                                                    ) / 3600 + 0.5
                                                ELSE (
                                                    CAST(SUBSTR(
                                                        SUBSTR(
                                                            CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                            1,
                                                            16
                                                        ),
                                                        1,
                                                        INSTR(
                                                            CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                            '.',
                                                            1
                                                        ) - 1
                                                    ) AS FLOAT64) - CAST(SUBSTR(
                                                        SUBSTR(
                                                            CAST((
                                                                CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                                            ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                            1,
                                                            16
                                                        ),
                                                        1,
                                                        (
                                                            INSTR(
                                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                '.',
                                                                1
                                                            ) - 1
                                                        )
                                                    ) AS FLOAT64)
                                                ) / 3600
                                            END AS NUMERIC),
                                            8
                                        ) = 0,
                                        NULL,
                                        ROUND(
                                            CAST(CASE
                                                WHEN ROUND(CAST(SUBSTR(CAST(a.offen_bis AS STRING), 4, 2) AS BIGNUMERIC), 0) <> 0
                                                    THEN (
                                                        CAST(SUBSTR(
                                                            SUBSTR(
                                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                1,
                                                                16
                                                            ),
                                                            1,
                                                            INSTR(
                                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                '.',
                                                                1
                                                            ) - 1
                                                        ) AS FLOAT64) - CAST(SUBSTR(
                                                            SUBSTR(
                                                                CAST((
                                                                    CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                                                ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                1,
                                                                16
                                                            ),
                                                            1,
                                                            (
                                                                INSTR(
                                                                    CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                    '.',
                                                                    1
                                                                ) - 1
                                                            )
                                                        ) AS FLOAT64)
                                                    ) / 3600 + 0.5
                                                ELSE (
                                                    CAST(SUBSTR(
                                                        SUBSTR(
                                                            CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                            1,
                                                            16
                                                        ),
                                                        1,
                                                        INSTR(
                                                            CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_bis AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                            '.',
                                                            1
                                                        ) - 1
                                                    ) AS FLOAT64) - CAST(SUBSTR(
                                                        SUBSTR(
                                                            CAST((
                                                                CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60
                                                            ) + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                            1,
                                                            16
                                                        ),
                                                        1,
                                                        (
                                                            INSTR(
                                                                CAST(CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 0, 2) AS FLOAT64) * 3600 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 4, 2) AS FLOAT64) * 60 + CAST(SUBSTR(SUBSTR(CAST(a.offen_von AS STRING), 1, 8), 7, 2) AS FLOAT64) AS STRING),
                                                                '.',
                                                                1
                                                            ) - 1
                                                        )
                                                    ) AS FLOAT64)
                                                ) / 3600
                                            END AS NUMERIC),
                                            8
                                        )
                                    ),
                                    0
                                ) / 60
                            ),
                            0
                        ) AS INT64) / IF(a.menge_schnitt = 0, NULL, a.menge_schnitt),
                        0
                    ),
                    2
                )
            END
        END AS NUMERIC) AS aufschlag_uhrzeit_la_prozent,
        b.aufschlag_zeit,
        b.ant_mag,
        b.faktor_ist,
        COALESCE(c.fruehstart_menge, b.min_gesamt_fs) AS min_gesamt_fs,
        b.ant_min_fs,
        b.prognoseart
    FROM `_max_abv` AS a
    INNER JOIN dbp_data.back_vorgabe_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.back_drehklasse_id = b.back_drehklasse_id
            AND a.wug_cluster_id = b.wug_cluster_id
            AND a.aktion_fg = b.aktion_fg
            AND a.wup_cluster_id = b.wup_cluster_id
    LEFT JOIN dbp_data.art_backshop_fruehstart_2 AS c
        ON a.mandant_id = c.mandant_id AND a.art_id = c.art_id AND a.wup_id = c.wup_id
);

UPDATE dbp_etl.vis_ods_tmp_2 SET menge_ods = 0, menge_01 = 0, menge_02 = 0, menge_03 = 0, menge_04 = 0, menge_16 = 0
WHERE
    NOT (
        mandant_id,
        CASE
            WHEN mandant_id > 1
                THEN CAST(FLOOR(art_id / 10) AS INT64)
            ELSE CAST(FLOOR(art_id / 100) AS INT64)
        END
    ) IN (
        SELECT
            (
                a.mandant_id,
                CASE
                    WHEN a.mandant_id > 1
                        THEN CAST(FLOOR(a.art_id / 10) AS INT64)
                    ELSE CAST(FLOOR(a.art_id / 100) AS INT64)
                END
            )
        FROM dbp_data.art_backshop_zu_2 AS a
        INNER JOIN dbp_data.art_backshop_2 AS b
            ON a.mandant_id = b.mandant_id AND a.bestell_art_id = b.bestell_art_id
    );

CREATE OR REPLACE TEMPORARY TABLE _vis_fur_tmp_calculation (
    mandant_id INT64,
    art_id INT64,
    wup_id INT64,
    dat DATE,
    menge_fur_mean NUMERIC(29, 3),
    menge_fur_max NUMERIC(29, 3),
    menge_fur_aktion NUMERIC(29, 3),
    aktion_fg INT64,
    back_drehklasse_id STRING(2),
    wug_cluster_id INT64,
    wup_cluster_id INT64,
    letzter_abverkauf_avg TIME,
    menge_schnitt NUMERIC(29, 3),
    menge_pro_min NUMERIC(29, 3),
    aufschlag_uhrzeit_tmp INT64,
    aufschlag_uhrzeit_la_prozent NUMERIC(29, 2),
    aufschlag_zeit NUMERIC(29, 2),
    ant_mag NUMERIC(29, 2),
    faktor_ist NUMERIC(29, 2),
    min_gesamt_fs NUMERIC(29, 2),
    ant_min_fs NUMERIC(29, 2),
    prognoseart STRING(10) COLLATE 'und:ci',
    tagesmenge_fur INT64
);

INSERT INTO `_vis_fur_tmp_calculation` (
    mandant_id,
    art_id,
    wup_id,
    dat,
    menge_fur_mean,
    menge_fur_max,
    menge_fur_aktion,
    aktion_fg,
    back_drehklasse_id,
    wug_cluster_id,
    wup_cluster_id,
    letzter_abverkauf_avg,
    menge_schnitt,
    menge_pro_min,
    aufschlag_uhrzeit_tmp,
    aufschlag_uhrzeit_la_prozent,
    aufschlag_zeit,
    ant_mag,
    faktor_ist,
    min_gesamt_fs,
    ant_min_fs,
    prognoseart,
    tagesmenge_fur
)
(
    SELECT
        a.mandant_id,
        a.art_id,
        a.wup_id,
        a.dat,
        COALESCE(b.menge_fur_mean, 0) AS menge_fur_mean_,
        COALESCE(b.menge_fur_max, 0) AS menge_fur_max_,
        COALESCE(b.menge_fur_aktion, 0) AS menge_fur_aktion_,
        a.aktion_fg,
        a.back_drehklasse_id,
        a.wug_cluster_id,
        a.wup_cluster_id,
        a.letzter_abverkauf_avg,
        a.menge_schnitt,
        a.menge_pro_min,
        a.aufschlag_uhrzeit_tmp,
        a.aufschlag_uhrzeit_la_prozent,
        a.aufschlag_zeit,
        a.ant_mag,
        a.faktor_ist,
        a.min_gesamt_fs,
        a.ant_min_fs,
        a.prognoseart,
        CASE
            WHEN COALESCE(b.menge_fur_aktion, 0) <> 0
                THEN CAST(ROUND(
                    GREATEST(
                        a.min_gesamt_fs,
                        COALESCE(b.menge_fur_aktion, 0) + COALESCE(b.menge_fur_aktion, 0) * CASE WHEN a.aufschlag_zeit = 0 THEN 0 ELSE a.aufschlag_uhrzeit_la_prozent END
                    ),
                    0
                ) AS INT64)
            WHEN a.prognoseart = 'FC_MEAN'
                THEN CAST(ROUND(
                    GREATEST(
                        a.min_gesamt_fs,
                        COALESCE(b.menge_fur_mean, 0) + COALESCE(b.menge_fur_mean, 0) * CASE WHEN a.aufschlag_zeit = 0 THEN 0 ELSE a.aufschlag_uhrzeit_la_prozent END
                    ),
                    0
                ) AS INT64)
            ELSE CAST(ROUND(
                GREATEST(
                    a.min_gesamt_fs,
                    COALESCE(b.menge_fur_max, 0) + COALESCE(b.menge_fur_max, 0) * CASE WHEN a.aufschlag_zeit = 0 THEN 0 ELSE a.aufschlag_uhrzeit_la_prozent END
                ),
                0
            ) AS INT64)
        END AS tagesmenge_fur
    FROM `_max_abv2` AS a
    LEFT JOIN dbp_etl.vis_fur_tmp_2 AS b
        ON
            a.mandant_id = b.mandant_id
            AND a.wup_id = b.wup_id
            AND a.art_id = b.art_id
            AND a.dat = b.dat
);

CREATE OR REPLACE TEMPORARY TABLE _vis_ods_tmp_calculation1 AS
SELECT DISTINCT
    a.mandant_id,
    a.art_id,
    a.wup_id,
    a.wtag_id,
    a.aktion_fg,
    a.menge_ods,
    a.anz_ods,
    a.menge_schnitt,
    a.back_drehklasse_id,
    a.menge_01,
    a.menge_02,
    a.menge_03,
    a.menge_04,
    a.menge_16,
    a.anz_16,
    b.dat,
    b.wug_cluster_id,
    b.wup_cluster_id,
    b.menge_pro_min,
    b.aufschlag_uhrzeit_la_prozent,
    b.aufschlag_zeit,
    b.ant_mag,
    b.faktor_ist,
    b.min_gesamt_fs,
    b.ant_min_fs,
    b.prognoseart,
    b.tagesmenge_fur,
    c2.ofen_typ_id,
    c2.blech_belegung,
    c3.back_programm_id,
    CASE
        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
            THEN 0
        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
    END AS ist_anteil_ffs,
    CASE
        WHEN
            GREATEST(
                b.ant_mag,
                CASE
                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                        THEN 0
                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                END * b.faktor_ist
            ) > 1
            THEN 1
        ELSE GREATEST(
            b.ant_mag,
            CASE
                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                    THEN 0
                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
            END * b.faktor_ist
        )
    END AS soll_anteil_ffs,
    b.tagesmenge_fur * CASE
        WHEN
            GREATEST(
                b.ant_mag,
                CASE
                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                        THEN 0
                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                END * b.faktor_ist
            ) > 1
            THEN 1
        ELSE GREATEST(
            b.ant_mag,
            CASE
                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                    THEN 0
                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
            END * b.faktor_ist
        )
    END AS gff_stueck_ungerundet,
    CASE
        WHEN c2.blech_belegung = 0
            THEN 0
        ELSE b.tagesmenge_fur * CASE
            WHEN
                GREATEST(
                    b.ant_mag,
                    CASE
                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                            THEN 0
                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                    END * b.faktor_ist
                ) > 1
                THEN 1
            ELSE GREATEST(
                b.ant_mag,
                CASE
                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                        THEN 0
                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                END * b.faktor_ist
            )
        END / c2.blech_belegung
    END AS gff_blech_ungerundet,
    CASE
        WHEN c2.blech_belegung = 0
            THEN 0
        ELSE CAST(ROUND(
            CASE
                WHEN c2.blech_belegung = 0
                    THEN 0
                ELSE b.tagesmenge_fur * CASE
                    WHEN
                        GREATEST(
                            b.ant_mag,
                            CASE
                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                    THEN 0
                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                            END * b.faktor_ist
                        ) > 1
                        THEN 1
                    ELSE GREATEST(
                        b.ant_mag,
                        CASE
                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                THEN 0
                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                        END * b.faktor_ist
                    )
                END / c2.blech_belegung
            END,
            0
        ) AS INT64)
    END AS gff_blech_gerundet,
    CASE
        WHEN c2.blech_belegung = 0
            THEN 0
        WHEN (
            a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
        )
        AND GREATEST(
            CAST(ROUND(
                b.tagesmenge_fur * CASE
                    WHEN
                        GREATEST(
                            b.ant_mag,
                            CASE
                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                    THEN 0
                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                            END * b.faktor_ist
                        ) > 1
                        THEN 1
                    ELSE GREATEST(
                        b.ant_mag,
                        CASE
                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                THEN 0
                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                        END * b.faktor_ist
                    )
                END,
                0
            ) AS INT64),
            b.min_gesamt_fs
        ) <= b.tagesmenge_fur
            THEN GREATEST(
                CAST(ROUND(
                    b.tagesmenge_fur * CASE
                        WHEN
                            GREATEST(
                                b.ant_mag,
                                CASE
                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                        THEN 0
                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                END * b.faktor_ist
                            ) > 1
                            THEN 1
                        ELSE GREATEST(
                            b.ant_mag,
                            CASE
                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                    THEN 0
                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                            END * b.faktor_ist
                        )
                    END,
                    0
                ) AS INT64),
                b.min_gesamt_fs
            )
        WHEN
            CASE
                WHEN c2.blech_belegung = 0
                    THEN 0
                ELSE CAST(ROUND(
                    CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        ELSE b.tagesmenge_fur * CASE
                            WHEN
                                GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                ) > 1
                                THEN 1
                            ELSE GREATEST(
                                b.ant_mag,
                                CASE
                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                        THEN 0
                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                END * b.faktor_ist
                            )
                        END / c2.blech_belegung
                    END,
                    0
                ) AS INT64)
            END * c2.blech_belegung <= b.tagesmenge_fur
            THEN CAST(CASE
                WHEN c2.blech_belegung = 0
                    THEN 0
                ELSE CAST(ROUND(
                    CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        ELSE b.tagesmenge_fur * CASE
                            WHEN
                                GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                ) > 1
                                THEN 1
                            ELSE GREATEST(
                                b.ant_mag,
                                CASE
                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                        THEN 0
                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                END * b.faktor_ist
                            )
                        END / c2.blech_belegung
                    END,
                    0
                ) AS INT64)
            END * c2.blech_belegung AS BIGNUMERIC)
        ELSE CAST(CAST(ROUND(
            b.tagesmenge_fur * CASE
                WHEN
                    GREATEST(
                        b.ant_mag,
                        CASE
                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                THEN 0
                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                        END * b.faktor_ist
                    ) > 1
                    THEN 1
                ELSE GREATEST(
                    b.ant_mag,
                    CASE
                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                            THEN 0
                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                    END * b.faktor_ist
                )
            END,
            0
        ) AS INT64) AS BIGNUMERIC)
    END AS gff_stueck_gerundet,
    CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_01 / a.anz_ods END AS summe_10,
    CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END AS summe_14,
    CASE
        WHEN CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END = 0
            THEN 0
        ELSE CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_01 / a.anz_ods END / CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END
    END AS ist_anteil_fs,
    CASE
        WHEN
            c3.back_programm_id = 999
            OR CASE
                WHEN c2.blech_belegung = 0
                    THEN 0
                ELSE CAST(ROUND(
                    CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        ELSE b.tagesmenge_fur * CASE
                            WHEN
                                GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                ) > 1
                                THEN 1
                            ELSE GREATEST(
                                b.ant_mag,
                                CASE
                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                        THEN 0
                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                END * b.faktor_ist
                            )
                        END / c2.blech_belegung
                    END,
                    0
                ) AS INT64)
            END < 1.5
            THEN 1.000
        ELSE b.ant_min_fs
    END AS mindestanteil_fs,
    GREATEST(
        CASE
            WHEN CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END = 0
                THEN 0
            ELSE CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_01 / a.anz_ods END / CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END
        END,
        CASE
            WHEN
                c3.back_programm_id = 999
                OR CASE
                    WHEN c2.blech_belegung = 0
                        THEN 0
                    ELSE CAST(ROUND(
                        CASE
                            WHEN c2.blech_belegung = 0
                                THEN 0
                            ELSE b.tagesmenge_fur * CASE
                                WHEN
                                    GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    ) > 1
                                    THEN 1
                                ELSE GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                )
                            END / c2.blech_belegung
                        END,
                        0
                    ) AS INT64)
                END < 1.5
                THEN 1.000
            ELSE b.ant_min_fs
        END
    ) AS soll_anteil_fs,
    CASE
        WHEN NOT c.nb_id IS NULL
            THEN c.fruehstart_menge
        WHEN
            CASE
                WHEN c2.blech_belegung = 0
                    THEN 0
                WHEN (
                    a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
                )
                AND GREATEST(
                    CAST(ROUND(
                        b.tagesmenge_fur * CASE
                            WHEN
                                GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                ) > 1
                                THEN 1
                            ELSE GREATEST(
                                b.ant_mag,
                                CASE
                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                        THEN 0
                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                END * b.faktor_ist
                            )
                        END,
                        0
                    ) AS INT64),
                    b.min_gesamt_fs
                ) <= b.tagesmenge_fur
                    THEN GREATEST(
                        CAST(ROUND(
                            b.tagesmenge_fur * CASE
                                WHEN
                                    GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    ) > 1
                                    THEN 1
                                ELSE GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                )
                            END,
                            0
                        ) AS INT64),
                        b.min_gesamt_fs
                    )
                WHEN
                    CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        ELSE CAST(ROUND(
                            CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                ELSE b.tagesmenge_fur * CASE
                                    WHEN
                                        GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        ) > 1
                                        THEN 1
                                    ELSE GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    )
                                END / c2.blech_belegung
                            END,
                            0
                        ) AS INT64)
                    END * c2.blech_belegung <= b.tagesmenge_fur
                    THEN CAST(CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        ELSE CAST(ROUND(
                            CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                ELSE b.tagesmenge_fur * CASE
                                    WHEN
                                        GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        ) > 1
                                        THEN 1
                                    ELSE GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    )
                                END / c2.blech_belegung
                            END,
                            0
                        ) AS INT64)
                    END * c2.blech_belegung AS BIGNUMERIC)
                ELSE CAST(CAST(ROUND(
                    b.tagesmenge_fur * CASE
                        WHEN
                            GREATEST(
                                b.ant_mag,
                                CASE
                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                        THEN 0
                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                END * b.faktor_ist
                            ) > 1
                            THEN 1
                        ELSE GREATEST(
                            b.ant_mag,
                            CASE
                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                    THEN 0
                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                            END * b.faktor_ist
                        )
                    END,
                    0
                ) AS INT64) AS BIGNUMERIC)
            END = 0
            THEN 4
        WHEN
            GREATEST(
                CASE
                    WHEN CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END = 0
                        THEN 0
                    ELSE CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_01 / a.anz_ods END / CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END
                END,
                CASE
                    WHEN
                        c3.back_programm_id = 999
                        OR CASE
                            WHEN c2.blech_belegung = 0
                                THEN 0
                            ELSE CAST(ROUND(
                                CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    ELSE b.tagesmenge_fur * CASE
                                        WHEN
                                            GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            ) > 1
                                            THEN 1
                                        ELSE GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        )
                                    END / c2.blech_belegung
                                END,
                                0
                            ) AS INT64)
                        END < 1.5
                        THEN 1.000
                    ELSE b.ant_min_fs
                END
            ) = 1
            THEN CASE
                WHEN c2.blech_belegung = 0
                    THEN 0
                WHEN (
                    a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
                )
                AND GREATEST(
                    CAST(ROUND(
                        b.tagesmenge_fur * CASE
                            WHEN
                                GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                ) > 1
                                THEN 1
                            ELSE GREATEST(
                                b.ant_mag,
                                CASE
                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                        THEN 0
                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                END * b.faktor_ist
                            )
                        END,
                        0
                    ) AS INT64),
                    b.min_gesamt_fs
                ) <= b.tagesmenge_fur
                    THEN GREATEST(
                        CAST(ROUND(
                            b.tagesmenge_fur * CASE
                                WHEN
                                    GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    ) > 1
                                    THEN 1
                                ELSE GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                )
                            END,
                            0
                        ) AS INT64),
                        b.min_gesamt_fs
                    )
                WHEN
                    CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        ELSE CAST(ROUND(
                            CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                ELSE b.tagesmenge_fur * CASE
                                    WHEN
                                        GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        ) > 1
                                        THEN 1
                                    ELSE GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    )
                                END / c2.blech_belegung
                            END,
                            0
                        ) AS INT64)
                    END * c2.blech_belegung <= b.tagesmenge_fur
                    THEN CAST(CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        ELSE CAST(ROUND(
                            CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                ELSE b.tagesmenge_fur * CASE
                                    WHEN
                                        GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        ) > 1
                                        THEN 1
                                    ELSE GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    )
                                END / c2.blech_belegung
                            END,
                            0
                        ) AS INT64)
                    END * c2.blech_belegung AS BIGNUMERIC)
                ELSE CAST(CAST(ROUND(
                    b.tagesmenge_fur * CASE
                        WHEN
                            GREATEST(
                                b.ant_mag,
                                CASE
                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                        THEN 0
                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                END * b.faktor_ist
                            ) > 1
                            THEN 1
                        ELSE GREATEST(
                            b.ant_mag,
                            CASE
                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                    THEN 0
                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                            END * b.faktor_ist
                        )
                    END,
                    0
                ) AS INT64) AS BIGNUMERIC)
            END
        ELSE CASE
            WHEN
                CASE
                    WHEN c2.blech_belegung = 0
                        THEN 0
                    ELSE CAST(ROUND(
                        CASE
                            WHEN c2.blech_belegung = 0
                                THEN 0
                            ELSE b.tagesmenge_fur * CASE
                                WHEN
                                    GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    ) > 1
                                    THEN 1
                                ELSE GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                )
                            END / c2.blech_belegung
                        END,
                        0
                    ) AS INT64)
                END <= 2
                THEN CASE
                    WHEN c2.blech_belegung = 0
                        THEN 0
                    WHEN (
                        a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
                    )
                    AND GREATEST(
                        CAST(ROUND(
                            b.tagesmenge_fur * CASE
                                WHEN
                                    GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    ) > 1
                                    THEN 1
                                ELSE GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                )
                            END,
                            0
                        ) AS INT64),
                        b.min_gesamt_fs
                    ) <= b.tagesmenge_fur
                        THEN GREATEST(
                            CAST(ROUND(
                                b.tagesmenge_fur * CASE
                                    WHEN
                                        GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        ) > 1
                                        THEN 1
                                    ELSE GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    )
                                END,
                                0
                            ) AS INT64),
                            b.min_gesamt_fs
                        )
                    WHEN
                        CASE
                            WHEN c2.blech_belegung = 0
                                THEN 0
                            ELSE CAST(ROUND(
                                CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    ELSE b.tagesmenge_fur * CASE
                                        WHEN
                                            GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            ) > 1
                                            THEN 1
                                        ELSE GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        )
                                    END / c2.blech_belegung
                                END,
                                0
                            ) AS INT64)
                        END * c2.blech_belegung <= b.tagesmenge_fur
                        THEN CAST(CASE
                            WHEN c2.blech_belegung = 0
                                THEN 0
                            ELSE CAST(ROUND(
                                CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    ELSE b.tagesmenge_fur * CASE
                                        WHEN
                                            GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            ) > 1
                                            THEN 1
                                        ELSE GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        )
                                    END / c2.blech_belegung
                                END,
                                0
                            ) AS INT64)
                        END * c2.blech_belegung AS BIGNUMERIC)
                    ELSE CAST(CAST(ROUND(
                        b.tagesmenge_fur * CASE
                            WHEN
                                GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                ) > 1
                                THEN 1
                            ELSE GREATEST(
                                b.ant_mag,
                                CASE
                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                        THEN 0
                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                END * b.faktor_ist
                            )
                        END,
                        0
                    ) AS INT64) AS BIGNUMERIC)
                END
            ELSE CASE
                WHEN c2.blech_belegung = 0
                    THEN 0
                WHEN
                    CAST(ROUND(
                        CASE
                            WHEN c2.blech_belegung = 0
                                THEN 0
                            WHEN (
                                a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
                            )
                            AND GREATEST(
                                CAST(ROUND(
                                    b.tagesmenge_fur * CASE
                                        WHEN
                                            GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            ) > 1
                                            THEN 1
                                        ELSE GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        )
                                    END,
                                    0
                                ) AS INT64),
                                b.min_gesamt_fs
                            ) <= b.tagesmenge_fur
                                THEN GREATEST(
                                    CAST(ROUND(
                                        b.tagesmenge_fur * CASE
                                            WHEN
                                                GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                ) > 1
                                                THEN 1
                                            ELSE GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            )
                                        END,
                                        0
                                    ) AS INT64),
                                    b.min_gesamt_fs
                                )
                            WHEN
                                CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    ELSE CAST(ROUND(
                                        CASE
                                            WHEN c2.blech_belegung = 0
                                                THEN 0
                                            ELSE b.tagesmenge_fur * CASE
                                                WHEN
                                                    GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    ) > 1
                                                    THEN 1
                                                ELSE GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                )
                                            END / c2.blech_belegung
                                        END,
                                        0
                                    ) AS INT64)
                                END * c2.blech_belegung <= b.tagesmenge_fur
                                THEN CAST(CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    ELSE CAST(ROUND(
                                        CASE
                                            WHEN c2.blech_belegung = 0
                                                THEN 0
                                            ELSE b.tagesmenge_fur * CASE
                                                WHEN
                                                    GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    ) > 1
                                                    THEN 1
                                                ELSE GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                )
                                            END / c2.blech_belegung
                                        END,
                                        0
                                    ) AS INT64)
                                END * c2.blech_belegung AS BIGNUMERIC)
                            ELSE CAST(CAST(ROUND(
                                b.tagesmenge_fur * CASE
                                    WHEN
                                        GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        ) > 1
                                        THEN 1
                                    ELSE GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    )
                                END,
                                0
                            ) AS INT64) AS BIGNUMERIC)
                        END * GREATEST(
                            CASE
                                WHEN CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END = 0
                                    THEN 0
                                ELSE CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_01 / a.anz_ods END / CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END
                            END,
                            CASE
                                WHEN
                                    c3.back_programm_id = 999
                                    OR CASE
                                        WHEN c2.blech_belegung = 0
                                            THEN 0
                                        ELSE CAST(ROUND(
                                            CASE
                                                WHEN c2.blech_belegung = 0
                                                    THEN 0
                                                ELSE b.tagesmenge_fur * CASE
                                                    WHEN
                                                        GREATEST(
                                                            b.ant_mag,
                                                            CASE
                                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                    THEN 0
                                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                            END * b.faktor_ist
                                                        ) > 1
                                                        THEN 1
                                                    ELSE GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    )
                                                END / c2.blech_belegung
                                            END,
                                            0
                                        ) AS INT64)
                                    END < 1.5
                                    THEN 1.000
                                ELSE b.ant_min_fs
                            END
                        ) / c2.blech_belegung + 0.4999,
                        0
                    ) AS INT64) * c2.blech_belegung < b.min_gesamt_fs
                    THEN b.min_gesamt_fs
                ELSE CAST(CAST(ROUND(
                    CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        WHEN (
                            a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
                        )
                        AND GREATEST(
                            CAST(ROUND(
                                b.tagesmenge_fur * CASE
                                    WHEN
                                        GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        ) > 1
                                        THEN 1
                                    ELSE GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    )
                                END,
                                0
                            ) AS INT64),
                            b.min_gesamt_fs
                        ) <= b.tagesmenge_fur
                            THEN GREATEST(
                                CAST(ROUND(
                                    b.tagesmenge_fur * CASE
                                        WHEN
                                            GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            ) > 1
                                            THEN 1
                                        ELSE GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        )
                                    END,
                                    0
                                ) AS INT64),
                                b.min_gesamt_fs
                            )
                        WHEN
                            CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                ELSE CAST(ROUND(
                                    CASE
                                        WHEN c2.blech_belegung = 0
                                            THEN 0
                                        ELSE b.tagesmenge_fur * CASE
                                            WHEN
                                                GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                ) > 1
                                                THEN 1
                                            ELSE GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            )
                                        END / c2.blech_belegung
                                    END,
                                    0
                                ) AS INT64)
                            END * c2.blech_belegung <= b.tagesmenge_fur
                            THEN CAST(CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                ELSE CAST(ROUND(
                                    CASE
                                        WHEN c2.blech_belegung = 0
                                            THEN 0
                                        ELSE b.tagesmenge_fur * CASE
                                            WHEN
                                                GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                ) > 1
                                                THEN 1
                                            ELSE GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            )
                                        END / c2.blech_belegung
                                    END,
                                    0
                                ) AS INT64)
                            END * c2.blech_belegung AS BIGNUMERIC)
                        ELSE CAST(CAST(ROUND(
                            b.tagesmenge_fur * CASE
                                WHEN
                                    GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    ) > 1
                                    THEN 1
                                ELSE GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                )
                            END,
                            0
                        ) AS INT64) AS BIGNUMERIC)
                    END * GREATEST(
                        CASE
                            WHEN CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END = 0
                                THEN 0
                            ELSE CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_01 / a.anz_ods END / CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END
                        END,
                        CASE
                            WHEN
                                c3.back_programm_id = 999
                                OR CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    ELSE CAST(ROUND(
                                        CASE
                                            WHEN c2.blech_belegung = 0
                                                THEN 0
                                            ELSE b.tagesmenge_fur * CASE
                                                WHEN
                                                    GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    ) > 1
                                                    THEN 1
                                                ELSE GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                )
                                            END / c2.blech_belegung
                                        END,
                                        0
                                    ) AS INT64)
                                END < 1.5
                                THEN 1.000
                            ELSE b.ant_min_fs
                        END
                    ) / c2.blech_belegung + 0.4999,
                    0
                ) AS INT64) * c2.blech_belegung AS BIGNUMERIC)
            END
        END
    END AS fs_in_stueck,
    CASE
        WHEN c2.blech_belegung = 0
            THEN 0
        ELSE ROUND(
            CASE
                WHEN NOT c.nb_id IS NULL
                    THEN c.fruehstart_menge
                WHEN
                    CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        WHEN (
                            a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
                        )
                        AND GREATEST(
                            CAST(ROUND(
                                b.tagesmenge_fur * CASE
                                    WHEN
                                        GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        ) > 1
                                        THEN 1
                                    ELSE GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    )
                                END,
                                0
                            ) AS INT64),
                            b.min_gesamt_fs
                        ) <= b.tagesmenge_fur
                            THEN GREATEST(
                                CAST(ROUND(
                                    b.tagesmenge_fur * CASE
                                        WHEN
                                            GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            ) > 1
                                            THEN 1
                                        ELSE GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        )
                                    END,
                                    0
                                ) AS INT64),
                                b.min_gesamt_fs
                            )
                        WHEN
                            CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                ELSE CAST(ROUND(
                                    CASE
                                        WHEN c2.blech_belegung = 0
                                            THEN 0
                                        ELSE b.tagesmenge_fur * CASE
                                            WHEN
                                                GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                ) > 1
                                                THEN 1
                                            ELSE GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            )
                                        END / c2.blech_belegung
                                    END,
                                    0
                                ) AS INT64)
                            END * c2.blech_belegung <= b.tagesmenge_fur
                            THEN CAST(CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                ELSE CAST(ROUND(
                                    CASE
                                        WHEN c2.blech_belegung = 0
                                            THEN 0
                                        ELSE b.tagesmenge_fur * CASE
                                            WHEN
                                                GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                ) > 1
                                                THEN 1
                                            ELSE GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            )
                                        END / c2.blech_belegung
                                    END,
                                    0
                                ) AS INT64)
                            END * c2.blech_belegung AS BIGNUMERIC)
                        ELSE CAST(CAST(ROUND(
                            b.tagesmenge_fur * CASE
                                WHEN
                                    GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    ) > 1
                                    THEN 1
                                ELSE GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                )
                            END,
                            0
                        ) AS INT64) AS BIGNUMERIC)
                    END = 0
                    THEN 4
                WHEN
                    GREATEST(
                        CASE
                            WHEN CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END = 0
                                THEN 0
                            ELSE CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_01 / a.anz_ods END / CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END
                        END,
                        CASE
                            WHEN
                                c3.back_programm_id = 999
                                OR CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    ELSE CAST(ROUND(
                                        CASE
                                            WHEN c2.blech_belegung = 0
                                                THEN 0
                                            ELSE b.tagesmenge_fur * CASE
                                                WHEN
                                                    GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    ) > 1
                                                    THEN 1
                                                ELSE GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                )
                                            END / c2.blech_belegung
                                        END,
                                        0
                                    ) AS INT64)
                                END < 1.5
                                THEN 1.000
                            ELSE b.ant_min_fs
                        END
                    ) = 1
                    THEN CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        WHEN (
                            a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
                        )
                        AND GREATEST(
                            CAST(ROUND(
                                b.tagesmenge_fur * CASE
                                    WHEN
                                        GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        ) > 1
                                        THEN 1
                                    ELSE GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    )
                                END,
                                0
                            ) AS INT64),
                            b.min_gesamt_fs
                        ) <= b.tagesmenge_fur
                            THEN GREATEST(
                                CAST(ROUND(
                                    b.tagesmenge_fur * CASE
                                        WHEN
                                            GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            ) > 1
                                            THEN 1
                                        ELSE GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        )
                                    END,
                                    0
                                ) AS INT64),
                                b.min_gesamt_fs
                            )
                        WHEN
                            CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                ELSE CAST(ROUND(
                                    CASE
                                        WHEN c2.blech_belegung = 0
                                            THEN 0
                                        ELSE b.tagesmenge_fur * CASE
                                            WHEN
                                                GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                ) > 1
                                                THEN 1
                                            ELSE GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            )
                                        END / c2.blech_belegung
                                    END,
                                    0
                                ) AS INT64)
                            END * c2.blech_belegung <= b.tagesmenge_fur
                            THEN CAST(CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                ELSE CAST(ROUND(
                                    CASE
                                        WHEN c2.blech_belegung = 0
                                            THEN 0
                                        ELSE b.tagesmenge_fur * CASE
                                            WHEN
                                                GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                ) > 1
                                                THEN 1
                                            ELSE GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            )
                                        END / c2.blech_belegung
                                    END,
                                    0
                                ) AS INT64)
                            END * c2.blech_belegung AS BIGNUMERIC)
                        ELSE CAST(CAST(ROUND(
                            b.tagesmenge_fur * CASE
                                WHEN
                                    GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    ) > 1
                                    THEN 1
                                ELSE GREATEST(
                                    b.ant_mag,
                                    CASE
                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                            THEN 0
                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                    END * b.faktor_ist
                                )
                            END,
                            0
                        ) AS INT64) AS BIGNUMERIC)
                    END
                ELSE CASE
                    WHEN
                        CASE
                            WHEN c2.blech_belegung = 0
                                THEN 0
                            ELSE CAST(ROUND(
                                CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    ELSE b.tagesmenge_fur * CASE
                                        WHEN
                                            GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            ) > 1
                                            THEN 1
                                        ELSE GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        )
                                    END / c2.blech_belegung
                                END,
                                0
                            ) AS INT64)
                        END <= 2
                        THEN CASE
                            WHEN c2.blech_belegung = 0
                                THEN 0
                            WHEN (
                                a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
                            )
                            AND GREATEST(
                                CAST(ROUND(
                                    b.tagesmenge_fur * CASE
                                        WHEN
                                            GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            ) > 1
                                            THEN 1
                                        ELSE GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        )
                                    END,
                                    0
                                ) AS INT64),
                                b.min_gesamt_fs
                            ) <= b.tagesmenge_fur
                                THEN GREATEST(
                                    CAST(ROUND(
                                        b.tagesmenge_fur * CASE
                                            WHEN
                                                GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                ) > 1
                                                THEN 1
                                            ELSE GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            )
                                        END,
                                        0
                                    ) AS INT64),
                                    b.min_gesamt_fs
                                )
                            WHEN
                                CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    ELSE CAST(ROUND(
                                        CASE
                                            WHEN c2.blech_belegung = 0
                                                THEN 0
                                            ELSE b.tagesmenge_fur * CASE
                                                WHEN
                                                    GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    ) > 1
                                                    THEN 1
                                                ELSE GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                )
                                            END / c2.blech_belegung
                                        END,
                                        0
                                    ) AS INT64)
                                END * c2.blech_belegung <= b.tagesmenge_fur
                                THEN CAST(CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    ELSE CAST(ROUND(
                                        CASE
                                            WHEN c2.blech_belegung = 0
                                                THEN 0
                                            ELSE b.tagesmenge_fur * CASE
                                                WHEN
                                                    GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    ) > 1
                                                    THEN 1
                                                ELSE GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                )
                                            END / c2.blech_belegung
                                        END,
                                        0
                                    ) AS INT64)
                                END * c2.blech_belegung AS BIGNUMERIC)
                            ELSE CAST(CAST(ROUND(
                                b.tagesmenge_fur * CASE
                                    WHEN
                                        GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        ) > 1
                                        THEN 1
                                    ELSE GREATEST(
                                        b.ant_mag,
                                        CASE
                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                THEN 0
                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                        END * b.faktor_ist
                                    )
                                END,
                                0
                            ) AS INT64) AS BIGNUMERIC)
                        END
                    ELSE CASE
                        WHEN c2.blech_belegung = 0
                            THEN 0
                        WHEN
                            CAST(ROUND(
                                CASE
                                    WHEN c2.blech_belegung = 0
                                        THEN 0
                                    WHEN (
                                        a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
                                    )
                                    AND GREATEST(
                                        CAST(ROUND(
                                            b.tagesmenge_fur * CASE
                                                WHEN
                                                    GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    ) > 1
                                                    THEN 1
                                                ELSE GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                )
                                            END,
                                            0
                                        ) AS INT64),
                                        b.min_gesamt_fs
                                    ) <= b.tagesmenge_fur
                                        THEN GREATEST(
                                            CAST(ROUND(
                                                b.tagesmenge_fur * CASE
                                                    WHEN
                                                        GREATEST(
                                                            b.ant_mag,
                                                            CASE
                                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                    THEN 0
                                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                            END * b.faktor_ist
                                                        ) > 1
                                                        THEN 1
                                                    ELSE GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    )
                                                END,
                                                0
                                            ) AS INT64),
                                            b.min_gesamt_fs
                                        )
                                    WHEN
                                        CASE
                                            WHEN c2.blech_belegung = 0
                                                THEN 0
                                            ELSE CAST(ROUND(
                                                CASE
                                                    WHEN c2.blech_belegung = 0
                                                        THEN 0
                                                    ELSE b.tagesmenge_fur * CASE
                                                        WHEN
                                                            GREATEST(
                                                                b.ant_mag,
                                                                CASE
                                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                        THEN 0
                                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                                END * b.faktor_ist
                                                            ) > 1
                                                            THEN 1
                                                        ELSE GREATEST(
                                                            b.ant_mag,
                                                            CASE
                                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                    THEN 0
                                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                            END * b.faktor_ist
                                                        )
                                                    END / c2.blech_belegung
                                                END,
                                                0
                                            ) AS INT64)
                                        END * c2.blech_belegung <= b.tagesmenge_fur
                                        THEN CAST(CASE
                                            WHEN c2.blech_belegung = 0
                                                THEN 0
                                            ELSE CAST(ROUND(
                                                CASE
                                                    WHEN c2.blech_belegung = 0
                                                        THEN 0
                                                    ELSE b.tagesmenge_fur * CASE
                                                        WHEN
                                                            GREATEST(
                                                                b.ant_mag,
                                                                CASE
                                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                        THEN 0
                                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                                END * b.faktor_ist
                                                            ) > 1
                                                            THEN 1
                                                        ELSE GREATEST(
                                                            b.ant_mag,
                                                            CASE
                                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                    THEN 0
                                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                            END * b.faktor_ist
                                                        )
                                                    END / c2.blech_belegung
                                                END,
                                                0
                                            ) AS INT64)
                                        END * c2.blech_belegung AS BIGNUMERIC)
                                    ELSE CAST(CAST(ROUND(
                                        b.tagesmenge_fur * CASE
                                            WHEN
                                                GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                ) > 1
                                                THEN 1
                                            ELSE GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            )
                                        END,
                                        0
                                    ) AS INT64) AS BIGNUMERIC)
                                END * GREATEST(
                                    CASE
                                        WHEN CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END = 0
                                            THEN 0
                                        ELSE CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_01 / a.anz_ods END / CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END
                                    END,
                                    CASE
                                        WHEN
                                            c3.back_programm_id = 999
                                            OR CASE
                                                WHEN c2.blech_belegung = 0
                                                    THEN 0
                                                ELSE CAST(ROUND(
                                                    CASE
                                                        WHEN c2.blech_belegung = 0
                                                            THEN 0
                                                        ELSE b.tagesmenge_fur * CASE
                                                            WHEN
                                                                GREATEST(
                                                                    b.ant_mag,
                                                                    CASE
                                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                            THEN 0
                                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                                    END * b.faktor_ist
                                                                ) > 1
                                                                THEN 1
                                                            ELSE GREATEST(
                                                                b.ant_mag,
                                                                CASE
                                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                        THEN 0
                                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                                END * b.faktor_ist
                                                            )
                                                        END / c2.blech_belegung
                                                    END,
                                                    0
                                                ) AS INT64)
                                            END < 1.5
                                            THEN 1.000
                                        ELSE b.ant_min_fs
                                    END
                                ) / c2.blech_belegung + 0.4999,
                                0
                            ) AS INT64) * c2.blech_belegung < b.min_gesamt_fs
                            THEN b.min_gesamt_fs
                        ELSE CAST(CAST(ROUND(
                            CASE
                                WHEN c2.blech_belegung = 0
                                    THEN 0
                                WHEN (
                                    a.back_drehklasse_id = 'LD' OR b.wug_cluster_id = 2
                                )
                                AND GREATEST(
                                    CAST(ROUND(
                                        b.tagesmenge_fur * CASE
                                            WHEN
                                                GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                ) > 1
                                                THEN 1
                                            ELSE GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            )
                                        END,
                                        0
                                    ) AS INT64),
                                    b.min_gesamt_fs
                                ) <= b.tagesmenge_fur
                                    THEN GREATEST(
                                        CAST(ROUND(
                                            b.tagesmenge_fur * CASE
                                                WHEN
                                                    GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    ) > 1
                                                    THEN 1
                                                ELSE GREATEST(
                                                    b.ant_mag,
                                                    CASE
                                                        WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                            THEN 0
                                                        ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                    END * b.faktor_ist
                                                )
                                            END,
                                            0
                                        ) AS INT64),
                                        b.min_gesamt_fs
                                    )
                                WHEN
                                    CASE
                                        WHEN c2.blech_belegung = 0
                                            THEN 0
                                        ELSE CAST(ROUND(
                                            CASE
                                                WHEN c2.blech_belegung = 0
                                                    THEN 0
                                                ELSE b.tagesmenge_fur * CASE
                                                    WHEN
                                                        GREATEST(
                                                            b.ant_mag,
                                                            CASE
                                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                    THEN 0
                                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                            END * b.faktor_ist
                                                        ) > 1
                                                        THEN 1
                                                    ELSE GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    )
                                                END / c2.blech_belegung
                                            END,
                                            0
                                        ) AS INT64)
                                    END * c2.blech_belegung <= b.tagesmenge_fur
                                    THEN CAST(CASE
                                        WHEN c2.blech_belegung = 0
                                            THEN 0
                                        ELSE CAST(ROUND(
                                            CASE
                                                WHEN c2.blech_belegung = 0
                                                    THEN 0
                                                ELSE b.tagesmenge_fur * CASE
                                                    WHEN
                                                        GREATEST(
                                                            b.ant_mag,
                                                            CASE
                                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                    THEN 0
                                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                            END * b.faktor_ist
                                                        ) > 1
                                                        THEN 1
                                                    ELSE GREATEST(
                                                        b.ant_mag,
                                                        CASE
                                                            WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                THEN 0
                                                            ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                        END * b.faktor_ist
                                                    )
                                                END / c2.blech_belegung
                                            END,
                                            0
                                        ) AS INT64)
                                    END * c2.blech_belegung AS BIGNUMERIC)
                                ELSE CAST(CAST(ROUND(
                                    b.tagesmenge_fur * CASE
                                        WHEN
                                            GREATEST(
                                                b.ant_mag,
                                                CASE
                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                        THEN 0
                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                END * b.faktor_ist
                                            ) > 1
                                            THEN 1
                                        ELSE GREATEST(
                                            b.ant_mag,
                                            CASE
                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                    THEN 0
                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                            END * b.faktor_ist
                                        )
                                    END,
                                    0
                                ) AS INT64) AS BIGNUMERIC)
                            END * GREATEST(
                                CASE
                                    WHEN CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END = 0
                                        THEN 0
                                    ELSE CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_01 / a.anz_ods END / CASE WHEN a.anz_ods = 0 THEN 0 ELSE a.menge_02 / a.anz_ods END
                                END,
                                CASE
                                    WHEN
                                        c3.back_programm_id = 999
                                        OR CASE
                                            WHEN c2.blech_belegung = 0
                                                THEN 0
                                            ELSE CAST(ROUND(
                                                CASE
                                                    WHEN c2.blech_belegung = 0
                                                        THEN 0
                                                    ELSE b.tagesmenge_fur * CASE
                                                        WHEN
                                                            GREATEST(
                                                                b.ant_mag,
                                                                CASE
                                                                    WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                        THEN 0
                                                                    ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                                END * b.faktor_ist
                                                            ) > 1
                                                            THEN 1
                                                        ELSE GREATEST(
                                                            b.ant_mag,
                                                            CASE
                                                                WHEN a.anz_ods = 0 OR a.menge_schnitt = 0
                                                                    THEN 0
                                                                ELSE ROUND(CAST(a.menge_02 / a.anz_ods / a.menge_schnitt AS NUMERIC), 2)
                                                            END * b.faktor_ist
                                                        )
                                                    END / c2.blech_belegung
                                                END,
                                                0
                                            ) AS INT64)
                                        END < 1.5
                                        THEN 1.000
                                    ELSE b.ant_min_fs
                                END
                            ) / c2.blech_belegung + 0.4999,
                            0
                        ) AS INT64) * c2.blech_belegung AS BIGNUMERIC)
                    END
                END
            END / c2.blech_belegung,
            1
        )
    END AS fs_in_blech
FROM dbp_etl.vis_ods_tmp_2 AS a
INNER JOIN `_vis_fur_tmp_calculation` AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND a.wup_id = b.wup_id
        AND a.wtag_id = MOD(DATE_DIFF(b.dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1
LEFT JOIN dbp_data.art_backshop_fruehstart_2 AS c
    ON a.mandant_id = c.mandant_id AND a.art_id = c.art_id AND a.wup_id = c.wup_id
INNER JOIN dbp_data.wup_backshop_per_2 AS c1
    ON
        a.mandant_id = c1.mandant_id
        AND a.wup_id = c1.wup_id
        AND c1.dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND c1.nb_id = 0
INNER JOIN (
    SELECT
        a.mandant_id,
        a.art_id,
        a.ofen_typ_id,
        b0.blech_belegung
    FROM (
        SELECT
            mandant_id,
            art_id,
            MAX(ofen_typ_id) AS ofen_typ_id
        FROM dbp_data.art_ofentyp_zu_2
        GROUP BY
            mandant_id,
            art_id
    ) AS a
    INNER JOIN dbp_data.art_ofentyp_zu_2 AS b0
        ON
            a.mandant_id = b0.mandant_id
            AND a.art_id = b0.art_id
            AND a.ofen_typ_id = b0.ofen_typ_id
) AS c2
    ON a.mandant_id = c2.mandant_id AND a.art_id = c2.art_id
INNER JOIN (
    SELECT
        mandant_id,
        art_id,
        MAX(back_programm_id) AS back_programm_id
    FROM dbp_data.art_backprogramm_zu_2
    GROUP BY
        mandant_id,
        art_id
) AS c3
    ON a.mandant_id = c3.mandant_id AND a.art_id = c3.art_id;

CREATE OR REPLACE TABLE dbp_etl.`_vis_ods_tmp_calculation2` AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    wtag_id,
    aktion_fg,
    menge_ods,
    anz_ods,
    menge_schnitt,
    back_drehklasse_id,
    menge_01,
    menge_02,
    menge_03,
    menge_04,
    menge_16,
    anz_16,
    dat,
    wug_cluster_id,
    wup_cluster_id,
    menge_pro_min,
    aufschlag_uhrzeit_la_prozent,
    aufschlag_zeit,
    ant_mag,
    faktor_ist,
    min_gesamt_fs,
    ant_min_fs,
    prognoseart,
    tagesmenge_fur,
    ofen_typ_id,
    blech_belegung,
    back_programm_id,
    ist_anteil_ffs,
    soll_anteil_ffs,
    gff_stueck_ungerundet,
    gff_blech_ungerundet,
    gff_blech_gerundet,
    gff_stueck_gerundet,
    summe_10,
    summe_14,
    ist_anteil_fs,
    mindestanteil_fs,
    soll_anteil_fs,
    fs_in_stueck,
    fs_in_blech,
    CASE
        WHEN gff_stueck_gerundet = 0 OR gff_stueck_gerundet = fs_in_stueck
            THEN 0
        ELSE blech_belegung * (
            gff_stueck_gerundet - fs_in_stueck
        ) / COALESCE(blech_belegung, 1)
    END AS fsc_in_stueck,
    CASE
        WHEN
            CASE
                WHEN gff_stueck_gerundet = 0 OR gff_stueck_gerundet = fs_in_stueck
                    THEN 0
                ELSE blech_belegung * (
                    gff_stueck_gerundet - fs_in_stueck
                ) / COALESCE(blech_belegung, 1)
            END = 0
            THEN 0
        ELSE blech_belegung * CEIL(
            CASE
                WHEN gff_stueck_gerundet = 0
                    THEN 0
                WHEN gff_stueck_gerundet = fs_in_stueck
                    THEN 0
                ELSE blech_belegung * (
                    gff_stueck_gerundet - fs_in_stueck
                ) / COALESCE(blech_belegung, 1)
            END / COALESCE(blech_belegung, 1)
        )
    END AS fsc_in_blech,
    CASE
        WHEN soll_anteil_fs = 0
            THEN 0
        ELSE CASE
            WHEN anz_ods = 0 OR menge_schnitt = 0
                THEN 0
            ELSE IFNULL(
                CAST(menge_03 / anz_ods / IF(menge_schnitt = 0, NULL, menge_schnitt) AS NUMERIC),
                0
            )
        END
    END AS anteil_abv_nachmittag,
    CASE
        WHEN tagesmenge_fur = 0
            THEN 0
        ELSE IFNULL(
            CAST(menge_04 / anz_ods / IF(menge_schnitt = 0, NULL, menge_schnitt) AS NUMERIC),
            0
        )
    END AS anteil_abv_abend,
    CAST(tagesmenge_fur * CASE
        WHEN soll_anteil_fs = 0
            THEN 0
        ELSE CASE
            WHEN anz_ods = 0 OR menge_schnitt = 0
                THEN 0
            ELSE IFNULL(
                CAST(menge_03 / anz_ods / IF(menge_schnitt = 0, NULL, menge_schnitt) AS NUMERIC),
                0
            )
        END
    END AS BIGNUMERIC) + 1 AS erwarteter_abv_nachmittag,
    CAST(tagesmenge_fur * CASE
        WHEN tagesmenge_fur = 0
            THEN 0
        ELSE IFNULL(
            CAST(menge_04 / anz_ods / IF(menge_schnitt = 0, NULL, menge_schnitt) AS NUMERIC),
            0
        )
    END AS BIGNUMERIC) + 1 AS erwarteter_abv_abend,
    0 AS menge_abschrift_schnitt
FROM `_vis_ods_tmp_calculation1` AS a;

CREATE OR REPLACE TEMPORARY TABLE _marktabs1 AS
SELECT
    x1.mandant_id,
    x1.wup_id,
    x1.art_id,
    x1.wtag_id_,
    x1.menge_abschrift_,
    CAST(ROUND(CAST(x1.menge_abschrift_ AS NUMERIC) / CAST(y.anz_ods AS NUMERIC), 0) AS INT64) AS schnitt
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        wtag_id_,
        SUM(menge_abschrift) AS menge_abschrift_
    FROM (
        SELECT
            mandant_id,
            wup_id,
            art_id,
            CASE WHEN wtag_id IN (7, 1) THEN 6 ELSE wtag_id - 1 END AS wtag_id_,
            SUM(menge_abschrift) AS menge_abschrift
        FROM (
            SELECT
                a.mandant_id,
                a.wup_id,
                a.art_id,
                MOD(DATE_DIFF(a.dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 AS wtag_id,
                a.dat,
                COUNT(DISTINCT a.dat) AS anzahl,
                SUM(a.menge_abschrift) AS menge_abschrift
            FROM dbp_data.marktabschriften_2 AS a
            INNER JOIN (
                SELECT
                    mandant_id,
                    wup_id,
                    art_id
                FROM dbp_etl.`_vis_ods_tmp_calculation2`
                WHERE
                    mandant_id = 1
                GROUP BY
                    mandant_id,
                    art_id,
                    wup_id
            ) AS t1_2
                ON a.mandant_id = t1.mandant_id AND a.wup_id = t1.wup_id AND a.art_id = t1.art_id
            WHERE
                a.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '49' DAY) AND (
                    DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '1' DAY)
                )
                AND a.abschriftart_id IN (
                    SELECT b.abschriftart_id
                    FROM dbp_data.l_abschriftart_int_2 AS a0
                    INNER JOIN dbp_data.abschriftart_int_zu_2 AS b
                        ON a0.abschriftart_int_id = b.abschriftart_int_id
                    WHERE
                        a0.abschriftart_thema_int_id = 1 AND b.mandant_id = 1
                    GROUP BY
                        b.abschriftart_id
                )
            GROUP BY
                a.mandant_id,
                a.wup_id,
                a.art_id,
                wtag_id,
                a.dat
        ) AS a1
        GROUP BY
            mandant_id,
            wup_id,
            art_id,
            wtag_id_
    ) AS x
    GROUP BY
        mandant_id,
        wup_id,
        art_id,
        wtag_id_
) AS x1
INNER JOIN dbp_etl.`_vis_ods_tmp_calculation2` AS y
    ON
        x1.mandant_id = y.mandant_id
        AND x1.wup_id = y.wup_id
        AND x1.art_id = y.art_id
        AND x1.wtag_id_ = y.wtag_id;

CREATE OR REPLACE TEMPORARY TABLE _marktabs1_kmo AS
SELECT
    x1.mandant_id,
    x1.wup_id,
    x1.art_id,
    x1.wtag_id_,
    x1.menge_abschrift_,
    CAST(ROUND(CAST(x1.menge_abschrift_ AS NUMERIC) / CAST(y.anz_ods AS NUMERIC), 0) AS INT64) AS schnitt
FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        wtag_id_,
        SUM(menge_abschrift) AS menge_abschrift_
    FROM (
        SELECT
            mandant_id,
            wup_id,
            art_id,
            CASE WHEN mandant_id = 8 THEN wtag_id - 1 ELSE wtag_id END AS wtag_id_,
            SUM(menge_abschrift) AS menge_abschrift
        FROM (
            SELECT
                a.mandant_id,
                a.wup_id,
                a.art_id,
                MOD(DATE_DIFF(a.dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 AS wtag_id,
                a.dat,
                COUNT(DISTINCT a.dat) AS anzahl,
                SUM(a.menge_abschrift) AS menge_abschrift
            FROM dbp_data.marktabschriften_2 AS a
            INNER JOIN (
                SELECT
                    mandant_id,
                    wup_id,
                    art_id
                FROM dbp_etl.`_vis_ods_tmp_calculation2`
                WHERE
                    mandant_id > 1
                GROUP BY
                    mandant_id,
                    art_id,
                    wup_id
            ) AS t1_2
                ON a.mandant_id = t1.mandant_id AND a.wup_id = t1.wup_id AND a.art_id = t1.art_id
            WHERE
                a.dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '49' DAY) AND (
                    DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL '1' DAY)
                )
                AND a.abschriftart_id IN (
                    SELECT b.abschriftart_id
                    FROM dbp_data.l_abschriftart_int_2 AS a0
                    INNER JOIN dbp_data.abschriftart_int_zu_2 AS b
                        ON a0.abschriftart_int_id = b.abschriftart_int_id
                    WHERE
                        a0.abschriftart_thema_int_id = 1 AND b.mandant_id > 1
                    GROUP BY
                        b.abschriftart_id
                )
            GROUP BY
                a.mandant_id,
                a.wup_id,
                a.art_id,
                wtag_id,
                a.dat
        ) AS a1
        GROUP BY
            mandant_id,
            wup_id,
            art_id,
            wtag_id_
    ) AS x
    GROUP BY
        mandant_id,
        wup_id,
        art_id,
        wtag_id_
) AS x1
INNER JOIN dbp_etl.`_vis_ods_tmp_calculation2` AS y
    ON
        x1.mandant_id = y.mandant_id
        AND x1.wup_id = y.wup_id
        AND x1.art_id = y.art_id
        AND x1.wtag_id_ = y.wtag_id;

UPDATE dbp_etl.`_vis_ods_tmp_calculation2` SET menge_abschrift_schnitt = b.schnitt
FROM `_marktabs1` AS b
WHERE
    `_vis_ods_tmp_calculation2`.mandant_id = b.mandant_id
    AND `_vis_ods_tmp_calculation2`.wup_id = b.wup_id
    AND `_vis_ods_tmp_calculation2`.art_id = b.art_id
    AND `_vis_ods_tmp_calculation2`.wtag_id = b.wtag_id_;

UPDATE dbp_etl.`_vis_ods_tmp_calculation2` SET menge_abschrift_schnitt = b.schnitt
FROM `_marktabs1_kmo` AS b
WHERE
    `_vis_ods_tmp_calculation2`.mandant_id = b.mandant_id
    AND `_vis_ods_tmp_calculation2`.wup_id = b.wup_id
    AND `_vis_ods_tmp_calculation2`.art_id = b.art_id
    AND `_vis_ods_tmp_calculation2`.wtag_id = b.wtag_id_;
