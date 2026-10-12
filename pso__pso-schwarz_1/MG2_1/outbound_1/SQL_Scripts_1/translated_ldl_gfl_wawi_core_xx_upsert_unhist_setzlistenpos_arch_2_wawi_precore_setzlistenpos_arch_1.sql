
TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_t88_sformhead_1;



 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , storeno, ctrcode, datum, bediener, extraction_tmsp, scn, pickingstarttime, euro_pal_used, ref_picklistnr,
 sperrvermerk, setzlistennr, aktpreis_org, istdauer, printno, lagerplatzbereich, pal_partgo_used, aktuellpreis,
 lagerortnr, satas_nr, formdate, tkt_partgo_used, artikelnr, aktuellpreisknz, original_qty, refpicklistquintiq,
 oldordercases, catchweight, decimalcase, wh_nr, bookflag, ewm_status, caseflag, subsequentadd, kommentar,
 originalpicklist, dsac_nr, mwstschl, bestellkartons, listenpreis, tgdate, lagerplatznr, orderarea, dispozeichen,
 artikelbez, ewm_flag, groupno)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  
 'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  '${SRC_INPUT_TABLE}' AS filename,
  src.storeno,
  LEFT(src.ctrcode, 2) AS ctrcode,
  src.datum,
  src.bediener,
  src.extraction_tmsp,
  src.scn,
  src.pickingstarttime,
  src.euro_pal_used,
  src.ref_picklistnr,
  src.sperrvermerk,
  src.setzlistennr,
  src.aktpreis_org,
  src.istdauer,
  src.printno,
  src.lagerplatzbereich,
  src.pal_partgo_used,
  src.aktuellpreis,
  src.lagerortnr,
  src.satas_nr,
  src.formdate,
  src.tkt_partgo_used,
  src.artikelnr,
  src.aktuellpreisknz,
  src.original_qty,
  src.refpicklistquintiq,
  src.oldordercases,
  src.catchweight,
  src.decimalcase,
  src.wh_nr,
  src.bookflag,
  src.ewm_status,
  src.caseflag,
  src.subsequentadd,
  src.kommentar,
  src.originalpicklist,
  src.dsac_nr,
  src.mwstschl,
  src.bestellkartons,
  src.listenpreis,
  src.tgdate,
  src.lagerplatznr,
  src.orderarea,
  src.dispozeichen,
  CAST(NULL AS STRING) AS artikelbez,
  src.ewm_flag,
  src.groupno
 FROM ldl_data_production_etl.setzlistenpos_arch_1 AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table_1 AS ctrl ON ctrl.source_table_name = UPPER('etl.setzlistenpos_arch_1'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY src.setzlistennr, src.artikelnr, src.lagerortnr, src.storeno ORDER BY src.extraction_tmsp
       IS NULL DESC, src.extraction_tmsp DESC)) = 1);