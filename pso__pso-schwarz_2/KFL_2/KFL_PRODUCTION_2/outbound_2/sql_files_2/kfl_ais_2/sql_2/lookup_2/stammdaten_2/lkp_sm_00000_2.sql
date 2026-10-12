--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    SM.mandant_id,
    TRIM(SM.sap_sm_id) AS sap_sm_id,
    SM.sm_id
FROM dbp_data.sm_2 AS SM_2
INNER JOIN
    dbp_data.mandant_spr_zu_2 AS MA
    ON SM.mandant_id = MA.mandant_id AND SM.spr_id = MA.spr_id;
