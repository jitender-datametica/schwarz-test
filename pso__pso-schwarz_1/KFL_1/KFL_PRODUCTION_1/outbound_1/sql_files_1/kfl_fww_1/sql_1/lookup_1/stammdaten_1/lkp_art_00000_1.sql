--translated statement


/* GROUP BY kl_art_id, mandant_id QUALIFY CSUM(1, art_id DESC) = 1; */ SELECT
    kl_art_id,
    art_id,
    mandant_id,
    wg_art_fg,
    dat_von,
    dat_bis
FROM dbp_data.art_1
QUALIFY
    (ROW_NUMBER() OVER (PARTITION BY kl_art_id, mandant_id ORDER BY art_id IS NULL DESC, art_id DESC)) = 1;
