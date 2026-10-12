CREATE OR REPLACE TABLE dbp_etl.`_rows_mandant_${TRANSIENT_TABLE_SUFFIX}` AS
SELECT
    a.mandant_id,
    a.sap_cnt,
    b.td_cnt,
    CASE
        WHEN COALESCE(a.sap_cnt, 0) < COALESCE(b.td_cnt, 0) * 0.6
            THEN 0
        ELSE 1
    END AS update_fg
FROM (
    SELECT
        AWZ.mandant_id,
        COUNT(*) AS sap_cnt
    FROM dbp_etl.aktion_art_wup_zu AS AWZ
    INNER JOIN dbp_data.aktion AS AK
        ON
            AWZ.aktion_id = AK.aktion_id AND AWZ.mandant_id = AK.mandant_id
            AND AWZ.bewart_id = AK.bewart_id
    WHERE AK.dat_von > CURRENT_DATE("Europe/Berlin")
    GROUP BY AWZ.mandant_id
) AS a
FULL JOIN (
    SELECT
        AWZ0.mandant_id,
        COUNT(*) AS td_cnt
    FROM dbp_data.aktion_art_wup_zu AS AWZ0
    INNER JOIN dbp_data.aktion AS AK0
        ON
            AWZ0.aktion_id = AK0.aktion_id AND AWZ0.mandant_id = AK0.mandant_id
            AND AWZ0.bewart_id = AK0.bewart_id
    WHERE
        AK0.dat_von > CURRENT_DATE("Europe/Berlin")
        AND AWZ0.mandant_id <> 1
    GROUP BY AWZ0.mandant_id
) AS b ON a.mandant_id = b.mandant_id;


--[OK] statement is translated correctly (syntax and type checks are fine)


CREATE OR REPLACE TABLE dbp_etl.aktion_art_wup_zu_tmp (
    mandant_id INTEGER NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    art_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    vk_aktion_brutto NUMERIC(29, 2) NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
    grund_sperrung STRING(1) COLLATE 'und:ci',
    dat_sperrung DATE,
    aktion_thema_id STRING(4) COLLATE 'und:ci' NOT NULL,
    vk_vor_aktion_brutto NUMERIC(29, 2),
    dat_preisaktiviert DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
    art_fg INTEGER NOT NULL,
    geloescht_sap_fg INTEGER,
    dat_geloescht_sap DATE,
    vor_aktion_wrg_id STRING(3) COLLATE 'und:ci'
);


--[OK] statement is translated correctly (syntax and type checks are fine)


DROP TABLE IF EXISTS dbp_etl.aktion_art_wup_zu_tmp_del;


