TRUNCATE TABLE ldl_data_production_etl.t_wawi_precore_dispogruppen_2;
INSERT INTO ldl_data_production_etl.t_wawi_precore_dispogruppen_2 (CTRCODE, DISPOGRUPNR, DISPOGRUPBEZ, DATUM, BEDIENER, VORAUSTAGE, SCN, EXTRACTION_TMSP, DWH_CREATED_TMSP, DWH_UPDATED_TMSP, DWH_LOAD_ID)
  SELECT
      left(CTRCODE, 2) AS CTRCODE,
      DISPOGRUPNR,
      DISPOGRUPBEZ,
      DATUM,
      BEDIENER,
      VORAUSTAGE,
      SCN,
      EXTRACTION_TMSP,
      current_timestamp() AS DWH_CREATED_TMSP,
      current_timestamp() AS DWH_UPDATED_TMSP,
      cast('${LOAD_ID}' as bignumeric) AS DWH_LOAD_ID
    FROM
      ldl_data_production_etl.dispogruppen_2 AS SRC
      INNER JOIN ldl_data_production_etl.wawi_control_table_2 AS CTRL ON CTRL.SOURCE_TABLE_NAME = upper('etl.dispogruppen_2')
       AND CTRL.SOURCE_STATUS = 'A'
       AND SRC.EXTRACTION_TMSP BETWEEN CTRL.BEGIN_TMSP AND CTRL.END_TMSP
    QUALIFY row_number() OVER (PARTITION BY CTRCODE, DISPOGRUPNR ORDER BY if(SRC.EXTRACTION_TMSP IS NULL, 0, 1), SRC.EXTRACTION_TMSP DESC) = NUMERIC '1'
;
