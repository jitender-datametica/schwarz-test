!SET exit_on_error=True;

-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.
MERGE INTO core_rel.t_price_reason_1 AS target USING 
 (
  SELECT DISTINCT 
    pcwo.c815_reason_id AS price_reason_cd,
    --pcwo.c815_reason_desc_int,
    pcwo.c815_reason_desc_nat AS price_reason_descr,
    --pcwo.ctrcode,
    c.official_lang_cd AS lang_cd
  FROM etl.t_wawi_precore_t201_itemprices_hq_1 hq
  JOIN etl.t_wawi_precore_t815_pcwo_reason_1 pcwo ON hq.c201_reason_id = pcwo.c815_reason_id
  JOIN core_rel.t_country_1 c ON c.iso_country_cd = pcwo.ctrcode
  WHERE pcwo.ctrcode IN ('DE','GB','ES','FI','GR','SE','DK','BG','CZ','FR','HR','HU','IT','NL','PL','PT',
                                               'RO','RS_1','SI','SK') -- take countries which are using local languages for Reason codes
 ) AS source ON target.price_reason_cd = source.price_reason_cd 
                AND target.lang_cd = source.lang_cd 
WHEN matched THEN 
UPDATE 
SET 
  target.price_reason_descr = source.price_reason_descr, 
  dwh_updated_tmsp = CURRENT_TIMESTAMP, 
  dwh_load_id = ${LOAD_ID}, 
  dwh_node_cd = 'WAWI' 
WHEN NOT matched THEN 
INSERT (
    price_reason_cd, 
    lang_cd, 
    price_reason_descr, 
    dwh_created_tmsp, 
    dwh_updated_tmsp, 
    dwh_load_id, 
    dwh_node_cd
  ) 
VALUES 
  (
    source.price_reason_cd, 
    source.lang_cd, 
    source.price_reason_descr, 
    CURRENT_TIMESTAMP, 
    CURRENT_TIMESTAMP, 
    ${LOAD_ID},
    'WAWI'
  );
