SELECT
    mandant_id,
    art_nielsen_id,
    SUBSTR(art_nielsen_tag, -40, 40) AS art_nielsen_tag,
    art_nielsen_bez,
    gtin_id
FROM dbp_data.art_nielsen_1
WHERE
    dat_bis = DATE '9999-12-31'
    AND mandant_id IN (1);
