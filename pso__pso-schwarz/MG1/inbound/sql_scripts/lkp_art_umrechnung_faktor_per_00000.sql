SELECT mandant_id,
       art_id,
       UPPER(TRIM(altnv_menge_einh_id)) as altnv_menge_einh_id_upper,
       altnv_menge_einh_id as altnv_menge_einh_id,
       dat_von,
       dat_bis,
       umrech_faktor
FROM DBP_DATA.art_umrechnung_faktor_per
QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id, art_id, altnv_menge_einh_id_upper ORDER BY dat_bis DESC) = 1
ORDER BY 1,2,3,4
;

