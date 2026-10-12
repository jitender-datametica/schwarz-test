--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.preis_aenderung_spr_zu (
    mandant_id, preis_aend_grund_id, spr_id,
    preis_aend_grund_bez
)
(
    SELECT
        L.mandant_id,
        L.preis_aend_grund_id,
        M.spr_id,
        'system generated' AS layoutbaustein_bez
    FROM dbp_data.l_preis_aenderung AS L
    INNER JOIN
        dbp_data.mandant_spr_zu AS M
        ON L.mandant_id = M.mandant_id OR M.mandant_id = 1
    WHERE
        L.preis_aend_grund_id = 0
        AND (
            L.preis_aend_grund_id, L.mandant_id, M.spr_id) NOT IN (
            SELECT (preis_aend_grund_id, mandant_id, spr_id)
            FROM dbp_data.preis_aenderung_spr_zu
        )
);
