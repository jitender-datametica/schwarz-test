DELETE FROM dbp_etl.vis_ods_tmp_calculation2_1
WHERE
    dat IN (
        SELECT dat
        FROM dbp_etl.`_vis_ods_tmp_calculation2`
    );

INSERT INTO dbp_etl.vis_ods_tmp_calculation2_1
(
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
        CAST(ist_anteil_ffs AS NUMERIC) AS ist_anteil_ffs,
        CAST(soll_anteil_ffs AS NUMERIC) AS soll_anteil_ffs,
        CAST(gff_stueck_ungerundet AS NUMERIC) AS gff_stueck_ungerundet,
        gff_blech_ungerundet,
        gff_blech_gerundet,
        CAST(gff_stueck_gerundet AS NUMERIC) AS gff_stueck_gerundet,
        CAST(summe_10 AS NUMERIC) AS summe_10,
        CAST(summe_14 AS NUMERIC) AS summe_14,
        ist_anteil_fs,
        mindestanteil_fs,
        soll_anteil_fs,
        CAST(fs_in_stueck AS NUMERIC) AS fs_in_stueck,
        CAST(fs_in_blech AS NUMERIC) AS fs_in_blech,
        CAST(fsc_in_stueck AS INT64) AS fsc_in_stueck,
        CAST(fsc_in_blech AS INT64) AS fsc_in_blech,
        CAST(anteil_abv_nachmittag AS NUMERIC) AS anteil_abv_nachmittag,
        CAST(anteil_abv_abend AS NUMERIC) AS anteil_abv_abend,
        CAST(erwarteter_abv_nachmittag AS INT64) AS erwarteter_abv_nachmittag,
        CAST(erwarteter_abv_abend AS INT64) AS erwarteter_abv_abend,
        menge_abschrift_schnitt
    FROM dbp_etl.`_vis_ods_tmp_calculation2`
);

UPDATE dbp_etl.vis_agg_tmp_1 SET menge_prognose = a.menge_fur_mean, menge_prognose_max = a.menge_fur_max, menge_prognose_aktion = a.menge_fur_aktion
FROM dbp_etl.vis_fur_tmp_1 AS a
WHERE
    vis_agg_tmp.mandant_id = a.mandant_id
    AND vis_agg_tmp.art_id = a.art_id
    AND vis_agg_tmp.wup_id = a.wup_id
    AND vis_agg_tmp.dat = a.dat;

