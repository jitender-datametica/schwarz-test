--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    eigenmarke_id,
    spr_id
FROM dbp_data.artkz_eigenmarke
ORDER BY
    mandant_id NULLS LAST,
    eigenmarke_id NULLS LAST,
    spr_id NULLS LAST;
