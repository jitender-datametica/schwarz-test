UPDATE dbp_data.besch_bestaetigung_1 SET
    kj_lief_beleg = x.kj_ FROM (
    SELECT
        A.mandant_id AS mandant_id_,
        A.lief_beleg_id AS lief_beleg_id_,
        A.lief_beleg_pos_id AS lief_beleg_pos_id_,
        C.kj AS kj_
    FROM ${TEMP_TABLE} AS A
    INNER JOIN dbp_data.besch_lief_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.lief_beleg_id = B.lief_beleg_id
            AND B.dat_lief_soll > DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY)
    INNER JOIN dbp_data.besch_lief_det_1 AS C
        ON
            B.mandant_id = C.mandant_id AND B.lief_beleg_id = C.lief_beleg_id
            AND A.lief_beleg_pos_id = C.lief_beleg_pos_id AND B.dat_lief_soll = C.dat_lief_soll
    WHERE A.lief_beleg_id <> -1
    GROUP BY
        mandant_id_,
        lief_beleg_id_,
        lief_beleg_pos_id_,
        kj_
) AS x
WHERE
    besch_bestaetigung.mandant_id = x.mandant_id_ AND besch_bestaetigung.lief_beleg_id = x.lief_beleg_id_ AND
    besch_bestaetigung.lief_beleg_pos_id = x.lief_beleg_pos_id_;


UPDATE dbp_data.besch_bestaetigung_1 SET
    kj_lief_beleg = x.kj_ FROM (
    SELECT
        A.mandant_id AS mandant_id_,
        A.lief_beleg_id AS lief_beleg_id_,
        A.lief_beleg_pos_id AS lief_beleg_pos_id_,
        C.kj AS kj_
    FROM dbp_data.besch_bestaetigung_1 AS A
    INNER JOIN dbp_data.besch_lief_1 AS B
        ON
            A.mandant_id = B.mandant_id AND A.lief_beleg_id = B.lief_beleg_id
            AND B.dat_lief_soll > DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 365 DAY)
    INNER JOIN dbp_data.besch_lief_det_1 AS C
        ON
            B.mandant_id = C.mandant_id AND B.lief_beleg_id = C.lief_beleg_id
            AND A.lief_beleg_pos_id = C.lief_beleg_pos_id AND B.dat_lief_soll = C.dat_lief_soll
    WHERE
        A.lief_beleg_id <> -1
        AND A.kj_lief_beleg = -1
    GROUP BY
        mandant_id_,
        lief_beleg_id_,
        lief_beleg_pos_id_,
        kj_
) AS x
WHERE
    besch_bestaetigung.mandant_id = x.mandant_id_ AND besch_bestaetigung.lief_beleg_id = x.lief_beleg_id_ AND
    besch_bestaetigung.lief_beleg_pos_id = x.lief_beleg_pos_id_;
