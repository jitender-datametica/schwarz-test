DELETE FROM dbp_data.art_list_wup_zu_per_2 AS T1_2
WHERE EXISTS (
    SELECT *
    FROM dbp_etl.wlk1_2 AS T2
    WHERE
        T1.mandant_id = mandant_id
        AND T1.art_id = art_id
        AND T1.wup_id = wup_id
        AND T1.list_quelle_id = COLLATE(list_quelle_id, 'und:ci')
        AND T1.struktur_art_id = struktur_art_id
        AND T1.dat_bis >= dat_bis
        AND loesch_fg = 0
);


UPDATE dbp_data.art_list_wup_zu_per_2 SET
    dat_bis = DATE_SUB(t1.dat_aend_, INTERVAL 1 DAY),
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        mandant_id AS mandant_id_,
        art_id AS art_id_,
        wup_id AS wup_id_,
        COLLATE(list_quelle_id, 'und:ci') AS list_quelle_id_,
        struktur_art_id AS struktur_art_id_,
        MIN(dat_aend) AS dat_aend_
    FROM dbp_etl.wlk1_2
    WHERE loesch_fg = 1
    GROUP BY
        mandant_id_,
        art_id_,
        wup_id_,
        list_quelle_id_,
        struktur_art_id_
) AS t1_2
WHERE
    art_list_wup_zu_per.mandant_id = t1.mandant_id_
    AND art_list_wup_zu_per.art_id = t1.art_id_
    AND art_list_wup_zu_per.wup_id = t1.wup_id_ AND art_list_wup_zu_per.list_quelle_id = t1.list_quelle_id_
    AND art_list_wup_zu_per.struktur_art_id = t1.struktur_art_id_ AND art_list_wup_zu_per.dat_bis >= t1.dat_aend_;


INSERT INTO dbp_data.art_list_wup_zu_per_2 (
    art_id, wup_id, nb_id, dat_von, mandant_id, list_quelle_id,
    struktur_art_id,
    dat_bis,
    baustein_id,
    list_sap_id,
    list_komponente_fg,
    td_update,
    td_insert
)
(SELECT
    art_id,
    wup_id,
    nb_id,
    dat_von,
    mandant_id,
    list_quelle_id,
    struktur_art_id,
    dat_bis,
    baustein_id,
    list_sap_id,
    komponente_fg,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM dbp_etl.wlk1_2
WHERE loesch_fg = 0);


UPDATE dbp_data.art_list_wup_zu_per_2 SET
    dat_bis = b.max_dat_bis,
    td_update = CAST(CURRENT_DATE AS TIMESTAMP) FROM (
    SELECT
        mandant_id AS mandant_id_,
        art_id AS art_id_,
        wup_id AS wup_id_,
        MAX(dat_bis) AS max_dat_bis
    FROM dbp_etl.wlk1_2
    WHERE mandant_id IN (2, 3, 4, 5, 6, 7, 8)
    GROUP BY
        mandant_id_,
        art_id_,
        wup_id_
) AS b
WHERE
    art_list_wup_zu_per.mandant_id = b.mandant_id_
    AND art_list_wup_zu_per.art_id = b.art_id_
    AND art_list_wup_zu_per_2
    .wup_id = b.wup_id_ AND art_list_wup_zu_per.dat_bis > b.max_dat_bis;
