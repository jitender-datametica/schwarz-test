UPDATE dbp_data.besch_best_det_2 SET
    dat_best_beleg = t1.`_dat_best_beleg_neu` FROM (
    SELECT
        TMP.mandant_id AS `_mandant_id`,
        TMP.best_beleg_id AS `_best_beleg_id`,
        TMP.dat_best_beleg AS `_dat_best_beleg_neu`,
        BB.dat_best_beleg AS `_dat_best_beleg_alt`
    FROM ${TEMP_TABLE} AS TMP
    INNER JOIN
        dbp_data.besch_best_2
            AS BB
        ON
            TMP.mandant_id = BB.mandant_id AND TMP.best_beleg_id = BB.best_beleg_id
            AND TMP.dat_best_beleg <> BB.dat_best_beleg
) AS t1_2
WHERE
    besch_best_det.mandant_id = t1.`_mandant_id` AND besch_best_det.best_beleg_id = t1.`_best_beleg_id` AND
    besch_best_det.dat_best_beleg = t1.`_dat_best_beleg_alt`;


UPDATE dbp_data.besch_best_2 AS besch_best0 SET
    dat_best_beleg = t1.`_dat_best_beleg`,
    nachbest_fg = t1.`_nachbest_fg`,
    loesch_fg = t1.`_loesch_fg`,
    best_beleg_status_id = t1.`_best_beleg_status_id`,
    kunde_id = t1.`_kunde_id`,
    bestellart_id = t1.`_bestellart_id`,
    system_id = t1.`_system_id`,
    dat_aenderung = t1.`_dat_aenderung`,
    gp_id = t1.`_gp_id`,
    wup_id = t1.`_wup_id`,
    einkaufsorganisation_id = t1.`_einkaufsorganisation_id`,
    nb_id = t1.`_nb_id` FROM (SELECT
    mandant_id AS `_mandant_id`,
    best_beleg_id AS `_best_beleg_id`,
    gp_id AS `_gp_id`,
    dat_best_beleg AS `_dat_best_beleg`,
    bestellart_id AS `_bestellart_id`,
    loesch_fg AS `_loesch_fg`,
    nachbest_fg AS `_nachbest_fg`,
    einkaufsorganisation_id AS `_einkaufsorganisation_id`,
    kunde_id AS `_kunde_id`,
    dat_aenderung AS `_dat_aenderung`,
    wup_id AS `_wup_id`,
    nb_id AS `_nb_id`,
    best_beleg_status_id AS `_best_beleg_status_id`,
    system_id AS `_system_id`,
    empfaenger_wup_id AS `_empfaenger_wup_id`,
    anz_pos_aktiv AS `_anz_pos_aktiv`,
    anz_pos_offen AS `_anz_pos_offen`,
    submi_id AS `_submi_id`,
    ref_beleg_id_intern AS `_ref_beleg_id_intern`
FROM ${TEMP_TABLE}) AS t1_2
WHERE besch_best0.mandant_id = t1.`_mandant_id` AND besch_best0.best_beleg_id = t1.`_best_beleg_id`;
