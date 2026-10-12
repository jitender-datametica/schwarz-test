SELECT
    mandant_id,
    zek_id
FROM dbp_data.zek
GROUP BY
    mandant_id,
    zek_id;