UPDATE dbp_etl.vis_agg_tmp_1 SET menge_check = IFNULL(a.menge_16 / IF(a.anz_16 = 0, NULL, a.anz_16), 0), anteil_01 = IFNULL(a.menge_01 / IF(a.anz_ods = 0, NULL, a.anz_ods), 0), anteil_02 = IFNULL(a.menge_02 / IF(a.anz_ods = 0, NULL, a.anz_ods), 0), anteil_03 = IFNULL(a.menge_03 / IF(a.anz_ods = 0, NULL, a.anz_ods), 0), anteil_04 = IFNULL(a.menge_04 / IF(a.anz_ods = 0, NULL, a.anz_ods), 0), tagesmenge = a.tagesmenge, gff_menge_stueck = CAST(a.gff_menge_stueck AS INT64), fs1_menge_stueck = CAST(a.fs1_menge_stueck AS INT64), fs2_menge_stueck = CAST(a.fs2_menge_stueck AS INT64), erw_absatz_spaet = CAST(a.erw_absatz_spaet AS INT64), erw_absatz_abend = CAST(a.erw_absatz_abend AS INT64), avg_menge_abschrift = CAST(a.avg_menge_abschrift AS INT64), wug_cluster_id = a.wug_cluster_id_, back_drehklasse_id = a.back_drehklasse_id_, wup_cluster_id = a.wup_cluster_id_, menge_schnitt = a.menge_schnitt
FROM (
    SELECT
        mandant_id,
        CASE
            WHEN mandant_id > 1
                THEN CAST(FLOOR(art_id / 10) AS INT64)
            ELSE CAST(FLOOR(art_id / 100) AS INT64)
        END AS kl_art_id,
        wup_id,
        wtag_id,
        COALESCE(MAX(wug_cluster_id), -1) AS wug_cluster_id_,
        COALESCE(MAX(wup_cluster_id), -1) AS wup_cluster_id_,
        COALESCE(MAX(back_drehklasse_id), '-1') AS back_drehklasse_id_,
        SUM(menge_16) AS menge_16,
        SUM(menge_01) AS menge_01,
        SUM(menge_02) AS menge_02,
        SUM(menge_03) AS menge_03,
        SUM(menge_04) AS menge_04,
        SUM(anz_16) AS anz_16,
        SUM(anz_ods) AS anz_ods,
        COALESCE(SUM(tagesmenge_fur), 0) AS tagesmenge,
        CASE
            WHEN COALESCE(MAX(back_drehklasse_id), '-1') = 'LD'
                THEN COALESCE(SUM(fs_in_stueck + fsc_in_stueck), 0)
            ELSE COALESCE(SUM(fs_in_stueck + fsc_in_blech), 0)
        END AS gff_menge_stueck,
        COALESCE(SUM(fs_in_stueck), 0) AS fs1_menge_stueck,
        CASE
            WHEN COALESCE(MAX(back_drehklasse_id), '-1') = 'LD'
                THEN COALESCE(SUM(fsc_in_stueck), 0)
            ELSE COALESCE(SUM(fsc_in_blech), 0)
        END AS fs2_menge_stueck,
        COALESCE(SUM(erwarteter_abv_nachmittag), 0) AS erw_absatz_spaet,
        COALESCE(SUM(erwarteter_abv_abend), 0) AS erw_absatz_abend,
        COALESCE(SUM(menge_abschrift_schnitt), 0) AS avg_menge_abschrift,
        COALESCE(SUM(menge_schnitt), 0) AS menge_schnitt
    FROM dbp_etl.`_vis_ods_tmp_calculation2`
    GROUP BY
        mandant_id,
        kl_art_id,
        wup_id,
        wtag_id
    HAVING
        COALESCE(erw_absatz_spaet, 0) < 10000
) AS a
WHERE
    vis_agg_tmp.mandant_id = a.mandant_id
    AND vis_agg_tmp.wup_id = a.wup_id
    AND CASE
        WHEN vis_agg_tmp.mandant_id > 1
            THEN CAST(FLOOR(vis_agg_tmp.art_id / 10) AS INT64)
        ELSE CAST(FLOOR(vis_agg_tmp.art_id / 100) AS INT64)
    END = a.kl_art_id
    AND MOD(DATE_DIFF(vis_agg_tmp.dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 = a.wtag_id;

UPDATE dbp_etl.vis_agg_tmp_1 SET tagesmenge = CAST(b.prognose_menge AS INT64)
FROM (
    SELECT
        mandant_id,
        art_id,
        wup_id,
        dat,
        menge_fur_mean,
        menge_fur_max,
        menge_fur_aktion,
        CASE
            WHEN menge_fur_aktion <> 0
                THEN menge_fur_aktion
            WHEN menge_fur_max <> 0
                THEN menge_fur_max
            ELSE menge_fur_mean
        END AS prognose_menge
    FROM dbp_etl.vis_fur_tmp_1 AS a
    WHERE
        CASE
            WHEN menge_fur_aktion <> 0
                THEN menge_fur_aktion
            WHEN menge_fur_max <> 0
                THEN menge_fur_max
            ELSE menge_fur_mean
        END <> 0
) AS b
WHERE
    vis_agg_tmp.mandant_id = b.mandant_id
    AND vis_agg_tmp.art_id = b.art_id
    AND vis_agg_tmp.wup_id = b.wup_id
    AND vis_agg_tmp.dat = b.dat;

UPDATE dbp_etl.vis_agg_tmp_1 SET gff_menge_stueck = CAST(vis_agg_tmp.tagesmenge * 0.65 AS INT64), fs1_menge_stueck = CAST(vis_agg_tmp.tagesmenge * 0.65 AS INT64), erw_absatz_spaet = CAST(vis_agg_tmp.tagesmenge * 0.20 AS INT64), erw_absatz_abend = CAST(vis_agg_tmp.tagesmenge * 0.15 AS INT64)
WHERE
    menge_schnitt = 0 AND back_drehklasse_id <> '';

UPDATE dbp_etl.vis_agg_tmp_1 SET gff_menge_stueck = CAST(vis_agg_tmp.tagesmenge * 0.65 AS INT64), fs1_menge_stueck = CAST(vis_agg_tmp.tagesmenge * 0.65 AS INT64), erw_absatz_spaet = CAST(vis_agg_tmp.tagesmenge * 0.20 AS INT64), erw_absatz_abend = CAST(vis_agg_tmp.tagesmenge * 0.15 AS INT64), back_drehklasse_id = 'LD'
WHERE
    menge_schnitt = 0 AND back_drehklasse_id = '';

UPDATE dbp_etl.vis_agg_tmp_1 SET gff_menge_stueck = vis_agg_tmp.fs1_menge_stueck
WHERE
    gff_menge_stueck = 0 AND fs1_menge_stueck <> 0;

UPDATE dbp_etl.vis_agg_tmp_1 SET gff_menge_stueck = vis_agg_tmp.fs1_menge_stueck
WHERE
    fs1_menge_stueck > gff_menge_stueck;

CREATE OR REPLACE TEMPORARY TABLE _dup_check AS
SELECT
    a.art_id,
    a.mandant_id,
    a.wup_id,
    a.nb_id,
    a.dat,
    a.menge_prognose,
    a.menge_prognose_max,
    a.menge_prognose_aktion,
    a.min_sicherh_bestand,
    a.listung_id,
    a.aktion_fg,
    a.menge_check,
    a.anteil_01,
    a.anteil_02,
    a.anteil_03,
    a.anteil_04,
    a.tagesmenge,
    a.gff_menge_stueck,
    a.fs1_menge_stueck,
    a.fs2_menge_stueck,
    a.erw_absatz_spaet,
    a.erw_absatz_abend,
    a.avg_menge_abschrift,
    a.wup_cluster_id,
    a.wug_cluster_id,
    a.back_drehklasse_id,
    a.aktion_id,
    a.menge_schnitt
FROM dbp_etl.vis_agg_tmp_1 AS a
INNER JOIN (
    SELECT
        mandant_id,
        art_id,
        wup_id,
        dat
    FROM dbp_etl.vis_agg_tmp_1
    GROUP BY
        art_id,
        mandant_id,
        wup_id,
        dat
    HAVING
        COUNT(*) > 1
) AS b
    ON
        a.art_id = b.art_id
        AND a.wup_id = b.wup_id
        AND a.dat = b.dat
        AND a.mandant_id = b.mandant_id
QUALIFY
    (
        ROW_NUMBER() OVER (
            PARTITION BY a.mandant_id, a.art_id, a.wup_id, a.dat
            ORDER BY a.mandant_id IS NULL, a.mandant_id, a.art_id IS NULL, a.art_id, a.wup_id IS NULL, a.wup_id, a.dat IS NULL, a.dat
        )
    ) = 1;

DELETE FROM dbp_etl.vis_agg_tmp_1
WHERE
    (mandant_id, art_id, wup_id, dat) IN (
        SELECT (mandant_id, art_id, wup_id, dat)
        FROM `_dup_check`
    );

INSERT INTO dbp_etl.vis_agg_tmp_1
(
    SELECT *
    FROM `_dup_check`
);

CREATE OR REPLACE TEMPORARY TABLE _kill_nd AS
SELECT
    a.art_id,
    a.mandant_id,
    a.wup_id,
    a.nb_id,
    a.dat_von,
    a.system_id,
    a.loesch_id,
    a.dat_bis,
    a.wg_verkett_id,
    a.fremd_lagerort_id,
    a.disponent_id,
    a.pps_plan_kalender_id,
    a.disposition_rhythmus_id,
    a.planlieferzeit,
    a.dispomerkmal,
    a.we_bearbeitungszeit,
    a.min_sicherh_bestand,
    a.anliefer_kalender,
    a.kdis,
    a.bezugsweg_id,
    a.terminierungsgruppe_1_id,
    a.terminierungsgruppe_2_id,
    a.terminierungsgruppe_3_id,
    a.sollbestand,
    a.dat_loesch_id,
    a.selbstabholung_fg,
    a.min_restlaufzeit,
    a.dat_liefersperre_bis,
    a.ref_wup_id,
    a.rate_ref_absatz,
    a.ref_art_id,
    a.dat_ref_gueltig_bis,
    a.td_update,
    a.td_insert
FROM dbp_data.art_wup_status_per_1 AS a
INNER JOIN dbp_data.art_wg_zu_per_1 AS b
    ON
        a.mandant_id = b.mandant_id
        AND a.art_id = b.art_id
        AND b.arthiertyp_id = 2
        AND b.dat_bis = CAST('9999-12-31' AS DATE)
WHERE
    a.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN a.dat_von AND a.dat_bis
    AND b.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE
            wg_filter_id = 3 AND arthiertyp_id = 2
    )
    AND a.dispomerkmal = 'ND';

DELETE FROM dbp_etl.vis_agg_tmp_1
WHERE
    (mandant_id, art_id, wup_id) IN (
        SELECT (mandant_id, art_id, wup_id)
        FROM `_kill_nd`
    );

DELETE FROM dbp_etl.vis_agg_tmp_1
WHERE
    MOD(DATE_DIFF(dat, CAST('1900-01-01' AS DATE), DAY), 7) + 1 = 7
    AND menge_prognose = 0
    AND menge_prognose_max = 0
    AND menge_prognose_aktion = 0
    AND mandant_id = 1;

CREATE OR REPLACE TEMPORARY TABLE _posten AS
SELECT
    a.mandant_id,
    a.wup_id,
    a.art_id,
    b.dat,
    MIN(c.dat_von) AS dat_von,
    MAX(DATE_ADD(c.dat_bis, INTERVAL '7' DAY)) AS dat_bis
FROM dbp_data.aktion_art_wup_zu_1 AS a
INNER JOIN dbp_etl.vis_agg_tmp_1 AS b
    ON
        a.art_id = b.art_id
        AND a.mandant_id = b.mandant_id
        AND a.wup_id = b.wup_id
        AND a.nb_id = b.nb_id
INNER JOIN dbp_data.aktion_1 AS c
    ON
        a.mandant_id = c.mandant_id
        AND a.aktion_id = c.aktion_id
        AND b.dat BETWEEN c.dat_von AND (
            DATE_ADD(c.dat_bis, INTERVAL '7' DAY)
        )
INNER JOIN dbp_data.art_1 AS d
    ON
        a.mandant_id = d.mandant_id
        AND a.art_id = d.art_id
        AND d.dat_bis = CAST('9999-12-31' AS DATE)
        AND d.posten_id IN ('PN', 'SP', 'PS', '1')
WHERE
    (a.mandant_id, a.art_id) IN (
        SELECT (awzp.mandant_id, awzp.art_id)
        FROM dbp_data.art_wg_zu_per_1 AS awzp
        INNER JOIN dbp_data.wg_filter_zu_1 AS wfz
            ON
                awzp.wg_id = wfz.wg_id
                AND awzp.mandant_id = wfz.mandant_id
                AND wfz.wg_filter_id = 3
                AND wfz.arthiertyp_id = 2
        WHERE
            awzp.dat_bis = CAST('9999-12-31' AS DATE) AND awzp.arthiertyp_id = 2
    )
    AND a.grund_sperrung IS NULL
    AND CASE
        WHEN c.mandant_id = 1
            THEN c.preisaktiviert_fg
        WHEN
            c.mandant_id > 1
            AND a.dat_preisaktiviert <> CAST('1900-01-01' AS DATE)
            AND NOT (c.mandant_id, c.aktion_id) IN (
                SELECT (mandant_id, aktion_id)
                FROM dbp_data.l_bonuskauf_1
            )
            THEN 1
        ELSE 0
    END = 1
GROUP BY
    a.mandant_id,
    a.wup_id,
    a.art_id,
    b.dat;

CREATE OR REPLACE TEMPORARY TABLE _listung AS
SELECT
    a.mandant_id,
    awsp.wup_id,
    a.art_id,
    a.posten_id,
    awzp.dat_von,
    awzp.dat_bis,
    awzp.listung_id
FROM dbp_data.art_1 AS a
INNER JOIN dbp_data.art_wup_status_per_1 AS awsp
    ON
        a.art_id = awsp.art_id
        AND a.mandant_id = awsp.mandant_id
        AND awsp.dat_bis = CAST('9999-12-31' AS DATE)
        AND awsp.nb_id = 0
INNER JOIN dbp_data.art_wup_zu_per_1 AS awzp
    ON
        awsp.art_id = awzp.art_id
        AND awsp.mandant_id = awzp.mandant_id
        AND awsp.wup_id = awzp.wup_id
        AND awzp.dat_bis = CAST('9999-12-31' AS DATE)
        AND awzp.nb_id = 0
WHERE
    (a.mandant_id, a.art_id) IN (
        SELECT (awzp0.mandant_id, awzp0.art_id)
        FROM dbp_data.art_wg_zu_per_1 AS awzp0
        INNER JOIN dbp_data.wg_filter_zu_1 AS wfz
            ON
                awzp0.wg_id = wfz.wg_id
                AND awzp0.mandant_id = wfz.mandant_id
                AND wfz.wg_filter_id = 3
                AND wfz.arthiertyp_id = 2
        WHERE
            awzp0.dat_bis = CAST('9999-12-31' AS DATE) AND awzp0.arthiertyp_id = 2
    )
    AND awzp.listung_id = 1
GROUP BY
    a.mandant_id,
    awsp.wup_id,
    a.art_id,
    a.posten_id,
    awzp.dat_von,
    awzp.dat_bis,
    awzp.listung_id;

UPDATE dbp_etl.vis_agg_tmp_1 SET listung_id = 1
FROM `_listung` AS b
WHERE
    vis_agg_tmp.mandant_id = b.mandant_id
    AND vis_agg_tmp.wup_id = b.wup_id
    AND vis_agg_tmp.art_id = b.art_id
    AND vis_agg_tmp.listung_id = 4;

UPDATE dbp_etl.vis_agg_tmp_1 SET listung_id = 4
FROM `_posten` AS b
WHERE
    vis_agg_tmp.mandant_id = b.mandant_id
    AND vis_agg_tmp.wup_id = b.wup_id
    AND vis_agg_tmp.art_id = b.art_id
    AND vis_agg_tmp.dat = b.dat
    AND vis_agg_tmp.listung_id = 1;

UPDATE dbp_etl.vis_agg_tmp_1 AS vis_agg_tmp0 SET wup_cluster_id = t0.max_wup_cluster_id, wug_cluster_id = t0.max_wug_cluster_id
FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(wup_cluster_id) AS max_wup_cluster_id,
        MAX(wug_cluster_id) AS max_wug_cluster_id
    FROM dbp_etl.vis_agg_tmp_1
    GROUP BY
        art_id,
        mandant_id
) AS t0
WHERE
    vis_agg_tmp0.mandant_id = t0.mandant_id
    AND vis_agg_tmp0.art_id = t0.art_id
    AND (
        vis_agg_tmp0.wup_cluster_id <> t0.max_wup_cluster_id
        OR vis_agg_tmp0.wug_cluster_id <> t0.max_wug_cluster_id
    );

