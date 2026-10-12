DELETE FROM DBP_ETL.bestand_mardh_mard_log
WHERE (mandant_id, art_id, wup_id, nb_id, lagerort_id) IN
(SELECT mandant_id, art_id, wup_id, nb_id, lagerort_id
FROM DBP_ETL.bestand_mardh_tmp
)
;

