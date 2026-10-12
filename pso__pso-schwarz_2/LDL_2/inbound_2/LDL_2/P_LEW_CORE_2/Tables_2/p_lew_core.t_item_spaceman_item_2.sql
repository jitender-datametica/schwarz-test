/* --------------------------------------------------------------------------------
   DDL for table: t_item_spaceman_item_2
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_ITEM_SPACEMAN_ITEM_2 (
   item_sid                            NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg).',
   spaceman_item_sid                   NUMBER(38,0)    NOT NULL COMMENT 'surrogate key spaceman item_2',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_ITEM_SPACEMAN_ITEM PRIMARY KEY (item_sid, spaceman_item_sid)
       NOT ENFORCED
)
COMMENT = 'This table represents the relation between spaceman items and erp based items (in t_item_2)';