UPDATE dbp_etl.vis_agg_tmp_1 SET wup_id = b.aktuell_wup_id
FROM (
    SELECT
        mandant_id,
        aktuell_wup_id,
        orig_wup_id
    FROM dbp_data.wup_1
    WHERE
        wup_aenderung_grund_id = 3 AND aktuell_wup_id <> orig_wup_id AND mandant_id = 1
) AS b
WHERE
    vis_agg_tmp.mandant_id = b.mandant_id AND vis_agg_tmp.wup_id = b.orig_wup_id;

DELETE FROM dbp_etl.vis_agg_tmp_1
WHERE
    mandant_id = 7
    AND art_id IN (
        207787430,
        207787440,
        207787450,
        207787460,
        207785630,
        207787470,
        207787480,
        207787490,
        207787500,
        207787510,
        208458010,
        1495830,
        208931090,
        209026960,
        202153500,
        205535570,
        208453460,
        718190,
        207258760,
        208693700,
        208861940,
        209003140,
        202153500,
        208997150,
        208982160,
        208294480,
        208425100,
        208931090,
        207847310,
        208693700,
        1495830,
        208453460
    );

DELETE FROM dbp_msi_data.backshop_prognose_neu_1
WHERE
    dat IN (
        SELECT dat
        FROM dbp_etl.vis_agg_tmp_1
    );

