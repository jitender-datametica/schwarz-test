CREATE OR REPLACE VIEW smp_production_core.v_shopper_map_2 (division_id, country_id, shopper_id, shopper_id_ref) AS SELECT
 S.division_id,
 S.country_id,
 S.shopper_id,
 REPLACE(TO_JSON_STRING(F.VALUE), '"', '') AS shopper_id_ref
FROM smp_production_core_rel.t_shopper_2 AS S
 CROSS JOIN UNNEST(UDF_SCHEMA.flatten(PARSE_JSON(SHOPPER_ID_REF), '', FALSE, FALSE, 'both')) AS F;