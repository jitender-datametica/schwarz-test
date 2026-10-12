CREATE OR REPLACE TEMPORARY TABLE _art_list_wup_zu_per AS
SELECT
    A.art_id,
    A.wup_id,
    A.nb_id,
    A.dat_von,
    A.mandant_id,
    A.list_quelle_id,
    A.struktur_art_id,
    A.dat_bis,
    A.baustein_id,
    A.list_sap_id,
    A.list_komponente_fg,
    A.td_update,
    A.td_insert
FROM dbp_data.art_list_wup_zu_per_1 AS A
INNER JOIN dbp_data.art_wg_zu_per_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND B.arthiertyp_id
        = 2 AND B.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.wup_1 AS C ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = 1
    AND B.wg_id IN (
        SELECT wg_id
        FROM dbp_data.wg_filter_zu_1
        WHERE wg_filter_id = 11
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND TRIM(A.list_quelle_id) IN ('1', '3', '7', 'C')
    AND CAST(FLOOR(A.art_id / 100) AS INTEGER) = A.struktur_art_id
    AND A.nb_id = 0
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin");


CREATE OR REPLACE TEMPORARY TABLE _fall1 AS
SELECT B.art_matching_id
FROM dbp_data.art_gp_zu_per_1 AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
WHERE
    A.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND A.herst_id > -2
    AND B.status_1 = 'G'
GROUP BY B.art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _fall1_update_sst AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT sm_id) AS anz,
    MIN(sm_id) AS sm_id
FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.art_id,
        MIN(D.sm_id) AS sm_id
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_fall1` AS B ON A.art_matching_id = B.art_matching_id
    INNER JOIN `_art_list_wup_zu_per` AS C
        ON
            A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND TRIM(C.list_quelle_id
            ) = '3'
    INNER JOIN dbp_etl.baustein_tupel_region_zu AS D
        ON
            C.baustein_id = D.baustein_id AND A.mandant_id = D.mandant_id
    WHERE D.sm_id IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.art_id
) AS x
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _x1_fall1 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    B.art_id
FROM `_fall1_update_sst` AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.art_matching_id = B.art_matching_id
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    B.art_id;


CREATE OR REPLACE TEMPORARY TABLE _x2_fall1 AS
SELECT
    A.mandant_id,
    B.art_id,
    A.sm_id
FROM `_fall1_update_sst` AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.art_matching_id = B.art_matching_id
GROUP BY
    A.mandant_id,
    B.art_id,
    A.sm_id;


UPDATE dbp_msi_data.kl_listung_1 SET
    erweiterung_fg = 0,
    reduktion_fg = 0 FROM (
    SELECT
        mandant_id,
        art_id
    FROM `_x1_fall1`
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche_1
    WHERE akt_wo = 1
);


UPDATE dbp_msi_data.kl_listung_1 SET
    erweiterung_fg = 1
FROM `_x2_fall1` AS b
WHERE
    kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.sm_id_selected < b.sm_id AND
    kl_listung.listung_art = 'Listung erweitern' AND kl_listung.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    );


UPDATE dbp_msi_data.kl_listung_1 SET
    reduktion_fg = 1
FROM `_x2_fall1` AS b
WHERE
    kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.sm_id_selected > b.sm_id AND
    kl_listung.listung_art = 'Listung reduzieren' AND kl_listung.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _fall2 AS
SELECT B.art_matching_id
FROM dbp_data.art_gp_zu_per_1 AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
INNER JOIN (SELECT
    mandant_id,
    art_matching_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        umrech_faktor,
        COUNT(*) AS anzahl
    FROM dbp_etl.art_matching_nielsen_per_1
    WHERE status_1 = 'G'
    GROUP BY
        mandant_id,
        art_matching_id,
        umrech_faktor
) AS x
GROUP BY
    mandant_id,
    art_matching_id
HAVING MAX(anzahl) = 1) AS c ON B.mandant_id = c.mandant_id AND B.art_matching_id = c.art_matching_id
WHERE
    A.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND B.status_1 = 'G'
GROUP BY B.art_matching_id
HAVING MAX(A.herst_id) = -2;


CREATE OR REPLACE TEMPORARY TABLE _fall2_update_sst AS
SELECT
    mandant_id,
    art_matching_id,
    COUNT(DISTINCT sm_id) AS anz,
    MIN(sm_id) AS sm_id
FROM (
    SELECT
        A.mandant_id,
        A.art_matching_id,
        A.art_id,
        MIN(C.sm_id) AS sm_id
    FROM dbp_etl.art_matching_nielsen_per_1 AS A
    INNER JOIN `_fall2` AS B ON A.art_matching_id = B.art_matching_id
    INNER JOIN dbp_etl_process.art_sm_vw_zu_per_1 AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id

    WHERE
        C.mandant_id = 1
        AND CURRENT_DATE("Europe/Berlin") BETWEEN C.dat_von AND C.dat_bis
    GROUP BY
        A.mandant_id,
        A.art_matching_id,
        A.art_id
) AS x
GROUP BY
    mandant_id,
    art_matching_id;


CREATE OR REPLACE TEMPORARY TABLE _x1_fall2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    B.art_id
FROM `_fall2_update_sst` AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.art_matching_id = B.art_matching_id
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    B.art_id;


CREATE OR REPLACE TEMPORARY TABLE _x2_fall2 AS
SELECT
    A.mandant_id,
    B.art_id,
    A.sm_id
FROM `_fall2_update_sst` AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.art_matching_id = B.art_matching_id
GROUP BY
    A.mandant_id,
    B.art_id,
    A.sm_id;


UPDATE dbp_msi_data.kl_listung_1 SET
    erweiterung_fg = 0,
    reduktion_fg = 0 FROM (
    SELECT
        mandant_id,
        art_id
    FROM `_x1_fall2`
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche_1
    WHERE akt_wo = 1
);


UPDATE dbp_msi_data.kl_listung_1 SET
    erweiterung_fg = 1
FROM `_x2_fall2` AS b
WHERE
    kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.sm_id_selected < CAST(b.sm_id AS FLOAT64)
    AND kl_listung.listung_art = 'Listung erweitern' AND kl_listung.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    );


UPDATE dbp_msi_data.kl_listung_1 SET
    reduktion_fg = 1
FROM `_x2_fall2` AS b
WHERE
    kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.sm_id_selected > CAST(b.sm_id AS FLOAT64)
    AND kl_listung.listung_art = 'Listung reduzieren' AND kl_listung.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _fall3 AS
SELECT B.art_matching_id
FROM dbp_data.art_gp_zu_per_1 AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
INNER JOIN (SELECT
    mandant_id,
    art_matching_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        umrech_faktor,
        COUNT(*) AS anzahl
    FROM dbp_etl.art_matching_nielsen_per_1
    WHERE status_1 = 'G'
    GROUP BY
        mandant_id,
        art_matching_id,
        umrech_faktor
) AS x
GROUP BY
    mandant_id,
    art_matching_id
HAVING MAX(anzahl) > 1) AS c ON B.mandant_id = c.mandant_id AND B.art_matching_id = c.art_matching_id
WHERE
    A.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND B.status_1 = 'G'
GROUP BY B.art_matching_id
HAVING MAX(A.herst_id) = -2;


CREATE OR REPLACE TEMPORARY TABLE _fall3_upd_sst1 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    C.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall3` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
INNER JOIN dbp_data.art_wg_zu_per_1 AS D
    ON
        A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.sm_wup_wg_zu_per_1 AS E
    ON
        A.mandant_id = E.mandant_id AND D.wg_id = E.wg_id AND C.wup_id
        = E.wup_id
INNER JOIN dbp_data.wup_1 AS F
    ON
        A.mandant_id = F.mandant_id AND E.wup_id = F.wup_id AND F.dat_bis =
        DATE '9999-12-31'
