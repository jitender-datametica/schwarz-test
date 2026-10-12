SELECT
    mandant_id,
    kl_art_id AS matnr,
    art_id,
    dat_bis,
    wg_art_fg,
    gewart_id,
    mwst_id,
    zek_id
FROM dbp_data.art
WHERE (
    mandant_id, art_id) IN (
    SELECT (mandant_id, MAX(art_id))
    FROM dbp_data.art
    GROUP BY mandant_id,
    kl_art_id
);
