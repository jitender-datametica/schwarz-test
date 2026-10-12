--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    mwst_id,
    mwst,
    sap_mwst_id
FROM (
    SELECT
        mandant_id,
        mwst_id,
        mwst,
        sap_mwst_id,
        dat_bis
    FROM dbp_data.mwst_per_1
    ORDER BY
        mandant_id NULLS LAST,
        mwst_id NULLS LAST,
        dat_bis DESC NULLS FIRST
) AS t0;