WHERE
    A.mandant_id = 1
    AND E.spr_id = 22
    AND E.arthiertyp_id = 2
    AND CURRENT_DATE("Europe/Berlin") BETWEEN E.dat_von AND E.dat_bis
    AND E.sm_id BETWEEN 1 AND 5
    AND F.nb_id = 0
    AND F.dat_von <= CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    C.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_upd_sst2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    E.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall3` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN dbp_data.art_wg_zu_per_1 AS D
    ON
        A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.sm_wup_wg_zu_per_1 AS E ON A.mandant_id = E.mandant_id AND D.wg_id = E.wg_id
INNER JOIN dbp_data.wup_1 AS F
    ON
        A.mandant_id = F.mandant_id AND E.wup_id = F.wup_id AND F.dat_bis =
        DATE '9999-12-31'
WHERE
    A.mandant_id = 1
    AND E.spr_id = 22
    AND E.arthiertyp_id = 2
    AND CURRENT_DATE("Europe/Berlin") BETWEEN E.dat_von AND E.dat_bis
    AND E.sm_id BETWEEN 1 AND 5
    AND F.nb_id = 0
    AND F.dat_von <= CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    E.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_ist_listung AS
SELECT
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id
FROM `_fall3_upd_sst1`
GROUP BY
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_soll_listung AS
SELECT
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id
FROM `_fall3_upd_sst2`
GROUP BY
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall3_update_sst AS
SELECT
    a.mandant_id,
    a.art_matching_id,
    MIN(a.sm_id) AS sm_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        sm_id,
        COUNT(DISTINCT wup_id) AS anz_ist
    FROM `_fall3_ist_listung`
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        sm_id,
        COUNT(DISTINCT wup_id) AS anz_soll
    FROM `_fall3_soll_listung`
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
) AS b
    ON
        a.mandant_id = b.mandant_id AND a.art_matching_id = b.art_matching_id AND a.sm_id = b.sm_id AND a.anz_ist
        = b.anz_soll
GROUP BY
    a.mandant_id,
    a.art_matching_id;


INSERT INTO `_fall3_update_sst`
(
    SELECT
        mandant_id,
        art_matching_id,
        CAST(NULL AS INTEGER) AS sm_id
    FROM `_fall3_ist_listung`
    WHERE
        art_matching_id NOT IN (
            SELECT art_matching_id
            FROM `_fall3_update_sst`
        )
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
);


CREATE OR REPLACE TEMPORARY TABLE _x1_fall3 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    B.art_id
FROM `_fall3_update_sst` AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.art_matching_id = B.art_matching_id
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    B.art_id;


CREATE OR REPLACE TEMPORARY TABLE _x2_fall3 AS
SELECT
    A.mandant_id,
    B.art_id,
    A.sm_id
FROM `_fall3_update_sst` AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.art_matching_id = B.art_matching_id
GROUP BY
    A.mandant_id,
    B.art_id,
    A.sm_id;


UPDATE dbp_msi_data.kl_listung_1 SET
    erweiterung_fg = 0,
    reduktion_fg = 0 FROM (
    SELECT
        mandant_id,
        art_id
    FROM `_x1_fall3`
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche_1
    WHERE akt_wo = 1
);


UPDATE dbp_msi_data.kl_listung_1 SET
    erweiterung_fg = 1
FROM `_x2_fall3` AS b
WHERE
    kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.sm_id_selected < b.sm_id AND
    kl_listung.listung_art = 'Listung erweitern' AND kl_listung.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    );


UPDATE dbp_msi_data.kl_listung_1 SET
    reduktion_fg = 1
FROM `_x2_fall3` AS b
WHERE
    kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.sm_id_selected > b.sm_id AND
    kl_listung.listung_art = 'Listung reduzieren' AND kl_listung.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    );


CREATE OR REPLACE TEMPORARY TABLE _fall4 AS
SELECT art_matching_id
FROM dbp_etl.art_matching_nielsen_per_1 AS B
WHERE status_1 = 'T';


CREATE OR REPLACE TEMPORARY TABLE _fall4_upd_sst1 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    C.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall4` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN `_art_list_wup_zu_per` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
INNER JOIN dbp_data.art_wg_zu_per_1 AS D
    ON
        A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.sm_wup_wg_zu_per_1 AS E
    ON
        A.mandant_id = E.mandant_id AND D.wg_id = E.wg_id AND C.wup_id
        = E.wup_id
INNER JOIN dbp_data.wup_1 AS F
    ON
        A.mandant_id = F.mandant_id AND E.wup_id = F.wup_id AND F.dat_bis =
        DATE '9999-12-31'
WHERE
    A.mandant_id = 1
    AND E.spr_id = 22
    AND E.arthiertyp_id = 2
    AND CURRENT_DATE("Europe/Berlin") BETWEEN E.dat_von AND E.dat_bis
    AND E.sm_id BETWEEN 1 AND 5
    AND F.nb_id = 0
    AND F.dat_von <= CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    C.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_upd_sst2 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    E.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id
FROM dbp_etl.art_matching_nielsen_per_1 AS A
INNER JOIN `_fall4` AS B ON A.art_matching_id = B.art_matching_id
INNER JOIN dbp_data.art_wg_zu_per_1 AS D
    ON
        A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND D.arthiertyp_id
        = 2 AND D.dat_bis = DATE '9999-12-31'