INSERT INTO dbp_msi_data.backshop_prognose_neu_1 (
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    dat,
    menge_prognose,
    menge_prognose_max,
    menge_prognose_aktion,
    listung_id_backshop,
    menge_check,
    anteil_01,
    anteil_02,
    anteil_03,
    anteil_04,
    menge,
    wup_cluster_id,
    wug_cluster_id,
    back_drehklasse_id,
    aktion_id,
    menge_abschrift,
    menge_tag,
    menge_gff,
    menge_gs,
    menge_spaet,
    menge_abend
)
(
    SELECT
        art_id,
        mandant_id,
        wup_id,
        nb_id,
        dat,
        menge_prognose,
        menge_prognose_max,
        menge_prognose_aktion,
        listung_id,
        menge_check,
        anteil_01,
        anteil_02,
        anteil_03,
        anteil_04,
        menge_schnitt,
        wup_cluster_id,
        wug_cluster_id,
        back_drehklasse_id,
        aktion_id,
        CASE WHEN avg_menge_abschrift >= 1000 THEN 0 ELSE avg_menge_abschrift END,
        CASE WHEN tagesmenge < 4 THEN 4 ELSE tagesmenge END,
        CASE WHEN tagesmenge < 4 THEN 4 ELSE gff_menge_stueck END,
        CASE WHEN tagesmenge < 4 THEN 4 ELSE fs1_menge_stueck END,
        CASE WHEN tagesmenge < 4 THEN 1 ELSE erw_absatz_spaet END,
        CASE WHEN tagesmenge < 4 THEN 1 ELSE erw_absatz_abend END
    FROM dbp_etl.vis_agg_tmp_1
    WHERE
        NOT wup_cluster_id IN (0, -1) OR tagesmenge > 0
);

