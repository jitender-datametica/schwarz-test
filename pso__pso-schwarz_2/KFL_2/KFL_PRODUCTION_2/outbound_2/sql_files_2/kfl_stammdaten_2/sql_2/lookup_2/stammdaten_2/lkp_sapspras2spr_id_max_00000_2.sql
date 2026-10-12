--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    s.sap_spr_id,
    s.spr_id,
    M.mandant_id
FROM (SELECT
    sap_spr_id,
    MAX(spr_id) AS spr_id
FROM dbp_data.sap_dwh_spr_zu_2
WHERE mandant_id = 1
GROUP BY sap_spr_id) AS s
LEFT JOIN dbp_data.mandant_spr_zu_2 AS M ON s.spr_id = M.spr_id;
