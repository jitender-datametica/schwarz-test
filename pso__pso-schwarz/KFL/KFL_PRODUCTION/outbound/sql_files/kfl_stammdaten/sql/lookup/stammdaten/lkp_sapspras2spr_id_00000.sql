--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    spr_id,
    sap_spr_id
FROM dbp_data.sap_dwh_spr_zu
WHERE mandant_id = 1;
