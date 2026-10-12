CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_ORACLE_FK_SHELF_USAGE (
	COUNTRY
	,DATE
	,ITEM_NR
	,STORE
	,SHC_UNIT_ID
	,SHELFCAPACITY
	,CORRECTED_STD
	,CAPPED_STD
	,CAPPED_SHELF_USAGE
	,ACTUAL_SHELF_USAGE
	,ROW_COUNT
	) AS

     /* Version: 1.2
	** Author:	Dominik Pfarr
	** Date: 	2024-06-18
	** Changes:	using 3 tables instead of views; null handling; wawi_shelf_capa; back to the roots
	*/
    
SELECT COALESCE(a11.country, a12.country, a13.country) country
	,COALESCE(a11.sh_DATE, a13.fss_date) DATE
	,COALESCE(LPAD(a11.SH_ITEM_NR, 7, '0'), a12.cap_item_nr, a13.fss_item_nr) item_nr
	,COALESCE(a11.sh_store_nr, a12.cap_store_nr, a13.fss_store_nr) store
	,COALESCE((CASE WHEN COALESCE(a11.sh_qty_aoc, - 1) <> - 1 THEN a11.sh_aoc_shc_unit_id ELSE a11.sh_wawi_shc_unit_id END), a12.cap_unit_id) shc_unit_id
	,(COALESCE(sh_qty_aoc,sh_qty_wawi) * a12.cap_packagecapacity * a12.cap_quantity) AS SHELFCAPACITY
	,a13.FSS_QUANTITY AS CORRECTED_STD
	,LEAST(SHELFCAPACITY, CORRECTED_STD) AS CAPPED_STD
	,CASE WHEN SHELFCAPACITY=0 THEN 0 ELSE (CAPPED_STD / SHELFCAPACITY) END AS capped_shelf_usage
	,CASE WHEN SHELFCAPACITY=0 THEN 0 ELSE (CORRECTED_STD / SHELFCAPACITY) END AS actual_shelf_usage
	,1 AS ROW_COUNT
FROM CORE.T_ORACLE_V_DIM_SHC_DATE a11
INNER JOIN CORE.T_ORACLE_V_DIM_CAPACITY a12
	ON (a11.country = a12.country 
    AND LPAD(a11.SH_ITEM_NR, 7, '0') = a12.cap_item_nr 
    AND a11.sh_store_nr = a12.cap_store_nr 
    AND (CASE WHEN COALESCE(a11.sh_qty_aoc, - 1) <> - 1 THEN a11.sh_aoc_shc_unit_id ELSE a11.sh_wawi_shc_unit_id END) = a12.cap_unit_id)
FULL JOIN CORE.T_ORACLE_V_FK_STORE_STOCK a13
	ON (a11.country = a13.country 
    AND a11.sh_DATE = a13.fss_date 
    AND LPAD(a11.SH_ITEM_NR, 7, '0') = a13.fss_item_nr 
    AND a11.sh_store_nr = a13.fss_store_nr)
WHERE a12.deleted = 0;