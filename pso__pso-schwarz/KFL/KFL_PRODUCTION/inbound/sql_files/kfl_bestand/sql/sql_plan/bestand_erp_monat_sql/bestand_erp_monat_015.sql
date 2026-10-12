INSERT INTO DBP_ETL.vis_monat_bestand_wg_log_alt
(
mandant_id
,wup_id
,nb_id
,art_id
,gjmo
)
SELECT
mandant_id
,wup_id
,nb_id
,art_id
,MIN(gjmo) _gjmo
FROM DBP_ETL.bestand_erp_monat_tmp
WHERE nb_id = 0
AND (mandant_id, wup_id, art_id, gjmo_bis) IN
(SELECT mandant_id, wup_id, art_id, gjmo_bis
FROM DBP_ETL.bestand_mardh_tmp
WHERE lade_kz = 0
AND nb_id = 0
)

GROUP BY 1,2,3,4
HAVING (mandant_id, wup_id, nb_id, art_id, _gjmo) NOT IN
(SELECT mandant_id, wup_id, nb_id, art_id, gjmo
FROM DBP_ETL.vis_monat_bestand_wg_log_alt
)
;

