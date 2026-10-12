CREATE OR REPLACE VIEW ldl_scm_core_rel.v_supplier_1 (client_id OPTIONS(description='ID of the country_1'), country_cd
OPTIONS(description='Abbreviation of the country_1'), supplier_id OPTIONS(description='supplier_1 id Lidl'), supplier_id_int
OPTIONS(description='International supplier_1 id'), orig_supplier_nr OPTIONS(description='original supplier_1 number'),
supplier_name OPTIONS(description='name of the supplier_1')) AS SELECT DISTINCT client_id,
 country_cd,
 supplier_id,
 supplier_id_int,
 orig_supplier_nr,
  CASE
  WHEN supplier_id_int IN ('31837')
  THEN 'Schwarz Produktion Eis'
  WHEN supplier_id_int IN ('31838')
  THEN 'Schwarz Produktion Bake-Off'
  WHEN supplier_id_int IN ('31839')
  THEN 'Schwarz Produktion Nüsse Schokolade'
  WHEN supplier_id_int IN ('31982')
  THEN 'Schwarz Produktion Kaffee'
  WHEN supplier_id_int IN ('10390')
  THEN 'Niederrhein Gold'
  ELSE supplier_name
  END AS supplier_name
FROM ldl_scm_core_rel.t_supplier_1
UNION DISTINCT
SELECT DISTINCT client_id,
 country_cd,
 - 99 AS supplier_id,
 '-99' AS supplier_id_int,
 '-99' AS orig_supplier_nr,
 'Konserven' AS supplier_name
FROM ldl_scm_core_rel.t_supplier_1;