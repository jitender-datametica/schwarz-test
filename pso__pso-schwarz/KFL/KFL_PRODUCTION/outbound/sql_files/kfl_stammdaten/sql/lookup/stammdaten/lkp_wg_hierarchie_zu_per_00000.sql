--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    wg_hierarchie_id,
    arthiertyp_id,
    wg_hierarchie_ebene_id,
    wg_hierarchie_mutter_id
FROM dbp_data.wg_hierarchie_zu_per
WHERE dat_bis = PARSE_DATE('%F', '9999-12-31');
