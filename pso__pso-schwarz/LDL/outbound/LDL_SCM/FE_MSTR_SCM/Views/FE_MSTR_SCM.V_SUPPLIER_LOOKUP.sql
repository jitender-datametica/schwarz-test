CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_supplier_lookup (supplier_id_int
OPTIONS(description='International supplier id'), supplier_id_int_bez OPTIONS(description='Supplier name')) AS (SELECT
 DISTINCT supplier_id_int,
  supplier_name AS supplier_id_int_bez
 FROM ldl_scm_core_rel.v_supplier
 WHERE supplier_id_int NOT IN ('31839')
 UNION DISTINCT
 SELECT DISTINCT CONCAT(supplier_id_int, '_1') AS supplier_id_int,
  'Schwarz Produktion Nüsse' AS supplier_name
 FROM ldl_scm_core_rel.v_supplier
 WHERE supplier_id_int IN ('31839'))
UNION DISTINCT
SELECT DISTINCT CONCAT(supplier_id_int, '_2') AS supplier_id_int,
 'Schwarz Produktion Schokolade' AS supplier_name
FROM ldl_scm_core_rel.v_supplier
WHERE supplier_id_int IN ('31839');