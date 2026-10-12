CREATE OR REPLACE VIEW CORE_REL.V_SUPPLIER (
	 CLIENT_ID COMMENT 'ID of the country',
	 COUNTRY_CD COMMENT 'Abbreviation of the country',
	 SUPPLIER_ID COMMENT 'supplier id Lidl',
	 SUPPLIER_ID_INT COMMENT 'International supplier id',
	 ORIG_SUPPLIER_NR COMMENT 'original supplier number',
	 SUPPLIER_NAME COMMENT 'name of the supplier' 
) AS
SELECT DISTINCT 
	 client_id
	,country_cd
	,supplier_id
	,supplier_id_int
	,orig_supplier_nr
	,CASE 
		WHEN SUPPLIER_ID_INT IN ('31837') THEN 'Schwarz Produktion Eis'
		WHEN SUPPLIER_ID_INT IN ('31838') THEN 'Schwarz Produktion Bake-Off'
		WHEN SUPPLIER_ID_INT IN ('31839') THEN 'Schwarz Produktion Nüsse Schokolade'
		WHEN SUPPLIER_ID_INT IN ('31982') THEN 'Schwarz Produktion Kaffee'
		WHEN SUPPLIER_ID_INT IN ('10390') THEN 'Niederrhein Gold'
	ELSE supplier_name
	END AS supplier_name
FROM core_rel.t_supplier
UNION 
SELECT DISTINCT 
	 client_id
	,country_cd
	,-99 AS supplier_id
	,'-99' AS supplier_id_int
	,'-99' AS orig_supplier_nr
	,'Konserven' AS supplier_name
FROM core_rel.t_supplier
;