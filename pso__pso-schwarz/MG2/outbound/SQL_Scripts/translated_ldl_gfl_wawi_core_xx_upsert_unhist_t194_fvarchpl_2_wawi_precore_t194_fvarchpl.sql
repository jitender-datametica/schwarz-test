
TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_t194_fvarchpl;



 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , ctrcode, extraction_tmsp, scn, wh_nr, c194_pickingstarttime, c194_formdate, c194_whprice, c194_orderunit, c194_whnr,
 c194_editreason, c194_storagearea, c194_storenr, c194_dayenddate, c194_vatcode, c194_dsac_nr, c194_decimalcase,
 c194_orderdpieces, c194_orderarea, c194_id, c194_ref_picklistnr, c194_orderdcases, c194_oldstoreprice, c194_slotno,
 c194_ewm_status, c194_tgstatus, c194_picklistnr, c194_subitemnr, c194_ewm_flag, c194_satas_nr, c194_countryorigin,
 c194_refpicklistquintiq, c194_istdauer, c194_initialorders, c194_itemnr, c194_stpricegroup, c194_bookflag,
 c194_caseflag, c194_original_qty, c194_originalpicklist, c194_storeprice, c194_actualpieces, c194_catchweight,
 c194_realcasesize)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  
 'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${SRC_INPUT_TABLE}' AS filename,
  LEFT(src.ctrcode, 2) AS ctrcode,
  src.extraction_tmsp,
  src.scn,
  src.wh_nr,
  src.c194_pickingstarttime,
  src.c194_formdate,
  src.c194_whprice,
  src.c194_orderunit,
  src.c194_whnr,
  src.c194_editreason,
  src.c194_storagearea,
  src.c194_storenr,
  src.c194_dayenddate,
  src.c194_vatcode,
  src.c194_dsac_nr,
  src.c194_decimalcase,
  src.c194_orderdpieces,
  src.c194_orderarea,
  src.c194_id,
  src.c194_ref_picklistnr,
  src.c194_orderdcases,
  src.c194_oldstoreprice,
  src.c194_slotno,
  src.c194_ewm_status,
  src.c194_tgstatus,
  src.c194_picklistnr,
  src.c194_subitemnr,
  src.c194_ewm_flag,
  src.c194_satas_nr,
  src.c194_countryorigin,
  src.c194_refpicklistquintiq,
  src.c194_istdauer,
  src.c194_initialorders,
  src.c194_itemnr,
  src.c194_stpricegroup,
  src.c194_bookflag,
  src.c194_caseflag,
  src.c194_original_qty,
  src.c194_originalpicklist,
  src.c194_storeprice,
  src.c194_actualpieces,
  src.c194_catchweight,
  src.c194_realcasesize
 FROM ldl_data_production_etl.t194_fvarchpl AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table AS ctrl ON ctrl.source_table_name = UPPER('etl.t194_fvarchpl')
    AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY src.c194_id, src.c194_itemnr, src.c194_picklistnr, CAST(src.c194_realcasesize AS STRING)
       , src.c194_subitemnr, src.c194_whnr ORDER BY src.extraction_tmsp IS NULL DESC, src.extraction_tmsp DESC)) = 1);