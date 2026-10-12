UPDATE dbp_etl.marktbestand_erp_tmp SET
    wrg_id = b.default_wrg
FROM dbp_data.mandant AS b
WHERE marktbestand_erp_tmp.mandant_id = b.mandant_id;


INSERT INTO dbp_data.marktbestand_erp_zu (
    mandant_id, bestand_id, ek_netto, ek_netto_bnk, vk_netto,
    wrg_id, ek_nettonetto, einstandspreis, td_update, td_insert
)
(
    SELECT
        a.mandant_id,
        b.bestand_id + (ROW_NUMBER() OVER (PARTITION BY a.mandant_id ORDER BY NULL IS NULL, NULL)) AS bestand_id,
        a.ek_netto,
        a.ek_netto_bnk,
        a.vk_netto,
        a.wrg_id,
        a.ek_nettonetto,
        a.einstandspreis,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM (
        SELECT
            mandant_id,
            ek_netto,
            ek_netto_bnk,
            vk_netto,
            wrg_id,
            ek_nettonetto,
            einstandspreis
        FROM dbp_etl.marktbestand_erp_tmp
        WHERE (mandant_id, ek_netto, ek_netto_bnk, vk_netto, wrg_id, ek_nettonetto, einstandspreis) NOT IN (SELECT (
            mandant_id,
            ek_netto, ek_netto_bnk, vk_netto, wrg_id, ek_nettonetto, einstandspreis
        )
        FROM dbp_data.marktbestand_erp_zu)
        GROUP BY
            mandant_id,
            ek_netto,
            ek_netto_bnk,
            vk_netto,
            wrg_id,
            ek_nettonetto,
            einstandspreis
    ) AS a
    INNER JOIN (SELECT
        mandant_id,
        MAX(bestand_id) AS bestand_id
    FROM dbp_data.marktbestand_erp_zu
    GROUP BY mandant_id) AS b ON a.mandant_id = b.mandant_id
);


CREATE OR REPLACE TEMPORARY TABLE _perf AS
SELECT
    mandant_id,
    ek_netto,
    ek_netto_bnk,
    vk_netto,
    ek_nettonetto,
    einstandspreis
FROM dbp_etl.marktbestand_erp_tmp
GROUP BY
    mandant_id,
    ek_netto,
    ek_netto_bnk,
    vk_netto,
    ek_nettonetto,
    einstandspreis;


UPDATE dbp_data.marktbestand_erp SET
    relevant_fg = dt1.`_relevant_fg`,
    bestand_id = dt1.`_bestand_id`,
    bezugsweg_id = dt1.`_bezugsweg_id`,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        T1.mandant_id AS `_mandant_id`,
        T1.wup_id AS `_wup_id`,
        T1.art_id AS `_art_id`,
        T1.relevant_fg AS `_relevant_fg`,
        T1.bezugsweg_id AS `_bezugsweg_id`,
        MAX(t2.bestand_id) AS `_bestand_id`
    FROM dbp_etl.marktbestand_erp_tmp AS T1
    INNER JOIN (
        SELECT *
        FROM dbp_data.marktbestand_erp_zu
        WHERE (mandant_id, ek_netto, ek_netto_bnk, vk_netto, ek_nettonetto, einstandspreis) IN (SELECT (
            mandant_id, ek_netto,
            ek_netto_bnk, vk_netto, ek_nettonetto, einstandspreis
        )
        FROM `_perf`)
    ) AS t2
        ON
            T1.ek_netto = t2.ek_netto AND T1.ek_netto_bnk = t2.ek_netto_bnk AND T1.vk_netto = t2.vk_netto
            AND T1.wrg_id = t2.wrg_id AND T1.ek_nettonetto = t2.ek_nettonetto AND T1.einstandspreis = t2.einstandspreis
            AND T1.mandant_id = t2.mandant_id
    GROUP BY
        `_mandant_id`,
        `_wup_id`,
        `_art_id`,
        `_relevant_fg`,
        `_bezugsweg_id`
) AS dt1
WHERE
    marktbestand_erp.mandant_id = dt1.`_mandant_id` AND marktbestand_erp.wup_id = dt1.`_wup_id` AND marktbestand_erp.art_id
    = dt1.`_art_id` AND marktbestand_erp.dat = DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL ${LOOP_ID} DAY);
