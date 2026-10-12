
TRUNCATE TABLE ${dm_inferred_target_db}.${tgt_target_table};


--------------------------------


--------------------------------


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_node_cd, tf_error_fg, dwh_load_id, deleted_fg
 , record_id, filename, source_system, extraction_dt, dwh_mapping_tmsp, ctrcode, extraction_tmsp, anlieferungsartkzl,
 marke, min_ord_qty, filrestlaufzeit, gesellschaftsnr, mhdknzkd, pallet_size, artikelnr, ekpreis, manufact_country,
 sap_condno, group_gueltig_bis, datum, deletedflag, bediener, krednr, origin_country, listenknznr, mhdknzlg, gueltig_bis
 , shelflife_type, groupnr, activeind, lgrestlaufzeit, mhdknzfil, waehrungsknz, gueltig_ab, kdrestlaufzeit, min_ord_unit
 , container_id, scn)
(SELECT 'WAWI_HQ' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  LEFT(src.ctrcode, 2) AS ctrcode,
  src.extraction_tmsp,
  src.anlieferungsartkzl,
  src.marke,
  src.min_ord_qty,
  src.filrestlaufzeit,
  src.gesellschaftsnr,
  src.mhdknzkd,
  src.pallet_size,
  src.artikelnr,
  src.ekpreis,
  src.manufact_country,
  src.sap_condno,
  src.group_gueltig_bis,
  src.datum,
  src.deletedflag,
  src.bediener,
  src.krednr,
  src.origin_country,
  src.listenknznr,
  src.mhdknzlg,
  src.gueltig_bis,
  src.shelflife_type,
  src.groupnr,
  src.activeind,
  src.lgrestlaufzeit,
  src.mhdknzfil,
  src.waehrungsknz,
  src.gueltig_ab,
  src.kdrestlaufzeit,
  src.min_ord_unit,
  src.container_id,
  src.scn
 FROM ${temp_db}.${src_input_table} AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table AS ctrl ON ctrl.source_table_name = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY LEFT(src.ctrcode, 2), src.artikelnr, src.gueltig_ab, src.krednr, src.gesellschaftsnr
       ORDER BY src.extraction_tmsp IS NULL DESC, src.extraction_tmsp DESC)) = 1);