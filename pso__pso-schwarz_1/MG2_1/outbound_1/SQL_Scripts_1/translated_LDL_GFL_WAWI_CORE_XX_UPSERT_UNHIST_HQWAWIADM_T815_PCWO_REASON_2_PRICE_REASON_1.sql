--!SET exit_on_error=True;

-- Apply the changes as INSERTs or UPDATES ignoring any unchanged rows.


MERGE INTO ldl_data_production_core_rel.t_price_reason_1 AS target
USING (SELECT DISTINCT pcwo.c815_reason_id AS price_reason_cd,
  pcwo.c815_reason_desc_nat AS price_reason_descr,
  c.official_lang_cd AS lang_cd
 FROM hqwawiadm.t201_itemprices_1 AS hq
  INNER JOIN hqwawiadm.t815_pcwo_reason_1 AS pcwo ON hq.c201_reason_id = pcwo.c815_reason_id
  INNER JOIN ldl_data_production_core_rel.t_country_1 AS c ON pcwo.wawi_instanz_kzl = c.iso_country_cd
 WHERE pcwo.wawi_instanz_kzl IN ('DE', 'GB', 'ES', 'FI', 'GR', 'SE', 'DK', 'BG', 'CZ', 'FR', 'HR', 'HU', 'IT', 'NL',
    'PL', 'PT', 'RO', 'RS_1', 'SI', 'SK')
  AND hq.delete_fg IS NULL
  AND pcwo.delete_fg IS NULL) AS source
ON CAST(target.price_reason_cd AS FLOAT64) = source.price_reason_cd AND target.lang_cd = source.lang_cd
WHEN MATCHED THEN UPDATE SET
 price_reason_descr = source.price_reason_descr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = CAST(${LOAD_ID} AS INTEGER),
 dwh_node_cd = 'WAWI'
WHEN NOT MATCHED THEN INSERT VALUES(CAST(source.price_reason_cd AS STRING), source.lang_cd, source.price_reason_descr,
 CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), CAST(${LOAD_ID} AS INTEGER), 'WAWI');