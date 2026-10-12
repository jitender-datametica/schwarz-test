TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(       CTRCODE
      , ARTIKELNR
      , GUELTIG_AB
      , KREDNR
      , GROUPNR
      , GUELTIG_BIS
      , WAEHRUNGSKNZ_1 
      , EKPREIS
      , GROUP_GUELTIG_BIS
      , ANLIEFERUNGSARTKZL
      , DATUM
      , BEDIENER
      , GESELLSCHAFTSNR
      , ACTIVEIND
      , DELETEDFLAG
      , KDRESTLAUFZEIT
      , MHDKNZKD
      , FILRESTLAUFZEIT
      , MHDKNZFIL
      , LGRESTLAUFZEIT
      , MHDKNZLG
      , MARKE
      , MANUFACT_COUNTRY
      , ORIGIN_COUNTRY
      , PALLET_SIZE
      , LISTENKNZNR
      , CONTAINER_ID
      , SAP_CONDNO
      , SCN
      , MIN_ORD_QTY
      , MIN_ORD_UNIT
      , SHELFLIFE_TYPE
      , EXTRACTION_TMSP
    --------------------------------
      , SOURCE_SYSTEM
      , EXTRACTION_DT
      , DWH_MAPPING_TMSP
      , TF_ERROR_FG
      , DELETED_FG
      , RECORD_ID
      , FILENAME
      , DWH_NODE_CD
      , DWH_LOAD_ID
)
SELECT 
        LEFT( src.CTRCODE, 2) as CTRCODE
      , src.ARTIKELNR
      , src.GUELTIG_AB
      , src.KREDNR
      , src.GROUPNR
      , src.GUELTIG_BIS
      , src.WAEHRUNGSKNZ_1 
      , src.EKPREIS
      , src.GROUP_GUELTIG_BIS
      , src.ANLIEFERUNGSARTKZL
      , src.DATUM
      , src.BEDIENER
      , src.GESELLSCHAFTSNR
      , src.ACTIVEIND
      , src.DELETEDFLAG
      , src.KDRESTLAUFZEIT
      , src.MHDKNZKD
      , src.FILRESTLAUFZEIT
      , src.MHDKNZFIL
      , src.LGRESTLAUFZEIT
      , src.MHDKNZLG
      , src.MARKE
      , src.MANUFACT_COUNTRY
      , src.ORIGIN_COUNTRY
      , src.PALLET_SIZE
      , src.LISTENKNZNR
      , src.CONTAINER_ID
      , src.SAP_CONDNO
      , src.SCN
      , src.MIN_ORD_QTY
      , src.MIN_ORD_UNIT
      , src.SHELFLIFE_TYPE
      , src.EXTRACTION_TMSP
    --------------------------------
      , 'WAWI'                 AS SOURCE_SYSTEM
      , CURRENT_DATE                 AS EXTRACTION_DT
      , current_timestamp            AS DWH_MAPPING_TMSP
      , 0                      AS TF_ERROR_FG
      , 0                      AS DELETED_FG
      , 0                      AS RECORD_ID
      , '${SRC_INPUT_TABLE}'         AS FILENAME
      , 'WAWI_HQ'              AS DWH_NODE_CD
      , '${LOAD_ID}'                 AS DWH_LOAD_ID
FROM ${TEMP_DB}.${SRC_INPUT_TABLE} src
INNER JOIN ETL.WAWI_CONTROL_TABLE_1 ctrl
ON true
AND ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
AND ctrl.SOURCE_STATUS = 'A'
AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
QUALIFY Row_Number() OVER 
(PARTITION BY 
    LEFT( src.CTRCODE, 2), 
    src.ARTIKELNR, 
    src.GUELTIG_AB, 
    src.KREDNR, 
    src.GESELLSCHAFTSNR
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1 
;
