/*
====================================================================================================
Division		|	Lidl
Solution		|	Operational Logistics (LOGOP)
DB schema		|	fe_mstr_logop
DB table/view	|	v_lpv_warehouseutilization_add_1
Description		|	lpv warehouseutilization - view with additional columns
====================================================================================================
*/


CREATE OR REPLACE VIEW ldl_logop_fe_mstr_logop.v_lpv_warehouseutilization_add_1 (client_id
OPTIONS(description='Client id - calculated based on the country_1 code'), wh_id
OPTIONS(description='Warehouse ID. Subset of Warehouse Number (lagernummer)'), gr_date
OPTIONS(description='GR date. Original name - datum'), location_id
OPTIONS(description='Internal location_1 number. Primary key. Original name - ORT'), location_name
OPTIONS(description='Location_1 label. Original name - BEZ'), gang_nr
OPTIONS(description='Calculated from FIXBIN_ID - the first 2 digits of location_1 ID'), area_nr
OPTIONS(description='Number of the area the stock is currently located in. FK: References LPV.BEREICH.NR. Original name - BEREICH'),
src_area_nr OPTIONS(description='Number of the area the stock is currently located in. Original name - bereich'),
stock_id OPTIONS(description='Surrogate key: Internal ID. Primary key. Original name - bestandid'), src_pallet_nr
OPTIONS(description='Number of the pallet on which the stock is located. Original name - lhmnr'), article_nr
OPTIONS(description='Article number. Original name - anr'), block_cd
OPTIONS(description='Whether the location_1 is currently locked. V = No block. S = Blocked. Original name - SPERRE'),
capacity OPTIONS(description='Location_1 capacity. Original name - PLATZ'), capacity_available
OPTIONS(description='Free location_1 capacity. Original name - PLATZ_V'), picking_indicator
OPTIONS(description='Indicator whether the location_1 is assigned to an article as a picking laction (table LPV.ASTBER). Original name - FIXPLATZ'),
src_qty
OPTIONS(description='Quantity (number of pieces of unit_1 AST.VPE1). May be multiplied in order to display decimal places according to the global setting MengenFakt. Original name - menge'),
dwh_updated OPTIONS(description='Record updated at'), dwh_valid_from OPTIONS(description='Valid from date'),
dwh_valid_to OPTIONS(description='Valid to date')) AS WITH WHX AS (SELECT client_id,
   wh_id,
   location_id,
   location_name,
   CONCAT('Aisle', ' ', SUBSTR(location_id, 1, 2)) AS gang_nr,
   area_nr,
   IF(block_cd = 'S', 'Blocked', 'No Block') AS block_cd,
   IF(capacity >= 1000, capacity / 960000, capacity) AS capacity,
   IF(capacity_available >= 1000, capacity_available / 960000, capacity_available) AS capacity_available,
   picking_indicator,
   dwh_valid_from,
   dwh_valid_to
  FROM ldl_logop_data.t_lpv_whx_1
  WHERE NOT deleted_fg), BESTAND AS (SELECT client_id,
   wh_id,
   gr_date,
   src_area_nr,
   stock_id,
   src_pallet_nr,
   article_nr,
   src_qty,
   dwh_updated
  FROM ldl_logop_data.t_lpv_bestand_1
  WHERE NOT deleted_fg) (SELECT w.client_id,
   w.wh_id,
   be.gr_date,
   w.location_id,
   w.location_name,
   w.gang_nr,
   w.area_nr,
   AREA.area_descr,
   MAX(be.stock_id) AS stock_id,
   MAX(be.src_pallet_nr) AS src_pallet_nr,
   MAX(be.article_nr) AS article_nr,
   w.block_cd,
   w.capacity,
   w.capacity_available,
   w.picking_indicator,
   MAX(be.src_qty) AS src_qty,
   MAX(be.dwh_updated) AS dwh_updated,
   w.dwh_valid_from,
   w.dwh_valid_to
  FROM WHX AS w
   LEFT JOIN BESTAND AS be ON w.client_id = be.client_id AND w.wh_id = be.wh_id AND w.area_nr = be.src_area_nr
   LEFT JOIN ldl_logop_data.t_lpv_area_1 AS AREA ON w.client_id = AREA.client_id AND w.wh_id = AREA.wh_id AND w.area_nr =
     AREA.area_nr
  WHERE w.area_nr BETWEEN 700 AND 899
   AND be.gr_date BETWEEN w.dwh_valid_from AND w.dwh_valid_to
  GROUP BY w.client_id,
   w.wh_id,
   be.gr_date,
   w.location_id,
   w.location_name,
   w.gang_nr,
   w.area_nr,
   AREA.area_descr,
   w.block_cd,
   w.capacity,
   w.capacity_available,
   w.picking_indicator,
   w.dwh_valid_from,
   w.dwh_valid_to);