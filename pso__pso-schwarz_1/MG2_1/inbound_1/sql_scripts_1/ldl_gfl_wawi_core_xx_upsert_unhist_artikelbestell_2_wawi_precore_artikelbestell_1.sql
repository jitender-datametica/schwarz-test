TRUNCATE TABLE ${TARGET_DB}.${TGT_TARGET_TABLE};

INSERT INTO  ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(

      CTRCODE
    , ARTIKELNR
    , DISPONR
    , PALETTENSCHEIN
    , MHDPRUEFUNG
    , AUTOBESTELL
    , BEST_FUEHR
    , GEWICHT
    , ZUSATZ
    , DISPOKNZ
    , COMMODITYCODE
    , DISPO_PERIOD
    , LIEFERZEIT
    , MINDBESTWOCHE
    , DATUM
    , BEDIENER
    , DISPOGRUPNR
    , GEWICHTSARTIKEL
    , ORDER_ONLY
    , ITEMSTATUS_1
    , DIRECT_DELIVERY
    , DISPOBKP
    , AVG_FORCED
    , FILLING_QTY
    , ARTIKEL_INFO
    , PROMO_MENGE
    , PROMO_ENDE
    , MANUELLER_ABGANG
    , SOLLRWG
    , SCN
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
    , ARTIKELNR
    , DISPONR
    , PALETTENSCHEIN
    , MHDPRUEFUNG
    , AUTOBESTELL
    , BEST_FUEHR
    , GEWICHT
    , ZUSATZ
    , NULL AS DISPOKNZ
    , COMMODITYCODE
    , DISPO_PERIOD
    , LIEFERZEIT
    , MINDBESTWOCHE
    , DATUM
    , BEDIENER
    , DISPOGRUPNR
    , GEWICHTSARTIKEL
    , ORDER_ONLY
    , ITEMSTATUS_1
    , DIRECT_DELIVERY
    , DISPOBKP
    , AVG_FORCED
    , FILLING_QTY
    , ARTIKEL_INFO
    , PROMO_MENGE
    , PROMO_ENDE
    , MANUELLER_ABGANG
    , SOLLRWG
    , SCN
    , EXTRACTION_TMSP


    --------------------------------
    , 'WAWI'                             AS SOURCE_SYSTEM
    , CURRENT_DATE                       AS EXTRACTION_DT
    , current_timestamp                  AS DWH_MAPPING_TMSP
    , 0                                  AS TF_ERROR_FG
    , 0                                  AS DELETED_FG
    , 0                                  AS RECORD_ID
    , '${SRC_INPUT_TABLE}'               AS FILENAME
    , 'WAWI_HQ'                          AS DWH_NODE_CD
    , '${LOAD_ID}'                       AS DWH_LOAD_ID
FROM ${TEMP_DB}.${SRC_INPUT_TABLE} src
INNER JOIN ETL.WAWI_CONTROL_TABLE_1 ctrl
ON true
AND ctrl.SOURCE_TABLE_NAME = UPPER('${TEMP_DB}.${SRC_INPUT_TABLE}')
AND ctrl.SOURCE_STATUS = 'A'
AND src.EXTRACTION_TMSP between ctrl.BEGIN_TMSP and ctrl.END_TMSP
QUALIFY Row_Number() OVER 
(PARTITION BY 
    LEFT( src.CTRCODE, 2),
    ARTIKELNR 
 ORDER BY src.EXTRACTION_TMSP DESC
) = 1 
;