CREATE OR REPLACE TEMPORARY TABLE _step1 AS
SELECT
    a.mandant_id,
    a.art_id,
    a.wup_id,
    MAX(a.dat) AS dat_vier,
    MIN(b0.akt_wo) AS akt_wo_von,
    MAX(b0.akt_wo) AS akt_wo_bis,
    MIN(b0.kjwo) AS kjwo_von,
    MAX(b0.kjwo) AS kjwo_bis,
    COUNT(DISTINCT b0.kjwo) AS anz
FROM dbp_msi_data.backshop_prognose_neu_1 AS a
INNER JOIN (
    SELECT
        a0.mandant_id,
        a0.wup_id,
        a0.art_id,
        COUNT(DISTINCT b.akt_wo) AS anz,
        MAX(b.kjwo) AS kjwo
    FROM dbp_msi_data.backshop_prognose_neu_1 AS a0
    INNER JOIN dbp_data.tag_1 AS b
        ON a0.dat = b.dat
    WHERE
        a0.listung_id_backshop = 4
    GROUP BY
        a0.art_id,
        a0.mandant_id,
        a0.wup_id
    HAVING
        anz > 1
) AS t2
    ON a.mandant_id = t2.mandant_id AND a.wup_id = t2.wup_id AND a.art_id = t2.art_id
