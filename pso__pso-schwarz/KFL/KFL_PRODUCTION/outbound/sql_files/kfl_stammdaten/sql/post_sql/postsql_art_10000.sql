UPDATE dbp_data.art SET
    saison_id = ''
WHERE TRUE;


UPDATE dbp_data.art SET
    saison_id = b.saison_id
FROM ${TEMP_TABLE} AS b
WHERE art.mandant_id = b.mandant_id AND art.art_id = b.art_id;
