/*
====================================================================================================
Division:           Lidl
Solution:           Operational Logistics (LOGOP)
DB schema:          fe_mstr_logop
DB table/view:      v_lpv_bestand_1
====================================================================================================
Change history:     version, date, developer, comment
    1.0     2025-05-23      Michal Kubica           Initial version
====================================================================================================
*/


/*
----------------------------------------------------------------------------------------------------
    View for LPV Bestand report
----------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_bestand_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id OPTIONS(description='Warehouse ID'),
article_nr OPTIONS(description='Article number. PK. Original name - ANR'), article_description
OPTIONS(description='Article name. Original name - KTXT'), item_group
OPTIONS(description='Item_1 group. Original name - V2'), article_family
OPTIONS(description='Article family. Original name - V3'), unit_1
OPTIONS(description='Number of units for each packaging unit_1 2. Original name - ANZAHL_VPE2'), unit_name
OPTIONS(description='Artcile unit_1 name. Original name - UNIT_1'), src_qty
OPTIONS(description='Quantity (number of pieces of unit_1 AST.VPE1). May be multiplied in order to display decimal places according to the global setting MengenFakt. Original name - menge'),
src_area_nr OPTIONS(description='Number of the area the stock is currently located in. Original name - bereich'),
src_pallet_nr OPTIONS(description='Number of the pallet on which the stock is located. Original name - lhmnr'),
pallet_count OPTIONS(description='Count of pallets excluding duplicates'), dwh_updated
OPTIONS(description='Latest update time')) AS SELECT A.client_id,
 A.wh_id,
 A.article_nr,
 A.article_descr AS article_description,
 A.v2_item_group AS item_group,
 A.v3_article_family AS article_family,
  ROUND(CAST(REPLACE(SUBSTR(CAST(A.quantity_unit2 AS STRING), 1, 39), ',', '') AS BIGNUMERIC), 0) / 1000 AS unit_1,
 A.article_unit_name AS unit_name,
  ROUND(CAST(REPLACE(SUBSTR(CAST(B.src_qty AS STRING), 1, 39), ',', '') AS BIGNUMERIC), 0) / 1000 AS src_qty,
 B.src_area_nr,
 B.src_pallet_nr,
  CASE
  WHEN (ROW_NUMBER() OVER (PARTITION BY B.src_pallet_nr ORDER BY A.client_id IS NULL, A.client_id)) = 1
  THEN 1
  ELSE 0
  END AS pallet_count,
 MAX(B.dwh_updated) OVER (PARTITION BY CAST(A.client_id AS STRING), CAST(A.wh_id AS STRING) RANGE BETWEEN
  UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dwh_updated
FROM ldl_logop_data.t_lpv_ast_1 AS A
 LEFT JOIN ldl_logop_data.t_lpv_bestand_1 AS B ON A.client_id = B.client_id AND A.wh_id = B.wh_id AND A.article_nr = B.article_nr
   
WHERE CURRENT_DATE BETWEEN A.dwh_valid_from AND A.dwh_valid_to
 AND CURRENT_DATE BETWEEN B.dwh_valid_from AND B.dwh_valid_to
 AND NOT A.deleted_fg
 AND NOT B.deleted_fg;