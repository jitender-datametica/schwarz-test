UPDATE dbp_data.art_spr_zu_1 SET
    int_art_bez = b.int_art_bez FROM (
    SELECT
        A.mandant_id,
        B.art_id,
        A.spr_id,
        A.int_art_bez
    FROM ${TEMP_TABLE} AS A
    INNER JOIN dbp_data.art_1 AS B ON A.mandant_id = B.mandant_id AND A.art_id = B.int_art_id
) AS b
WHERE art_spr_zu.mandant_id = b.mandant_id AND art_spr_zu.art_id = b.art_id AND art_spr_zu.spr_id = b.spr_id;


UPDATE dbp_data.art_spr_zu_1 SET
    int_art_bez = b.int_art_bez FROM (
    SELECT
        B.mandant_id,
        B.art_id,
        A.spr_id,
        A.int_art_bez
    FROM ${TEMP_TABLE} AS A
    INNER JOIN dbp_data.art_1 AS B ON A.art_id = B.int_art_id
    WHERE A.spr_id = 22
    GROUP BY
        A.spr_id,
        A.int_art_bez,
        B.mandant_id,
        B.art_id
) AS b
WHERE art_spr_zu.mandant_id = b.mandant_id AND art_spr_zu.art_id = b.art_id AND art_spr_zu.spr_id = b.spr_id;
