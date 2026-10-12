CREATE TEMPORARY TABLE IF NOT EXISTS _marc_tracking AS
SELECT DISTINCT
    B.art_id,
    B.mandant_id,
    B.wup_id,
    B.nb_id,
    A.dat_von,
    B.system_id,
    B.loesch_id,
    B.dat_bis,
    B.wg_verkett_id,
    B.fremd_lagerort_id,
    B.disponent_id,
    B.pps_plan_kalender_id,
    B.disposition_rhythmus_id,
    B.planlieferzeit,
    B.dispomerkmal,
    B.we_bearbeitungszeit,
    A.min_sicherh_bestand,
    B.anliefer_kalender,
    B.kdis,
    B.bezugsweg_id,
    B.terminierungsgruppe_1_id,
    B.terminierungsgruppe_2_id,
    B.terminierungsgruppe_3_id,
    A.sollbestand,
    B.dat_loesch_id,
    B.selbstabholung_fg
FROM ${TEMP_TABLE} AS A
INNER JOIN dbp_data.art_wup_status_per AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.art_id = B.art_id AND A.dat_von BETWEEN B.dat_von AND B.dat_bis AND A.dat_von <> B.dat_von
WHERE
    A.min_sicherh_bestand <> B.min_sicherh_bestand
    OR A.sollbestand <> B.sollbestand;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)


CREATE TEMPORARY TABLE IF NOT EXISTS _upd AS
SELECT
    mandant_id,
    wup_id,
    art_id,
    MIN(dat_von) AS dat_von,
    MAX(min_sicherh_bestand) AS min_sicherh_bestand,
    MAX(sollbestand) AS sollbestand
FROM `_marc_tracking`
GROUP BY
    mandant_id,
    wup_id,
    art_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


/* DBP_ETL.art_wup_status_per_temp */ INSERT INTO `_marc_tracking`
(
    SELECT DISTINCT
        B.art_id,
        B.mandant_id,
        B.wup_id,
        B.nb_id,
        B.dat_von,
        B.system_id,
        B.loesch_id,
        CASE
            WHEN A.dat_von = B.dat_von
                THEN B.dat_bis
            ELSE DATE_SUB(A.dat_von, INTERVAL 1 DAY)
        END AS dat_bis,
        B.wg_verkett_id,
        B.fremd_lagerort_id,
        B.disponent_id,
        B.pps_plan_kalender_id,
        B.disposition_rhythmus_id,
        B.planlieferzeit,
        B.dispomerkmal,
        B.we_bearbeitungszeit,
        CASE
            WHEN A.dat_von = B.dat_von
                THEN A.min_sicherh_bestand
            ELSE B.min_sicherh_bestand
        END AS min_sicherh_bestand,
        B.anliefer_kalender,
        B.kdis,
        B.bezugsweg_id,
        B.terminierungsgruppe_1_id,
        B.terminierungsgruppe_2_id,
        B.terminierungsgruppe_3_id,
        CASE
            WHEN A.dat_von = B.dat_von
                THEN A.sollbestand
            ELSE B.sollbestand
        END AS sollbestand,
        B.dat_loesch_id,
        B.selbstabholung_fg
    FROM ${TEMP_TABLE} AS A
    INNER JOIN dbp_data.art_wup_status_per AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND
            A.art_id = B.art_id AND A.dat_von BETWEEN B.dat_von AND B.dat_bis
    WHERE
        A.min_sicherh_bestand <> B.min_sicherh_bestand
        OR A.sollbestand <> B.sollbestand
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)


CREATE TEMPORARY TABLE IF NOT EXISTS _kill AS
SELECT
    mandant_id,
    wup_id,
    art_id,
    MIN(dat_von) AS dat_von,
    MAX(dat_bis) AS dat_bis
FROM `_marc_tracking`
GROUP BY
    mandant_id,
    wup_id,
    art_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


