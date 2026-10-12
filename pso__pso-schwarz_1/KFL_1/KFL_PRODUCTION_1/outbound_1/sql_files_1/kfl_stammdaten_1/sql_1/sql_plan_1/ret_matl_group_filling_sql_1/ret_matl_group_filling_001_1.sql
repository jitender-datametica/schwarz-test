UPDATE dbp_etl.ret_wghier_1 SET
    name1 = REPLACE(ret_wghier.name1, '/1', '/O'),
    node = REPLACE(ret_wghier.node, '0261', '026O')
WHERE LENGTH(TRIM(name1)) IN (8) AND STRPOS(name1, '/1') > 0;


DROP TABLE IF EXISTS dbp_etl.wg_hierarchie_denorm_tmp_1;


DROP TABLE IF EXISTS dbp_etl.wg_hierarchie_zu_per_tmp_1;


/* Bereich */ /* Warengruppe */ /* Oberwarengruppe */ /* Abteilung */ /* Hauptwarengruppe */ CREATE TABLE IF NOT EXISTS
dbp_etl.wg_hierarchie_denorm_tmp_1 (
    mandant_id INTEGER NOT NULL,
    node_ber STRING(50) COLLATE 'und:ci',
    node_abt STRING(50) COLLATE 'und:ci',
    node_hwg STRING(50) COLLATE 'und:ci',
    node_owg STRING(50) COLLATE 'und:ci',
    node_wg STRING(50) COLLATE 'und:ci',
    ber INTEGER,
    abt_1 INTEGER,
    hwg INTEGER,
    owg INTEGER,
    wg INTEGER
);


CREATE TABLE IF NOT EXISTS dbp_etl.wg_hierarchie_zu_per_tmp_1 (
    mandant_id INTEGER NOT NULL,
    wg_hierarchie_id INTEGER NOT NULL,
    wg_hierarchie_ebene_id INTEGER NOT NULL,
    dat_von DATE NOT NULL,
    dat_bis DATE,
    arthiertyp_id INTEGER NOT NULL,
    wg_hierarchie_mutter_id INTEGER
);


INSERT INTO dbp_etl.wg_hierarchie_denorm_tmp_1 (
    mandant_id, node_ber, node_abt, node_hwg, node_owg, node_wg,
    ber, abt_1, hwg, owg, wg
)
(
    SELECT
        WG0.mandant_id,
        BER0.node AS bereich,
        ABT0.node AS abteilung,
        HWG0.node AS hauptwarengruppe,
        OWG0.node AS oberwarengruppe,
        WG0.node AS warengruppe,
        CAST(SUBSTR(BER0.name1, STRPOS(BER0.name1, '/B') + 2, 10) AS INTEGER) AS ber,
        CAST(SUBSTR(ABT0.name1, STRPOS(ABT0.name1, '/A') + 2, 10) AS INTEGER) AS abt_1,
        CAST(SUBSTR(HWG0.name1, STRPOS(HWG0.name1, '/H') + 2, 10) AS INTEGER) AS hwg,
        CAST(SUBSTR(OWG0.name1, STRPOS(OWG0.name1, '/O') + 2, 10) AS INTEGER) AS owg,
        CAST(SUBSTR(WG0.name1, STRPOS(WG0.name1, '/') + 1, 10) AS INTEGER) AS wg
    FROM dbp_etl.ret_wghier_1 AS WG0
    INNER JOIN dbp_etl.ret_wghier_1 AS OWG0
        ON
            OWG0.node_type = '0CLASS_NUM' AND WG0.parent_id = OWG0.id AND
            WG0.mandant_id = OWG0.mandant_id
    INNER JOIN dbp_etl.ret_wghier_1 AS HWG0
        ON
            HWG0.node_type = '0CLASS_NUM' AND OWG0.parent_id = HWG0.id AND
            OWG0.mandant_id = HWG0.mandant_id
    INNER JOIN dbp_etl.ret_wghier_1 AS ABT0
        ON
            ABT0.node_type = '0CLASS_NUM' AND HWG0.parent_id = ABT0.id AND
            HWG0.mandant_id = ABT0.mandant_id
    INNER JOIN dbp_etl.ret_wghier_1 AS BER0
        ON
            BER0.node_type = '0CLASS_NUM' AND ABT0.parent_id = BER0.id AND
            ABT0.mandant_id = BER0.mandant_id
    WHERE WG0.node_type = '0MATL_GROUP'
);


