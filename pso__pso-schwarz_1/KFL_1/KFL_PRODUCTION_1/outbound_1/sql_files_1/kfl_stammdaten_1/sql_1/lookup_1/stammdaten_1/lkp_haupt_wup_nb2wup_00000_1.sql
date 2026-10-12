--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    COALESCE(haupt_wup_id, wup_id) AS haupt_wup_id,
    nb_id,
    wup_id
FROM dbp_data.wup_1;
