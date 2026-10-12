--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    mandant_id,
    mandant_bez,
    mandant_sap_id,
    default_wrg,
    mandant_sort_id,
    spaet_lief_tage,
    mandant_sb_id,
    mandant_sb_tf_id,
    CASE
        WHEN mandant_kbez = 'D'
            THEN 'DE'
        ELSE mandant_kbez
    END AS land_id
FROM dbp_data.mandant_2;