INNER JOIN dbp_data.sm_wup_wg_zu_per_1 AS E ON A.mandant_id = E.mandant_id AND D.wg_id = E.wg_id
INNER JOIN dbp_data.wup_1 AS F
    ON
        A.mandant_id = F.mandant_id AND E.wup_id = F.wup_id AND F.dat_bis =
        DATE '9999-12-31'
WHERE
    A.mandant_id = 1
    AND E.spr_id = 22
    AND E.arthiertyp_id = 2
    AND CURRENT_DATE("Europe/Berlin") BETWEEN E.dat_von AND E.dat_bis
    AND E.sm_id BETWEEN 1 AND 5
    AND F.nb_id = 0
    AND F.dat_von <= CURRENT_DATE("Europe/Berlin")
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    A.art_id,
    E.wg_id,
    E.wup_id,
    F.kreistyp_gruppe_id,
    E.sm_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_ist_listung AS
SELECT
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id
FROM `_fall4_upd_sst1`
GROUP BY
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_soll_listung AS
SELECT
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id
FROM `_fall4_upd_sst2`
GROUP BY
    mandant_id,
    art_matching_id,
    wg_id,
    sm_id,
    wup_id;


CREATE OR REPLACE TEMPORARY TABLE _fall4_update_sst AS
SELECT
    a.mandant_id,
    a.art_matching_id,
    MIN(a.sm_id) AS sm_id
FROM (
    SELECT
        mandant_id,
        art_matching_id,
        sm_id,
        COUNT(DISTINCT wup_id) AS anz_ist
    FROM `_fall4_ist_listung`
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
) AS a
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        sm_id,
        COUNT(DISTINCT wup_id) AS anz_soll
    FROM `_fall4_soll_listung`
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
) AS b
    ON
        a.mandant_id = b.mandant_id AND a.art_matching_id = b.art_matching_id AND a.sm_id = b.sm_id AND a.anz_ist
        = b.anz_soll
GROUP BY
    a.mandant_id,
    a.art_matching_id;


INSERT INTO `_fall4_update_sst`
(
    SELECT
        mandant_id,
        art_matching_id,
        CAST(NULL AS INTEGER) AS sm_id
    FROM `_fall4_ist_listung`
    WHERE
        art_matching_id NOT IN (
            SELECT art_matching_id
            FROM `_fall4_update_sst`
        )
    GROUP BY
        mandant_id,
        art_matching_id,
        sm_id
);


CREATE OR REPLACE TEMPORARY TABLE _x1_fall4 AS
SELECT
    A.mandant_id,
    A.art_matching_id,
    B.art_id
FROM `_fall4_update_sst` AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.art_matching_id = B.art_matching_id
GROUP BY
    A.mandant_id,
    A.art_matching_id,
    B.art_id;


CREATE OR REPLACE TEMPORARY TABLE _x2_fall4 AS
SELECT
    A.mandant_id,
    B.art_id,
    MIN(A.sm_id) AS sm_id
FROM `_fall4_update_sst` AS A
INNER JOIN dbp_etl.art_matching_nielsen_per_1 AS B ON A.art_matching_id = B.art_matching_id
GROUP BY
    A.mandant_id,
    B.art_id;


UPDATE dbp_msi_data.kl_listung_1 SET
    erweiterung_fg = 0,
    reduktion_fg = 0 FROM (
    SELECT
        mandant_id,
        art_id
    FROM `_x1_fall4`
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.kjwo_update IN (
    SELECT kjwo
    FROM dbp_data.woche_1
    WHERE akt_wo = 1
);


UPDATE dbp_msi_data.kl_listung_1 SET
    erweiterung_fg = 1
FROM `_x2_fall4` AS b
WHERE
    kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.sm_id_selected < b.sm_id AND
    kl_listung.listung_art = 'Listung erweitern' AND kl_listung.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    );


UPDATE dbp_msi_data.kl_listung_1 SET
    reduktion_fg = 1
FROM `_x2_fall4` AS b
WHERE
    kl_listung.mandant_id = b.mandant_id AND kl_listung.art_id = b.art_id AND kl_listung.sm_id_selected > b.sm_id AND
    kl_listung.listung_art = 'Listung reduzieren' AND kl_listung.kjwo_update IN (
        SELECT kjwo
        FROM dbp_data.woche_1
        WHERE akt_wo = 1
    );
