/* --------------------------------------------------------------------------------
   DDL for table: t_ref_spaceman_item_segment
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_REF_SPACEMAN_ITEM_SEGMENT (
   spaceman_item_segment_sid           NUMBER(38,0)    NOT NULL COMMENT 'surrogate key_ item segment definition in space management
            spaceman:tblapproducts:DESCJ',
   spaceman_item_segment_name          VARCHAR(100)    COMMENT 'name of the segment of the item in space management
            spaceman:tblapproducts:DESCJ',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_REF_SPACEMAN_ITEM_SEGMENT PRIMARY KEY (spaceman_item_segment_sid)
       NOT enforced
)
COMMENT = 'table contains the different spaceman item segment codes';