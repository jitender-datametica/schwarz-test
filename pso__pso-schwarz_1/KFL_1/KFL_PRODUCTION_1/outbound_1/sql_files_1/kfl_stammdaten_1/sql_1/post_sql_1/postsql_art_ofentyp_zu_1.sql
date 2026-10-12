DELETE FROM dbp_data.art_ofentyp_zu_1 AS T1_1
WHERE EXISTS (
    SELECT *
    FROM ${TEMP_TABLE} AS T2
    WHERE
        T1.art_id = art_id
        AND T1.mandant_id = mandant_id
        AND TRIM(T1.ofen_typ_id) = ofen_typ_id
        AND /* TRIM added for S4HANA prj because of E env state */ blech_belegung <> 0
);


/* dbp_etl.art_ofentyp_zu_temp */ INSERT INTO dbp_data.art_ofentyp_zu_1 (
    art_id, mandant_id, ofen_typ_id,
    blech_belegung, td_update, td_insert
)
(SELECT
    art_id,
    mandant_id,
    ofen_typ_id,
    blech_belegung,
    td_update,
    td_insert
FROM ${TEMP_TABLE}
WHERE blech_belegung <> 0);