INNER JOIN dbp_data.tag_1 AS b0
    ON a.dat = b0.dat AND t2.kjwo = b0.kjwo
WHERE
    a.listung_id_backshop = 4
GROUP BY
    a.art_id,
    a.mandant_id,
    a.wup_id;

DELETE FROM `_step1`
WHERE
    anz = 2
    AND akt_wo_bis = (
        SELECT MAX(akt_wo_bis)
        FROM `_step1`
    )
    AND akt_wo_von = (
        SELECT MAX(akt_wo_bis)
        FROM `_step1`
    ) - 1;

CREATE OR REPLACE TEMPORARY TABLE _step2 AS
SELECT
    a.mandant_id,
    a.art_id,
    a.wup_id,
    a.dat_vier,
    a.akt_wo_von,
    a.akt_wo_bis,
    a.kjwo_von,
    a.kjwo_bis,
    a.anz,
    a.akt_wo_von + 1 AS akt_wo_bis_track,
    a.akt_wo_von + 1 - 1 AS akt_wo_von_as,
    a.akt_wo_von + 1 + 2 AS akt_wo_bis_as,
    b.kjwo AS kjwo_bis_track,
    c.kjwo AS kjwo_von_as,
    d.kjwo AS kjwo_bis_as
FROM `_step1` AS a
INNER JOIN dbp_data.woche_1 AS b
    ON a.akt_wo_von + 1 = b.akt_wo