DELETE FROM dbp_data.art_wup_status_per
WHERE (
    mandant_id, wup_id, art_id, dat_von) IN (
    SELECT (A.mandant_id, A.wup_id, A.art_id, B.dat_von)
    FROM `_kill` AS A
    INNER JOIN dbp_data.art_wup_status_per AS B
        ON
            A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND
            A.art_id = B.art_id AND B.dat_von BETWEEN A.dat_von AND A.dat_bis
    GROUP BY A.mandant_id,
    A.wup_id,
    A.art_id,
    B.dat_von
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_data.art_wup_status_per (
    art_id, mandant_id, wup_id, nb_id, dat_von, system_id, loesch_id,
    dat_bis, wg_verkett_id, fremd_lagerort_id, disponent_id, pps_plan_kalender_id, disposition_rhythmus_id,
    planlieferzeit, dispomerkmal, we_bearbeitungszeit, min_sicherh_bestand, anliefer_kalender, kdis, bezugsweg_id,
    terminierungsgruppe_1_id, terminierungsgruppe_2_id, terminierungsgruppe_3_id, sollbestand, dat_loesch_id,
    selbstabholung_fg, td_update, td_insert
)
(SELECT
    art_id,
    mandant_id,
    wup_id,
    nb_id,
    dat_von,
    system_id,
    loesch_id,
    dat_bis,
    wg_verkett_id,
    fremd_lagerort_id,
    disponent_id,
    pps_plan_kalender_id,
    disposition_rhythmus_id,
    planlieferzeit,
    dispomerkmal,
    we_bearbeitungszeit,
    min_sicherh_bestand,
    anliefer_kalender,
    kdis,
    bezugsweg_id,
    terminierungsgruppe_1_id,
    terminierungsgruppe_2_id,
    terminierungsgruppe_3_id,
    sollbestand,
    dat_loesch_id,
    selbstabholung_fg,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_marc_tracking`);


UPDATE dbp_data.art_wup_status_per SET
    min_sicherh_bestand = b.min_sicherh_bestand,
    sollbestand = b.sollbestand,
    td_update = CURRENT_TIMESTAMP()
FROM `_upd` AS b
WHERE
    art_wup_status_per.mandant_id = b.mandant_id AND art_wup_status_per.wup_id = b.wup_id AND art_wup_status_per.art_id
    = b.art_id AND art_wup_status_per.dat_von >= b.dat_von;


--SPEC0316398


UPDATE dbp_data.art_wup_status_per AS A SET
    dat_von = temp.dat_first_order FROM (
    SELECT
        EKPO.mandant_id,
        EKPO.art_id,
        EKPO.wup_id,
        t0.min_marc,
        MIN(EKPO.dat_best_beleg) AS dat_first_order
    FROM dbp_data.besch_best_det AS EKPO
    LEFT JOIN (
        SELECT
            mandant_id,
            wup_id,
            art_id,
            MIN(dat_von) AS min_marc
        FROM dbp_data.art_wup_status_per
        GROUP BY
            art_id,
            mandant_id,
            wup_id
    ) AS t0 ON EKPO.mandant_id = t0.mandant_id AND EKPO.art_id = t0.art_id AND EKPO.wup_id = t0.wup_id
    -- AND ekpo.dat_best_beleg between marc.dat_von and marc.dat_bis

    -- WHERE ekpo.best_beleg_id=3102669317 and best_beleg_pos_id=30 --and ekpo.dat_best_beleg >= '2025-01-01'

    -- and ekpo.mandant_id=7

    GROUP BY
        EKPO.mandant_id,
        EKPO.art_id,
        EKPO.wup_id,
        t0.min_marc
    HAVING t0.min_marc > dat_first_order
) AS temp
WHERE A.mandant_id = temp.mandant_id AND A.art_id = temp.art_id AND A.wup_id = temp.wup_id AND A.dat_von = temp.min_marc;
