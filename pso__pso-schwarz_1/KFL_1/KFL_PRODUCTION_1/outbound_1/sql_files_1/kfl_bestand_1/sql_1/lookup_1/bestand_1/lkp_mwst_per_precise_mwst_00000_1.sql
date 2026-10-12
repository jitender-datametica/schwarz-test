--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    A.mandant_id,
    A.mwst_id,
    B.dat,
    A.mwst,
    A.sap_mwst_id,
    A.dat_von,
    A.dat_bis
FROM dbp_data.mwst_per_1 AS A
INNER JOIN dbp_data.tag_1 AS B ON B.dat BETWEEN A.dat_von AND A.dat_bis
WHERE (
    A.mandant_id, A.mwst, A.mwst_id) IN (
    SELECT (mandant_id, mwst, MIN(mwst_id))
    FROM dbp_data.mwst_per_1
    GROUP BY mandant_id,
    mwst
);