-- Ebene Warengruppe
INSERT INTO dbp_etl.wg_hierarchie_zu_per_tmp_1 (
    mandant_id, wg_hierarchie_id,
    wg_hierarchie_ebene_id, dat_von, dat_bis, arthiertyp_id, wg_hierarchie_mutter_id
)
(
    SELECT
        mandant_id,
        wg AS wg_hierarchie_id,
        5 AS wg_hierarchie_ebene_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        10 AS arthiertyp_id,
        CAST(ROUND(CAST(LPAD(CAST(owg AS STRING), 4, '100') AS BIGNUMERIC), 0) AS INTEGER) AS wg_hierarchie_mutter_id
    FROM dbp_etl.wg_hierarchie_denorm_tmp_1
    GROUP BY
        mandant_id,
        wg_hierarchie_id,
        arthiertyp_id,
        wg_hierarchie_mutter_id,
        wg_hierarchie_ebene_id,
        dat_von,
        dat_bis
);


-- fuenfstufige SAP WG Hierarchie
-- Ebene Oberwarengruppe
INSERT INTO dbp_etl.wg_hierarchie_zu_per_tmp_1
(mandant_id, wg_hierarchie_id, wg_hierarchie_ebene_id, dat_von, dat_bis, arthiertyp_id, wg_hierarchie_mutter_id)
(
    SELECT
        mandant_id,
        CAST(ROUND(CAST(LPAD(CAST(owg AS STRING), 4, '100') AS BIGNUMERIC), 0) AS INTEGER) AS wg_hierarchie_mutter_id,
        4 AS wg_hierarchie_ebene_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        10 AS arthiertyp_id,
        hwg AS wg_hierarchie_mutter_id6
    FROM dbp_etl.wg_hierarchie_denorm_tmp_1
    GROUP BY
        mandant_id,
        wg_hierarchie_mutter_id,
        arthiertyp_id,
        wg_hierarchie_mutter_id6,
        wg_hierarchie_ebene_id,
        dat_von,
        dat_bis
);


-- fuenfstufige SAP WG Hierarchie
-- Ebene Hauptwarengruppe
INSERT INTO dbp_etl.wg_hierarchie_zu_per_tmp_1
(mandant_id, wg_hierarchie_id, wg_hierarchie_ebene_id, dat_von, dat_bis, arthiertyp_id, wg_hierarchie_mutter_id)
(
    SELECT
        mandant_id,
        hwg AS wg_hierarchie_id,
        3 AS wg_hierarchie_ebene_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        10 AS arthiertyp_id,
        abt_1 AS wg_hierarchie_mutter_id
    FROM dbp_etl.wg_hierarchie_denorm_tmp_1
    GROUP BY
        mandant_id,
        wg_hierarchie_id,
        arthiertyp_id,
        wg_hierarchie_mutter_id,
        wg_hierarchie_ebene_id,
        dat_von,
        dat_bis
);


-- Ebene Abteilung
-- fuenfstufige SAP WG Hierarchie
INSERT INTO dbp_etl.wg_hierarchie_zu_per_tmp_1 (
    mandant_id,
    wg_hierarchie_id, wg_hierarchie_ebene_id, dat_von, dat_bis, arthiertyp_id, wg_hierarchie_mutter_id
)
(
    SELECT
        mandant_id,
        abt_1 AS wg_hierarchie_id,
        2 AS wg_hierarchie_ebene_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        10 AS arthiertyp_id,
        ber AS wg_hierarchie_mutter_id
    FROM dbp_etl.wg_hierarchie_denorm_tmp_1
    GROUP BY
        mandant_id,
        wg_hierarchie_id,
        arthiertyp_id,
        wg_hierarchie_mutter_id,
        wg_hierarchie_ebene_id,
        dat_von,
        dat_bis
);


