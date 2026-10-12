SELECT
    mandant_id,
    gp_id,
    gp_teilsortiment_id,
    einkaufsorganisation_id,
    zahlungsziel_id,
    zek_id
FROM dbp_data.l_gp_teilsortiment
WHERE
    zahlungsziel_id <> ''
    AND zahlungsziel_id NOT LIKE '% %';
