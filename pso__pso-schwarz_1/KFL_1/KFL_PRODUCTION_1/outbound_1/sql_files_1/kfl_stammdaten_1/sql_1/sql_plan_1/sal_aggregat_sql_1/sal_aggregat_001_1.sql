CREATE TEMPORARY TABLE IF NOT EXISTS _art_wup_zu_per AS
SELECT
    mandant_id,
    art_id,
    wup_id,
    nb_id,
    dat_von,
    dat_bis,
    listung_id
FROM dbp_data.art_wup_zu_per_1
WHERE
    listung_id = 1
    AND dat_bis >= DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 3 DAY);


CREATE TEMPORARY TABLE IF NOT EXISTS _art_wg_zu_per AS
SELECT
    art_id,
    mandant_id,
    wg_id
FROM dbp_data.art_wg_zu_per_1
WHERE
    arthiertyp_id = 2
    AND dat_bis = PARSE_DATE('%F', '9999-12-31');


CREATE TEMPORARY TABLE IF NOT EXISTS _final_tmp AS
SELECT
    V01.mandant_id,
    V01.art_id,
    V04.wg_id,
    V01.wup_id,
    V01.nb_id,
    V02.kjwo,
    V03.kreistyp_gruppe_id,
    MAX(V01.listung_id) AS listung_id
FROM `_art_wup_zu_per` AS V01
INNER JOIN dbp_data.tag_1 AS V02 ON V02.dat BETWEEN V01.dat_von AND V01.dat_bis
INNER JOIN dbp_data.wup_1 AS V03
    ON
        V01.wup_id = V03.wup_id AND V01.nb_id = V03.nb_id AND V01.mandant_id
        = V03.mandant_id
INNER JOIN
    `_art_wg_zu_per` AS V04
    ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id
WHERE
    V02.dat BETWEEN DATE_SUB(
        CURRENT_DATE("Europe/Berlin"), INTERVAL 3 DAY
    ) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
GROUP BY
    V01.mandant_id,
    V01.art_id,
    V04.wg_id,
    V01.wup_id,
    V01.nb_id,
    V02.kjwo,
    V03.kreistyp_gruppe_id;


DELETE FROM dbp_data.art_wup_listung_kjwo_1
WHERE (
    mandant_id, art_id, wup_id, kjwo) IN (
    SELECT (mandant_id, art_id, wup_id, kjwo)
    FROM `_final_tmp`
);


INSERT INTO dbp_data.art_wup_listung_kjwo_1 (
    mandant_id, art_id, wg_id, wup_id, nb_id, kjwo,
    kreistyp_gruppe_id, listung_id
)
(
    SELECT *
    FROM `_final_tmp`
);


TRUNCATE TABLE dbp_data.art_kreistyp_gruppe_wup_zu_1;


INSERT INTO dbp_data.art_kreistyp_gruppe_wup_zu_1 (
    mandant_id, wup_id, nb_id, art_id, kreistyp_gruppe_id
)
(
    SELECT
        AWZP.mandant_id,
        AWZP.wup_id,
        AWZP.nb_id,
        AWZP.art_id,
        W.kreistyp_gruppe_id
    FROM dbp_data.art_wup_zu_per_1 AS AWZP
    INNER JOIN dbp_data.wup_1 AS W
        ON
            AWZP.mandant_id = W.mandant_id
            AND AWZP.nb_id = W.nb_id
            AND AWZP.wup_id
            = W.wup_id
    WHERE AWZP.dat_bis = PARSE_DATE('%F', '9999-12-31')
);


CREATE TEMPORARY TABLE IF NOT EXISTS _art_list_wup_zu_per AS
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
        = 2 AND B.dat_bis = PARSE_DATE('%F', '9999-12-31')
INNER JOIN
    dbp_data.wup_1 AS C
    ON A.mandant_id = C.mandant_id AND A.wup_id = C.wup_id
WHERE
    A.mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von AND A.dat_bis
    AND A.list_quelle_id IN ('1', '3', '7', 'C')
    AND A.art_id / 100 = A.struktur_art_id
    AND A.nb_id = 0
    AND C.nb_id = 0
    AND C.dat_eroeffnung <= CURRENT_DATE("Europe/Berlin");


CREATE TEMPORARY TABLE IF NOT EXISTS _step0 AS
SELECT
    mandant_id,
    art_id
FROM dbp_data.sal_int_1
GROUP BY
    mandant_id,
    art_id;


CREATE TEMPORARY TABLE IF NOT EXISTS _step1 AS
SELECT
    art_id,
    mandant_id,
    CASE
        WHEN MIN(sm_id) <> 0
            THEN 1
        ELSE 0
    END AS listung_min_1_sst_durchg_v1
