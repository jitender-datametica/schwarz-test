--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    CASE
        WHEN T1.mandant_kbez = 'D'
            THEN 'DE'
        ELSE T1.mandant_kbez
    END AS lkz_iso,
    T1.mandant_id,
    T2.spr_id,
    T3.sap_spr_id,
    T4.sap_spr_id AS sap_spr_id_de,
    T1.default_wrg
FROM dbp_data.mandant AS T1
INNER JOIN dbp_data.mandant_spr_zu AS T2 ON T1.mandant_id = T2.mandant_id
INNER JOIN dbp_data.sap_dwh_spr_zu AS T3 ON T2.spr_id = T3.spr_id
INNER JOIN dbp_data.sap_dwh_spr_zu AS T4 ON T4.spr_id = 22;
