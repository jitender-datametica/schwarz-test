--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    art_id,
    einkaufsorganisation_id
FROM dbp_data.art_gp_zu_per_1
WHERE dat_bis = PARSE_DATE('%F', '9999-12-31');