FROM (
    SELECT
        LSL.art_id,
        LSL.sm_id,
        LSL.mandant_id,
        LSL.list_durchg_fg,
        LSL.anzahl_markt_soll,
        LS.sternchen_id
    FROM dbp_data.sternchen_logik_1 AS LSL
    INNER JOIN dbp_data.l_sternchen_1 AS LS
        ON
            LSL.list_durchg_fg = LS.list_durchg_fg AND LSL.bezugsweg1_fg
            = LS.bezugsweg1_fg
            AND LSL.bezugsweg4_fg = LS.bezugsweg4_fg
            AND LSL.kdis0_fg = LS.kdis0_fg
            AND LSL.kdis1_fg
            = LS.kdis1_fg AND LSL.mandant_id = LS.mandant_id
    WHERE LSL.mandant_id = 1
) AS a11
WHERE
    mandant_id = 1
    AND list_durchg_fg = 1
GROUP BY
    art_id,
    mandant_id;


CREATE TEMPORARY TABLE IF NOT EXISTS _step2 AS
SELECT
    art_id,
    mandant_id,
    CASE
        WHEN
            MAX(typ_ost_basis) <> 0
            OR MAX(typ_ost_gross) <> 0
            OR MAX(typ_sued_ost) <> 0
            OR MAX(typ_sued_west) <> 0
            OR MAX(typ_west
            ) <> 0 OR MAX(typ_nord) <> 0
            THEN 1
        ELSE 0
    END AS listung_min_1_region_durchg_v1
FROM (
    SELECT
        art_id,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'O' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_ost_basis,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'Q' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_ost_gross,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'G' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_sued_ost,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'M' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_sued_west,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'W' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_west,
        MAX(CASE
            WHEN kreistyp_gruppe_id = 'N' AND list_durchg_fg = 1
                THEN 1
            ELSE 0
        END) AS typ_nord,
        mandant_id
    FROM dbp_data.sternchen_logik_kreis_1 AS V01
    WHERE mandant_id = 1
    GROUP BY
        art_id,
        mandant_id
) AS t1_1
WHERE mandant_id = 1
GROUP BY
    art_id,
    mandant_id;


CREATE TEMPORARY TABLE IF NOT EXISTS _step3 AS
SELECT
    art_id,
    mandant_id,
    sm_id
FROM dbp_etl_process.art_sm_vw_zu_per_1 AS A
WHERE
    mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
GROUP BY
    art_id,
    mandant_id,
    sm_id;


CREATE TEMPORARY TABLE IF NOT EXISTS _step4 AS
SELECT
    A.mandant_id,
    A.art_id,
    1 AS list_region_teresa
FROM `_art_list_wup_zu_per` AS A
INNER JOIN dbp_data.wup_1 AS B
    ON
        A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND B.dat_eroeffnung
        < CURRENT_DATE("Europe/Berlin")
INNER JOIN dbp_data.woche_1 AS C ON TRUE
WHERE
    A.list_quelle_id IN ('3')
    AND A.baustein_id IN (
        SELECT baustein_id
        FROM dbp_etl.baustein_region_zu_1
    )
    AND B.nb_id = 0
GROUP BY
    A.mandant_id,
    A.art_id,
    list_region_teresa;


CREATE TEMPORARY TABLE IF NOT EXISTS _sal_upd AS
SELECT
    A.mandant_id,
    A.art_id,
    COALESCE(B.listung_min_1_sst_durchg_v1, 0) AS listung_min_1_sst_durchg_fg,
    COALESCE(CASE
        WHEN CAST(D.sm_id AS FLOAT64) > 0
            THEN 1
        ELSE 0
    END, 0) AS listung_min_1_sst_durchg_mvke_fg,
    COALESCE(C.listung_min_1_region_durchg_v1, 0)
        AS listung_min_1_region_durchg_fg,
    COALESCE(E.list_region_teresa, 0) AS listung_min_1_region_durchg_baustein_fg
FROM `_step0` AS A
LEFT JOIN `_step1` AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.art_id
LEFT JOIN `_step2` AS C ON A.mandant_id = C.mandant_id AND A.art_id = C.art_id
LEFT JOIN `_step3` AS D ON A.mandant_id = D.mandant_id AND A.art_id = D.art_id
LEFT JOIN `_step4` AS E ON A.mandant_id = E.mandant_id AND A.art_id = E.art_id;


CREATE TEMPORARY TABLE IF NOT EXISTS _sal_upd2 AS
SELECT
    A.mandant_id,
    A.art_id,
    COALESCE(b.listung_min_1_wup_fg, 0) AS listung_min_1_wup_fg
FROM `_sal_upd` AS A
LEFT JOIN (
    SELECT
        art_id,
        mandant_id,
        1 AS listung_min_1_wup_fg
    FROM dbp_data.art_list_wup_zu_per_1 AS A11
    WHERE
        CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
        AND mandant_id = 1
    GROUP BY
        art_id,
        mandant_id
) AS b ON A.mandant_id = b.mandant_id AND A.art_id = b.art_id;


