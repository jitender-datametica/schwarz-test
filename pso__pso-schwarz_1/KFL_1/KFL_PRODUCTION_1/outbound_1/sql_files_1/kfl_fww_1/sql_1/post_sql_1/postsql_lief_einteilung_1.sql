UPDATE dbp_data.lief_einteilung_1 SET
    flw_fg = dd.flw_fg_ FROM (
    SELECT
        DT1.mandant_id AS mandant_id_,
        DT1.best_beleg_id AS best_beleg_id_,
        DT1.best_beleg_pos_id AS best_beleg_pos_id_,
        DT1.einteil_id AS einteil_id_,
        DT2.flw_fg AS flw_fg_
    FROM ${TEMP_TABLE} AS DT1
    INNER JOIN dbp_data.besch_best_det_1 AS DT2
        ON
            DT1.mandant_id = DT2.mandant_id AND DT1.best_beleg_id =
            DT2.best_beleg_id AND DT1.best_beleg_pos_id = DT2.best_beleg_pos_id AND DT2.flw_fg <> 0
    GROUP BY
        mandant_id_,
        best_beleg_id_,
        best_beleg_pos_id_,
        einteil_id_,
        flw_fg_
) AS dd
WHERE
    lief_einteilung.mandant_id = dd.mandant_id_ AND lief_einteilung.best_beleg_id = dd.best_beleg_id_ AND
    lief_einteilung.best_beleg_pos_id = dd.best_beleg_pos_id_ AND lief_einteilung.einteil_id = dd.einteil_id_;
