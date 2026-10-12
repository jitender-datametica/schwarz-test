UPDATE DBP_DATA.art_per_1
SET iwt_id =_iwt_id                 
FROM 
(
SELECT
  art_id AS _art_id,
  mandant_id AS _mandant_id,                
  iwt_id AS _iwt_id  
FROM ${TEMP_TABLE} 
) dt1
WHERE art_id = _art_id
      AND mandant_id = _mandant_id
;
