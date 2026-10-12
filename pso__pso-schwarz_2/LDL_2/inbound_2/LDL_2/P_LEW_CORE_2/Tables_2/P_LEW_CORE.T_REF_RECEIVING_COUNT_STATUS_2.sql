CREATE TABLE P_LEW_CORE.T_REF_RECEIVING_COUNT_STATUS_2 (
   rcv_cnt_status_id                NUMBER(38,0)    NOT NULL COMMENT 'status_2 identifier of the counting and processing of the location_item_incoming row',
   rcv_cnt_status_descr             VARCHAR(100)    NOT NULL COMMENT 'description of the status_2 identifier of the counting and processing of the location_item_incoming row',
   dwh_load_id                      NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                      TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated             	      TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_REF_RECEIVING_COUNT_STATU PRIMARY KEY (rcv_cnt_status_id)
       NOT enforced
)
COMMENT = '$Revision: 0000 $. table contains possible status_2 identifiers of the counting and processing of the location_item_incoming row
          Source: static, WAWI field C174_ITEMSTATUS';