UPDATE dbp_data.sal_int_1 SET
    listung_min_1_sst_durchg_fg = b.listung_min_1_sst_durchg_fg,
    listung_min_1_sst_durchg_mvke_fg = b.listung_min_1_sst_durchg_mvke_fg,
    listung_min_1_region_durchg_fg = b.listung_min_1_region_durchg_fg,
    listung_min_1_region_durchg_baustein_fg
    = b.listung_min_1_region_durchg_baustein_fg
FROM (
    SELECT
        mandant_id,
        art_id,
        MAX(listung_min_1_sst_durchg_fg) AS listung_min_1_sst_durchg_fg,
        MAX(listung_min_1_sst_durchg_mvke_fg)
            AS listung_min_1_sst_durchg_mvke_fg,
        MAX(listung_min_1_region_durchg_fg) AS listung_min_1_region_durchg_fg,
        MAX(listung_min_1_region_durchg_baustein_fg)
            AS listung_min_1_region_durchg_baustein_fg
    FROM `_sal_upd`
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE sal_int.mandant_id = b.mandant_id AND sal_int.art_id = b.art_id;


UPDATE dbp_data.sal_int_1 SET
    listung_min_1_wup_fg = b.listung_min_1_wup_fg FROM (
    SELECT
        mandant_id,
        art_id,
        MIN(listung_min_1_wup_fg) AS listung_min_1_wup_fg
    FROM `_sal_upd2`
    GROUP BY
        mandant_id,
        art_id
) AS b
WHERE sal_int.mandant_id = b.mandant_id AND sal_int.art_id = b.art_id;


-- 02.02.22, -dbay-
--
-- update for assortment tool for keeping it synchronized


CREATE OR REPLACE TEMPORARY TABLE _daily_sal_upd AS
SELECT
    A.mandant_id,
    B.matching_id,
    COALESCE(B.anzahl_markt_wochen_kombis_abverkauf_mit_listung, 0)
        AS tm_anz_abverkauf,
    COALESCE(B.anzahl_markt_wochen_kombis_listung, 0) AS tm_anz_listung,
    SUM(A.anz_wup_absatz) AS sal_anz_abverkauf,
    SUM(A.anz_wup_listung) AS sal_anz_listung
FROM dbp_data.sal_int_1 AS A
INNER JOIN (
    SELECT
        mandant_id,
        art_matching_id,
        art_id
    FROM dbp_etl.art_matching_nielsen_per_1
    GROUP BY
        mandant_id,
        art_matching_id,
        art_id
) AS c ON A.mandant_id = c.mandant_id AND A.art_id = c.art_id
INNER JOIN
    dbp_etl_process.tupel_mat_etl_1 AS B
    ON c.mandant_id = B.mandant_id AND c.art_matching_id = B.matching_id

WHERE
    A.kjwo IN (
        SELECT kjwo
        FROM dbp_data.art_nielsen_fakten_kjwo_1
        WHERE mandant_id = 1
        GROUP BY kjwo
        QUALIFY
            (
                (RANK() OVER (ORDER BY kjwo IS NULL DESC, kjwo DESC)) * -1
            ) BETWEEN -52 AND (-1)
    )
    AND A.mandant_id = 1
    AND B.a500_kjwo_update IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl_1
        WHERE mandant_id = 1
    )
GROUP BY
    A.mandant_id,
    B.matching_id,
    tm_anz_abverkauf,
    tm_anz_listung
HAVING
    tm_anz_abverkauf <> sal_anz_abverkauf OR tm_anz_listung <> sal_anz_listung;


UPDATE dbp_etl_process.tupel_mat_etl_1 SET
    anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
FROM `_daily_sal_upd` AS b
WHERE
    tupel_mat_etl.mandant_id = b.mandant_id
    AND tupel_mat_etl.matching_id = b.matching_id
    AND tupel_mat_etl.a500_kjwo_update
    IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl_1
        WHERE mandant_id = 1
    );


UPDATE dbp_msi_data.tupel_mat_quarantaene_1 SET
    anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
FROM `_daily_sal_upd` AS b
WHERE
    tupel_mat_quarantaene.mandant_id = b.mandant_id
    AND tupel_mat_quarantaene.matching_id = b.matching_id
    AND tupel_mat_quarantaene.a500_kjwo_update IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl_1
        WHERE mandant_id = 1
    );


UPDATE dbp_msi_data.tupel_mat_1 SET
    anzahl_markt_wochen_kombis_abverkauf_mit_listung = b.sal_anz_abverkauf,
    anzahl_markt_wochen_kombis_listung = b.sal_anz_listung
FROM `_daily_sal_upd` AS b
WHERE
    tupel_mat.mandant_id = b.mandant_id
    AND tupel_mat.matching_id = b.matching_id
    AND tupel_mat.a500_kjwo_update IN (
        SELECT MAX(a500_kjwo_update) AS a1581216993
        FROM dbp_etl_process.tupel_mat_etl_1
        WHERE mandant_id = 1
    );