-- Ebene Bereich
-- Initialisierung Elternelement bei Rootelementen
-- fuenfstufige SAP WG Hierarchie
INSERT INTO
dbp_etl.wg_hierarchie_zu_per_tmp_1 (
    mandant_id, wg_hierarchie_id, wg_hierarchie_ebene_id, dat_von, dat_bis,
    arthiertyp_id, wg_hierarchie_mutter_id
)
(
    SELECT
        mandant_id,
        ber AS wg_hierarchie_id,
        1 AS wg_hierarchie_ebene_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        10 AS arthiertyp_id,
        ber AS wg_hierarchie_mutter_id
    FROM dbp_etl.wg_hierarchie_denorm_tmp_1
    GROUP BY
        mandant_id,
        wg_hierarchie_id,
        arthiertyp_id,
        wg_hierarchie_mutter_id,
        wg_hierarchie_ebene_id,
        dat_von,
        dat_bis
);


-- Initialisierung Elternelement bei Rootelementen
-- Ebene Abteilung
-- zweistufige SAP WG Hierarchie
INSERT INTO
dbp_etl.wg_hierarchie_zu_per_tmp_1 (
    mandant_id, wg_hierarchie_id, wg_hierarchie_ebene_id, dat_von, dat_bis,
    arthiertyp_id, wg_hierarchie_mutter_id
)
(
    SELECT
        mandant_id,
        abt_1 AS wg_hierarchie_id,
        2 AS wg_hierarchie_ebene_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        6 AS arthiertyp_id,
        abt_1 AS wg_hierarchie_mutter_id
    FROM dbp_etl.wg_hierarchie_denorm_tmp_1
    GROUP BY
        mandant_id,
        wg_hierarchie_id,
        arthiertyp_id,
        wg_hierarchie_mutter_id,
        wg_hierarchie_ebene_id,
        dat_von,
        dat_bis
);


-- zweistufige SAP WG Hierarchie
-- Ebene Warengruppe
-- Warengruppe
-- Abteilung
INSERT INTO dbp_etl.wg_hierarchie_zu_per_tmp_1 (
    mandant_id, wg_hierarchie_id, wg_hierarchie_ebene_id, dat_von, dat_bis, arthiertyp_id,
    wg_hierarchie_mutter_id
)
(
    SELECT
        mandant_id,
        wg AS wg_hierarchie_id,
        5 AS wg_hierarchie_ebene_id,
        PARSE_DATE('%F', '1900-01-01') AS dat_von,
        PARSE_DATE('%F', '9999-12-31') AS dat_bis,
        6 AS arthiertyp_id,
        abt_1 AS wg_hierarchie_mutter_id
    FROM dbp_etl.wg_hierarchie_denorm_tmp_1
    GROUP BY
        mandant_id,
        wg_hierarchie_id,
        arthiertyp_id,
        wg_hierarchie_mutter_id,
        wg_hierarchie_ebene_id,
        dat_von,
        dat_bis
);


DELETE FROM dbp_data.wg_hierarchie_zu_per_1
WHERE mandant_id IN (
    SELECT mandant_id
    FROM dbp_etl.wg_hierarchie_zu_per_tmp_1 AS WG
    GROUP BY mandant_id
) AND arthiertyp_id IN (6, 10
) AND wg_hierarchie_id >= 0;


INSERT INTO dbp_data.wg_hierarchie_zu_per_1 (
    mandant_id, arthiertyp_id, wg_hierarchie_ebene_id,
    wg_hierarchie_id, wg_hierarchie_mutter_id, dat_von, dat_bis
)
(SELECT
    mandant_id,
    arthiertyp_id,
    wg_hierarchie_ebene_id,
    wg_hierarchie_id,
    wg_hierarchie_mutter_id,
    dat_von,
    dat_bis
FROM dbp_etl.wg_hierarchie_zu_per_tmp_1);
