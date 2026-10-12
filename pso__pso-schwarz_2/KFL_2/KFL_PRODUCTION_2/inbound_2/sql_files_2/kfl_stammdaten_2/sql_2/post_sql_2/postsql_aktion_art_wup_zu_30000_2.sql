UPDATE dbp_etl_process.aktion_art_wup_zu_2 

SET vk_vor_aktion_brutto = vk_brutto_

FROM
(       
  SELECT 
  aaw.mandant_id  AS mandant_id_
  ,aaw.art_id AS art_id_
  ,aaw.wup_id AS wup_id_
  ,aaw.aktion_id AS aktion_id_
  ,aaw.vk_aktion_brutto AS vk_aktion_brutto_
  ,ap.vk_brutto AS vk_brutto_
FROM ${TEMP_TABLE} aaw
JOIN dbp_etl_process.aktion_2 a 
    ON a.mandant_id = aaw.mandant_id and a.aktion_id = aaw.aktion_id
JOIN dbp_data.art_wup_vk_per_2 ap
     ON ap.mandant_id = a.mandant_id
        AND aaw.art_id = ap.art_id
        AND aaw.wup_id = ap.wup_id
        AND a.dat_von - 1 BETWEEN ap.dat_von AND ap.dat_bis
WHERE vk_vor_aktion_brutto IS NULL 
  AND aaw.mandant_id = 1 
)

WHERE vk_vor_aktion_brutto IS NULL
  AND mandant_id_ = mandant_id
  AND art_id_ = art_id
  AND wup_id_ = wup_id
  AND aktion_id_ = aktion_id
;
