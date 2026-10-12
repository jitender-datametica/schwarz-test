CREATE OR REPLACE VIEW FE_MSTR_SCM.V_SUPPLIER_LOOKUP_2 (
	SUPPLIER_ID_INT COMMENT 'International supplier_2 id',
	SUPPLIER_ID_INT_BEZ COMMENT 'Supplier_2 name'
) AS
SELECT DISTINCT 
	supplier_id_int
	,supplier_name
FROM core_rel.v_supplier_2
WHERE supplier_id_int NOT IN ('31839')
UNION 
SELECT DISTINCT 
	concat(supplier_id_int, '_1') AS supplier_id_int
	,'Schwarz Produktion Nüsse' AS supplier_name
FROM core_rel.v_supplier_2
WHERE 1=1
AND supplier_id_int IN ('31839')
UNION 
SELECT DISTINCT 
	concat(supplier_id_int, '_2') AS supplier_id_int
	,'Schwarz Produktion Schokolade' AS supplier_name
FROM core_rel.v_supplier_2
WHERE 1=1
AND supplier_id_int IN ('31839')
;