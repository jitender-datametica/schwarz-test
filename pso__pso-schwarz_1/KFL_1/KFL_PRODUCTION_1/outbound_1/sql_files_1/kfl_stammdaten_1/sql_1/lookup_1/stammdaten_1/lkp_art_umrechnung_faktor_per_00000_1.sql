SELECT
    mandant_id,
    art_id,
    UPPER(TRIM(altnv_menge_einh_id)) AS altnv_menge_einh_id_upper,
    altnv_menge_einh_id,
    dat_von,
    dat_bis,
    umrech_faktor
FROM dbp_data.art_umrechnung_faktor_per_1
QUALIFY (ROW_NUMBER() OVER (
    PARTITION BY
        mandant_id, art_id, UPPER(TRIM(altnv_menge_einh_id)) ORDER BY
        dat_bis IS NULL
        DESC, dat_bis DESC
)) = 1
ORDER BY
    1 NULLS LAST,
    2 NULLS LAST,
    3 NULLS LAST,
    4 NULLS LAST;
