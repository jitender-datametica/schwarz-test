--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    gp_id,
    gp_teilsortiment_id,
    einkaufsorganisation_id,
    spr_id,
    gp_teilsortiment_bez
FROM dbp_data.gp_teilsortiment_spr_zu;