INNER JOIN dbp_data.woche_1 AS c
    ON a.akt_wo_von = c.akt_wo
INNER JOIN dbp_data.woche_1 AS d
    ON a.akt_wo_von + 3 = d.akt_wo;

UPDATE dbp_msi_data.backshop_prognose_neu_1 SET listung_id_backshop = 5
FROM (
    SELECT
        a.mandant_id,
        a.art_id,
        a.wup_id,
        a.dat_vier,
        a.akt_wo_von,
        a.akt_wo_bis,
        a.kjwo_von,
        a.kjwo_bis,
        a.anz,
        a.akt_wo_bis_track,
        a.akt_wo_von_as,
        a.akt_wo_bis_as,
        a.kjwo_bis_track,
        a.kjwo_von_as,
        a.kjwo_bis_as,
        b.dat
    FROM `_step2` AS a
    INNER JOIN dbp_data.tag_1 AS b
        ON b.kjwo BETWEEN a.kjwo_von_as AND a.kjwo_bis_as
    WHERE
        b.dat > a.dat_vier
) AS b
WHERE
    backshop_prognose_neu.mandant_id = b.mandant_id
    AND backshop_prognose_neu.art_id = b.art_id
    AND backshop_prognose_neu.wup_id = b.wup_id
    AND backshop_prognose_neu.dat = b.dat
    AND backshop_prognose_neu.aktion_id = '';

CREATE OR REPLACE TEMPORARY TABLE _kill_art1 AS
SELECT
    a.art_id,
    a.wup_id,
    a.mandant_id,
    MAX(b.dat) AS max_dat
FROM `_step2` AS a
INNER JOIN dbp_data.tag_1 AS b
    ON b.kjwo BETWEEN a.kjwo_von_as AND a.kjwo_bis_as
GROUP BY
    a.art_id,
    a.wup_id,
    a.mandant_id;

CREATE OR REPLACE TEMPORARY TABLE _kill_art2 AS
SELECT
    a.art_id,
    a.wup_id,
    a.mandant_id,
    MIN(b.dat) AS min_dat
FROM `_step2` AS a
INNER JOIN dbp_data.tag_1 AS b
    ON b.kjwo BETWEEN a.kjwo_von_as AND a.kjwo_bis_as
GROUP BY
    a.art_id,
    a.wup_id,
    a.mandant_id;

DELETE FROM dbp_msi_data.backshop_prognose_neu_1
WHERE
    (wup_id, mandant_id, art_id, dat, listung_id_backshop) IN (
        SELECT (a.wup_id, a.mandant_id, a.art_id, a.dat, a.listung_id_backshop)
        FROM dbp_msi_data.backshop_prognose_neu_1 AS a
        INNER JOIN `_kill_art1` AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.art_id = b.art_id
                AND a.wup_id = b.wup_id
                AND a.dat > b.max_dat
                AND a.listung_id_backshop = 5
    );

DELETE FROM dbp_msi_data.backshop_prognose_neu_1
WHERE
    (wup_id, mandant_id, art_id, dat, listung_id_backshop) IN (
        SELECT (a.wup_id, a.mandant_id, a.art_id, a.dat, a.listung_id_backshop)
        FROM dbp_msi_data.backshop_prognose_neu_1 AS a
        INNER JOIN `_kill_art2` AS b
            ON
                a.mandant_id = b.mandant_id
                AND a.art_id = b.art_id
                AND a.wup_id = b.wup_id
                AND a.dat < b.min_dat
                AND a.listung_id_backshop = 5
    );

DROP TABLE IF EXISTS dbp_etl.`_vis_ods_tmp_calculation2`;
