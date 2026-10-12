--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    CASE
        WHEN T3.mandant_id = 1
            THEN 'DE'
        ELSE T3.mandant_kbez
    END AS countrycode,
    T2.sap_spr_id,
    T3.mandant_id,
    T2.spr_id
FROM dbp_data.mandant_spr_zu_1 AS T1_1
INNER JOIN dbp_data.sap_dwh_spr_zu_1 AS T2 ON T1.spr_id = T2.spr_id
INNER JOIN dbp_data.mandant_1
    AS T3 ON T1.mandant_id = T3.mandant_id OR T3.mandant_id <> 1 AND T1.spr_id
= 22;
