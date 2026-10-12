INSERT INTO dbp_data.udf_prognose_1 (
    mandant_id, wup_id, nb_id, art_id, diagnose_id, dat_prognoselauf, dat,
    prognose_horizont,
    menge_prognose_af,
    menge_prognose_sa,
    menge_prognose_gesteuert,
    td_update,
    td_insert
)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        art_id,
        diagnose_id,
        DATE('2022-11-20') AS dat_prognoselauf,
        dat,
        prognose_horizont,
        menge_prognose_af,
        menge_prognose_sa,
        menge_prognose_gesteuert,
        CURRENT_TIMESTAMP() AS td_update,
        CURRENT_TIMESTAMP() AS td_insert
    FROM dbp_data.udf_prognose_1
    WHERE
        dat_prognoselauf = DATE '2022-11-19'
        AND mandant_id = 1
);
