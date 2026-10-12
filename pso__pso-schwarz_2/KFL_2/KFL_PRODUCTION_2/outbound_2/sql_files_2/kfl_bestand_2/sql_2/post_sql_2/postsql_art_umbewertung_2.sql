INSERT INTO dbp_etl.art_umbewertung_temp_2 (
    mandant_id, umbew_beleg_id, umbew_beleg_pos_id, kj,
    preis_aend_grund_id, art_id, wup_id, nb_id, dat_umbew, vk_brutto_alt, menge_umbew, diff_wert_bestand_brutto,
    diff_wert_bestand_netto, wrg_id, menge_erf, menge_bestand_bme, wert_bestand_brutto_alt, verk_menge_einh_id,
    buchungskreis_id, soll_haben_kz, art_id_bf, vk_brutto_neu, wert_bestand_netto_alt, td_update, td_insert
)
(
    SELECT *
    FROM ${TEMP_TABLE}
);


DELETE FROM dbp_data.art_umbewertung_2
WHERE (mandant_id, art_id, dat_umbew, umbew_beleg_id, umbew_beleg_pos_id) IN (SELECT (
    mandant_id, art_id, dat_umbew,
    umbew_beleg_id, umbew_beleg_pos_id
)
FROM ${TEMP_TABLE});


INSERT INTO dbp_data.art_umbewertung_2 (
    mandant_id, umbew_beleg_id, umbew_beleg_pos_id, kj,
    preis_aend_grund_id, art_id, wup_id, nb_id, dat_umbew, vk_brutto_alt, menge_umbew, diff_wert_bestand_brutto,
    diff_wert_bestand_netto, wrg_id, menge_erf, menge_bestand_bme, wert_bestand_brutto_alt, verk_menge_einh_id,
    buchungskreis_id, soll_haben_kz, art_id_bf, vk_brutto_neu, wert_bestand_netto_alt, td_update, td_insert
)
(
    SELECT *
    FROM ${TEMP_TABLE}
);


UPDATE dbp_data.art_umbewertung_2 SET
    preis_aend_grund_id = t1.`_preis_aend_grund_id`,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        mandant_id AS `_mandant_id`,
        umbew_beleg_id AS `_umbew_beleg_id`,
        umbew_beleg_pos_id AS `_umbew_beleg_pos_id`,
        kj AS `_kj`,
        preis_aend_grund_id AS `_preis_aend_grund_id`
    FROM dbp_etl.kmo_idb_zmuseg_2
    GROUP BY
        `_mandant_id`,
        `_umbew_beleg_id`,
        `_umbew_beleg_pos_id`,
        `_kj`,
        `_preis_aend_grund_id`
) AS t1_2
WHERE
    art_umbewertung.mandant_id = t1.`_mandant_id` AND art_umbewertung.umbew_beleg_id = t1.`_umbew_beleg_id` AND
    art_umbewertung.umbew_beleg_pos_id = t1.`_umbew_beleg_pos_id` AND art_umbewertung.kj = t1.`_kj`;
