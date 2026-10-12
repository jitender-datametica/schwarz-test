UPDATE dbp_data.werbung_kennzahlen_woche_1 SET
    art_mutter_bezugsweg_id = b.bezugsweg_id FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        bezugsweg_id
    FROM dbp_data.art_wup_status_per_1
    WHERE dat_bis = DATE '9999-12-31'
    GROUP BY
        art_id,
        mandant_id,
        wup_id,
        bezugsweg_id
) AS b
WHERE
    werbung_kennzahlen_woche.mandant_id = b.mandant_id
    AND werbung_kennzahlen_woche.mutter_wb_id = b.art_id
    AND werbung_kennzahlen_woche.wup_id = b.wup_id;


UPDATE dbp_data.werbung_kennzahlen_woche_1 SET
    art_mutter_bezugsweg_id = b.bezugsweg_id FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        bezugsweg_id
    FROM dbp_data.art_wup_status_per_1
    WHERE dat_bis = DATE '9999-12-31'
    GROUP BY
        art_id,
        mandant_id,
        wup_id,
        bezugsweg_id
) AS b
WHERE
    werbung_kennzahlen_woche.mandant_id = b.mandant_id
    AND werbung_kennzahlen_woche.art_id = b.art_id
    AND werbung_kennzahlen_woche.wup_id = b.wup_id AND werbung_kennzahlen_woche.art_mutter_bezugsweg_id = -1;


UPDATE dbp_data.werbung_kennzahlen_woche_1 AS werbung_kennzahlen_woche0 SET
    art_mutter_bezugsweg_id = b.bezugsweg_id FROM (SELECT
    mandant_id,
    kjwo,
    mutter_wb_id,
    MAX(art_mutter_bezugsweg_id) AS bezugsweg_id
FROM dbp_data.werbung_kennzahlen_woche_1
GROUP BY
    mandant_id,
    kjwo,
    mutter_wb_id
HAVING COUNT(DISTINCT art_mutter_bezugsweg_id) > 1) AS b
WHERE
    werbung_kennzahlen_woche0.mandant_id = b.mandant_id
    AND werbung_kennzahlen_woche0.kjwo = b.kjwo
    AND werbung_kennzahlen_woche0.mutter_wb_id = b.mutter_wb_id;


UPDATE dbp_data.werbung_kennzahlen_woche_1 AS werbung_kennzahlen_woche0 SET
    posten_id = b.max_posten_id FROM (
    SELECT
        mandant_id,
        kjwo,
        art_id,
        MAX(posten_id) AS max_posten_id
    FROM dbp_data.werbung_kennzahlen_woche_1
    GROUP BY
        mandant_id,
        kjwo,
        art_id
) AS b
WHERE
    werbung_kennzahlen_woche0.mandant_id = b.mandant_id
    AND werbung_kennzahlen_woche0.kjwo = b.kjwo
    AND werbung_kennzahlen_woche0.art_id = b.art_id AND werbung_kennzahlen_woche0.posten_id <> b.max_posten_id;
