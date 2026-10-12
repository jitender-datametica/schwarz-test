DELETE FROM dbp_data.wupcal_ereignis_zu_2
WHERE (dat, wup_id, nb_id, mandant_id) IN (
    SELECT (L.dat, W.wup_id, W.nb_id, W.mandant_id)
    FROM ${TEMP_TABLE} AS L
    INNER JOIN dbp_data.wup_2 AS W ON L.wup_id = W.haupt_wup_id AND W.nb_id IN (2, 7) AND L.mandant_id = W.mandant_id
);


INSERT INTO dbp_data.wupcal_ereignis_zu_2 (
    dat, wup_id, nb_id, mandant_id, ereignistyp_id, ereignis_id,
    offen
)
(
    SELECT
        L.dat,
        W.wup_id,
        W.nb_id,
        W.mandant_id,
        L.ereignistyp_id,
        L.ereignis_id,
        L.offen
    FROM ${TEMP_TABLE} AS L
    INNER JOIN dbp_data.wup_2 AS W ON L.wup_id = W.haupt_wup_id AND W.nb_id IN (2, 7) AND L.mandant_id = W.mandant_id
);
