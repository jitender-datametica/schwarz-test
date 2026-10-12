--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    art_id,
    basismenge_einh_id
FROM dbp_data.art
WHERE mandant_id <> 1;