CREATE TABLE IF NOT EXISTS dbp_etl.aktion_art_wup_zu_tmp_del (
    mandant_id INTEGER NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    art_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    vk_aktion_brutto NUMERIC(29, 2) NOT NULL,
    bezugsweg_id INTEGER NOT NULL,
    wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
    grund_sperrung STRING(1) COLLATE 'und:ci',
    dat_sperrung DATE,
    aktion_thema_id STRING(4) COLLATE 'und:ci' NOT NULL,
    vk_vor_aktion_brutto NUMERIC(29, 2),
    dat_preisaktiviert DATE DEFAULT CAST('1900-01-01' AS DATE) NOT NULL,
    geloescht_sap_fg INTEGER,
    dat_geloescht_sap DATE,
    vor_aktion_wrg_id STRING(3) COLLATE 'und:ci'
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_etl.aktion_art_wup_zu_tmp
(
    SELECT
        AWZ.mandant_id,
        AWZ.aktion_id,
        AWZ.art_id,
        AWZ.bewart_id,
        AWZ.wup_id,
        AWZ.nb_id,
        AWZ.vk_aktion_brutto,
        AWZ.bezugsweg_id,
        AWZ.wrg_id,
        AWZ.grund_sperrung,
        AWZ.dat_sperrung,
        AWZ.aktion_thema_id,
        AWZ.vk_vor_aktion_brutto,
        AWZ.dat_preisaktiviert,
        CASE
            WHEN AWZ_CUR.art_id IS NULL
                THEN 0
            ELSE 1
        END AS art_fg,
        AWZ_CUR.geloescht_sap_fg,
        AWZ_CUR.dat_geloescht_sap,
        AWZ.vor_aktion_wrg_id
    FROM dbp_etl.aktion_art_wup_zu AS AWZ
    INNER JOIN dbp_data.aktion AS AK
        ON
            AWZ.aktion_id = AK.aktion_id AND AWZ.mandant_id = AK.mandant_id AND
            AWZ.bewart_id = AK.bewart_id
    INNER JOIN dbp_etl.`_rows_mandant_${TRANSIENT_TABLE_SUFFIX}` AS R ON AWZ.mandant_id = R.mandant_id

    LEFT JOIN dbp_data.aktion_art_wup_zu AS AWZ_CUR
        ON
            AWZ.aktion_id = AWZ_CUR.aktion_id AND AWZ.mandant_id
            = AWZ_CUR.mandant_id AND AWZ.bewart_id = AWZ_CUR.bewart_id AND AWZ.art_id = AWZ_CUR.art_id AND AWZ.wup_id =
            AWZ_CUR.wup_id AND AWZ.nb_id = AWZ_CUR.nb_id
    WHERE
        AK.dat_von > CURRENT_DATE("Europe/Berlin")
        AND R.update_fg = 1
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_etl.aktion_art_wup_zu_tmp_del
(
    SELECT
        AWZ_CUR.mandant_id,
        AWZ_CUR.aktion_id,
        AWZ_CUR.art_id,
        AWZ_CUR.bewart_id,
        AWZ_CUR.wup_id,
        AWZ_CUR.nb_id,
        AWZ_CUR.vk_aktion_brutto,
        AWZ_CUR.bezugsweg_id,
        AWZ_CUR.wrg_id,
        AWZ_CUR.grund_sperrung,
        AWZ_CUR.dat_sperrung,
        AWZ_CUR.aktion_thema_id,
        AWZ_CUR.vk_vor_aktion_brutto,
        AWZ_CUR.dat_preisaktiviert,
        AWZ_CUR.geloescht_sap_fg,
        AWZ_CUR.dat_geloescht_sap,
        AWZ_CUR.vor_aktion_wrg_id
    FROM dbp_data.aktion_art_wup_zu AS AWZ_CUR
    INNER JOIN dbp_data.aktion AS AK
        ON
            AWZ_CUR.aktion_id = AK.aktion_id AND AWZ_CUR.mandant_id = AK.mandant_id
            AND AWZ_CUR.bewart_id = AK.bewart_id
    INNER JOIN dbp_etl.`_rows_mandant_${TRANSIENT_TABLE_SUFFIX}` AS R ON AWZ_CUR.mandant_id = R.mandant_id

    LEFT JOIN dbp_etl.aktion_art_wup_zu AS AWZ
        ON
            AWZ_CUR.aktion_id = AWZ.aktion_id AND AWZ_CUR.mandant_id
            = AWZ.mandant_id AND AWZ_CUR.bewart_id = AWZ.bewart_id AND AWZ_CUR.art_id = AWZ.art_id AND AWZ_CUR.wup_id = AWZ.wup_id AND AWZ_CUR.nb_id = AWZ.nb_id
    WHERE
        AK.dat_von > CURRENT_DATE("Europe/Berlin")
        AND R.update_fg = 1
        AND AWZ.art_id IS NULL
);


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO dbp_data.aktion_art_wup_zu (
    mandant_id, aktion_id, art_id, bewart_id, wup_id, nb_id,
    vk_aktion_brutto, wrg_id, bezugsweg_id, grund_sperrung, dat_sperrung, aktion_thema_id, vk_vor_aktion_brutto,
    vor_aktion_wrg_id, dat_preisaktiviert, geloescht_sap_fg, dat_geloescht_sap, td_update, td_insert
)
(SELECT
    mandant_id,
    aktion_id,
    art_id,
    bewart_id,
    wup_id,
    nb_id,
    vk_aktion_brutto,
    wrg_id,
    bezugsweg_id,
    grund_sperrung,
    dat_sperrung,
    aktion_thema_id,
    vk_vor_aktion_brutto,
    vor_aktion_wrg_id,
    dat_preisaktiviert,
    0 AS geloescht_sap_fg,
    CAST(NULL AS DATE) AS dat_geloescht_sap,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM dbp_etl.aktion_art_wup_zu_tmp AS AWZ
WHERE art_fg = 0);


--[not OK] statement is not translated correctly-----------------------------------------------------------------


UPDATE dbp_data.aktion_art_wup_zu SET
    geloescht_sap_fg = 0,
    dat_geloescht_sap = NULL,
    grund_sperrung = aktion_art_wup_zu_tmp.grund_sperrung,
    td_update = CURRENT_TIMESTAMP()
FROM dbp_etl.aktion_art_wup_zu_tmp
WHERE
    aktion_art_wup_zu.aktion_id = aktion_art_wup_zu_tmp.aktion_id AND aktion_art_wup_zu.mandant_id =
    aktion_art_wup_zu_tmp.mandant_id AND aktion_art_wup_zu.bewart_id = aktion_art_wup_zu_tmp.bewart_id AND
    aktion_art_wup_zu.art_id = aktion_art_wup_zu_tmp.art_id AND aktion_art_wup_zu.wup_id = aktion_art_wup_zu_tmp.wup_id
    AND aktion_art_wup_zu.nb_id = aktion_art_wup_zu_tmp.nb_id AND aktion_art_wup_zu_tmp.art_fg = 1 AND
    aktion_art_wup_zu.geloescht_sap_fg = 1 AND aktion_art_wup_zu.dat_geloescht_sap IS NOT NULL;


--[not OK] statement is not translated correctly-----------------------------------------------------------------


UPDATE dbp_data.aktion_art_wup_zu SET
    geloescht_sap_fg = 1,
    dat_geloescht_sap = CURRENT_DATE("Europe/Berlin"),
    grund_sperrung = 'X',
    td_update = CURRENT_TIMESTAMP()
FROM dbp_etl.aktion_art_wup_zu_tmp_del
WHERE
    aktion_art_wup_zu.aktion_id = aktion_art_wup_zu_tmp_del.aktion_id AND aktion_art_wup_zu.mandant_id =
    aktion_art_wup_zu_tmp_del.mandant_id AND aktion_art_wup_zu.bewart_id = aktion_art_wup_zu_tmp_del.bewart_id AND
    aktion_art_wup_zu.art_id = aktion_art_wup_zu_tmp_del.art_id AND aktion_art_wup_zu.wup_id = aktion_art_wup_zu_tmp_del.wup_id AND aktion_art_wup_zu.nb_id = aktion_art_wup_zu_tmp_del.nb_id;


--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


UPDATE dbp_data.aktion_art_wup_zu SET
    grund_sperrung = CASE
        WHEN aktion_art_wup_zu.geloescht_sap_fg = 1
            THEN 'X'
        ELSE a.grund_sperrung
    END,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        AWZ.mandant_id,
        AWZ.aktion_id,
        AWZ.bewart_id,
        AWZ.art_id,
        AWZ.wup_id,
        AWZ.nb_id,
        AWZ.grund_sperrung
    FROM dbp_etl.aktion_art_wup_zu AS AWZ
    INNER JOIN dbp_data.aktion AS AK
        ON
            AWZ.aktion_id = AK.aktion_id AND AWZ.mandant_id = AK.mandant_id
            AND AWZ.bewart_id = AK.bewart_id
    WHERE AK.dat_von <= CURRENT_DATE("Europe/Berlin")
) AS a
WHERE
    aktion_art_wup_zu.aktion_id = a.aktion_id AND aktion_art_wup_zu.mandant_id = a.mandant_id AND aktion_art_wup_zu.bewart_id
    = a.bewart_id AND aktion_art_wup_zu.art_id = a.art_id AND aktion_art_wup_zu.wup_id = a.wup_id AND
    aktion_art_wup_zu.nb_id = a.nb_id;


/*******************Update vor_aktion_wrg_id *******************/


UPDATE dbp_data.aktion_art_wup_zu SET
    vor_aktion_wrg_id = aktion_art_wup_zu_tmp.vor_aktion_wrg_id,
    td_update = CURRENT_TIMESTAMP()
FROM dbp_etl.aktion_art_wup_zu_tmp
WHERE
    aktion_art_wup_zu.aktion_id = aktion_art_wup_zu_tmp.aktion_id AND aktion_art_wup_zu.mandant_id =
    aktion_art_wup_zu_tmp.mandant_id AND aktion_art_wup_zu.bewart_id = aktion_art_wup_zu_tmp.bewart_id AND
    aktion_art_wup_zu.art_id = aktion_art_wup_zu_tmp.art_id AND aktion_art_wup_zu.wup_id = aktion_art_wup_zu_tmp.wup_id
    AND aktion_art_wup_zu.nb_id = aktion_art_wup_zu_tmp.nb_id AND aktion_art_wup_zu.vor_aktion_wrg_id <>
    aktion_art_wup_zu_tmp.vor_aktion_wrg_id;
