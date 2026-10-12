UPDATE dbp_data.aktion_art_wup_zu_1 SET
    vk_vor_aktion_brutto = t0.vk_brutto_ FROM (
    SELECT
        AAW.mandant_id AS mandant_id_,
        AAW.art_id AS art_id_,
        AAW.wup_id AS wup_id_,
        AAW.aktion_id AS aktion_id_,
        AAW.vk_aktion_brutto AS vk_aktion_brutto_,
        AP.vk_brutto AS vk_brutto_
    FROM ${TEMP_TABLE} AS AAW
    INNER JOIN dbp_data.aktion_1 AS A ON AAW.mandant_id = A.mandant_id AND AAW.aktion_id = A.aktion_id
    INNER JOIN dbp_data.art_wup_vk_per_1 AS AP
        ON
            A.mandant_id = AP.mandant_id AND AAW.art_id = AP.art_id
            AND AAW.wup_id = AP.wup_id AND DATE_SUB(A.dat_von, INTERVAL 1 DAY) BETWEEN AP.dat_von AND AP.dat_bis
    WHERE
        AAW.vk_vor_aktion_brutto IS NULL
        AND AAW.mandant_id = 1
) AS t0
WHERE
    aktion_art_wup_zu.vk_vor_aktion_brutto IS NULL AND t0.mandant_id_ = aktion_art_wup_zu.mandant_id AND t0.art_id_ =
    aktion_art_wup_zu.art_id AND t0.wup_id_ = aktion_art_wup_zu.wup_id AND t0.aktion_id_ = aktion_art_wup_zu.aktion_id;
