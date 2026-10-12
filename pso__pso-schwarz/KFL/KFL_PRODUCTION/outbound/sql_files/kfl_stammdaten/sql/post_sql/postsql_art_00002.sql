/*SPEC0258520*/


UPDATE dbp_data.art SET
    int_art_id = art.kl_art_id
WHERE
    int_art_id IS NULL OR TRIM(CAST(int_art_id AS STRING)) = '';
