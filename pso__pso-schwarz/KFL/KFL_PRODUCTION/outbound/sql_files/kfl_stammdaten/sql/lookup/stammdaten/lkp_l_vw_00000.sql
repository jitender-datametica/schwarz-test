--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    TRIM(sap_vw_id) AS sap_vw_id,
    vw_id
FROM dbp_data.l_vw
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST;
