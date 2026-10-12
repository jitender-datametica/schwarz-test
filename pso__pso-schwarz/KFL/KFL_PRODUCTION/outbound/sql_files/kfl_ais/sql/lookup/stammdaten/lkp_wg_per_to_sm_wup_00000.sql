SELECT
    mandant_id,
    wg_id,
    arthiertyp_id,
    dat_von,
    dat_bis
FROM dbp_data.wg_per
WHERE dat_bis = DATE '9999-12-31';
