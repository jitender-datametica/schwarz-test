TRUNCATE TABLE etl.t_wawi_precore_t201_itemprices_wh;

INSERT INTO etl.t_wawi_precore_t201_itemprices_wh
(
  ctrcode, 
  wh_nr,
  c201_groupnr, 
  c201_itemdesc, 
  c201_vatcode, 
  c201_editedby, 
  c201_lastedited, 
  c201_datefrom, 
  c201_dateto, 
  c201_beverage_tax, 
  c201_price, 
  c201_containerdep, 
  c201_tarecode, 
  c201_itemno, 
  c201_itemnr, 
  c201_reason_id, 
  c201_refdate, 
  c201_pv_flag, 
  scn, 
  c201_linked_deposit_item, 
  extraction_tmsp,
  dwh_created_tmsp,
  dwh_updated_tmsp,  
  dwh_load_id
)
SELECT 
  left( ctrcode, 2) as ctrcode,
  wh_nr,
  c201_groupnr, 
  c201_itemdesc, 
  c201_vatcode, 
  c201_editedby, 
  c201_lastedited, 
  c201_datefrom, 
  c201_dateto, 
  c201_beverage_tax, 
  c201_price, 
  c201_containerdep, 
  c201_tarecode, 
  c201_itemno, 
  c201_itemnr, 
  c201_reason_id, 
  c201_refdate, 
  c201_pv_flag, 
  scn, 
  c201_linked_deposit_item, 
  extraction_tmsp,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP,
  ${LOAD_ID}
FROM etl.t201_itemprices_wh src
INNER JOIN etl.wawi_control_table ctrl ON ctrl.source_table_name = UPPER('etl.t201_itemprices_wh')
                                          AND ctrl.source_status = 'A'
                                          AND src.extraction_tmsp between ctrl.begin_tmsp and ctrl.end_tmsp
QUALIFY ROW_NUMBER() OVER (PARTITION BY ctrcode,wh_nr,c201_groupnr,c201_itemnr,c201_datefrom ORDER BY src.extraction_tmsp DESC ) = 1
-- Changed on 28.FEB.2025
-- QUALIFY ROW_NUMBER() OVER (PARTITION BY c201_groupnr,c201_itemnr,c201_datefrom ORDER BY src.extraction_tmsp DESC ) = 1
;
