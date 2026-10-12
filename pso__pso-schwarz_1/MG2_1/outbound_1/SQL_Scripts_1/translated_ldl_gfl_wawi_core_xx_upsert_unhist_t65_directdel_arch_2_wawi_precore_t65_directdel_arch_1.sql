
TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_t65_directdel_arch_1;



 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , ctrcode, extraction_tmsp, scn, aktpreis_org, artikelnr, decimalcase, wh_nr, kommentar, mwstschl, tgdate, orderarea,
 status_1, preisknz, tgstatus, mdddatum, vkpnorm, krednr, mddretourenknz, mengestueck, mddwedatum, c65_dd_type, id,
 rsdflag, weposid, aktpreis, lieferscheinnr, mengekartons, aktpreisknz, ddmatched, mddfilialnr, c65_deleted, c65_deltype
 , disponr, gesellschaftsnr, mddbediener, buchdatum, groupnr)
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
  src.aktpreis_org,
  src.artikelnr,
  src.decimalcase,
  src.wh_nr,
  src.kommentar,
  src.mwstschl,
  src.tgdate,
  src.orderarea,
  src.status_1,
  src.preisknz,
  src.tgstatus,
  src.mdddatum,
  src.vkpnorm,
  src.krednr,
  src.mddretourenknz,
  src.mengestueck,
  src.mddwedatum,
  src.c65_dd_type,
  src.id,
  src.rsdflag,
  src.weposid,
  src.aktpreis,
  src.lieferscheinnr,
  src.mengekartons,
  src.aktpreisknz,
  src.ddmatched,
  src.mddfilialnr,
  src.c65_deleted,
  src.c65_deltype,
  src.disponr,
  src.gesellschaftsnr,
  src.mddbediener,
  src.buchdatum,
  src.groupnr
 FROM ldl_data_production_etl.t65_directdel_arch_1 AS src
  INNER JOIN ldl_data_production_etl.wawi_control_table_1 AS ctrl ON ctrl.source_table_name = UPPER('etl.t65_directdel_arch_1'
      ) AND ctrl.source_status = 'A' AND src.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY src.id, src.artikelnr, src.gesellschaftsnr, src.mddretourenknz ORDER BY src.extraction_tmsp
       IS NULL DESC, src.extraction_tmsp DESC)) = 1);