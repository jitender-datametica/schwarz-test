/* --------------------------------------------------------------------------------
   DDL for table: t_spaceman_item_1
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_SPACEMAN_ITEM_1 (
   int_org_sid                         NUMBER(38,0)    NOT NULL COMMENT 'surrogate key internal organisation',
   spaceman_item_sid                   NUMBER(38,0)    NOT NULL COMMENT 'surrogate key spaceman item_1',
   spaceman_item_nr                    VARCHAR(100)    NOT NULL COMMENT 'identifier of the spaceman item_1 in the source system together with activer_from_dt
            spaceman: UPC',
   active_from_dt                      DATE            NOT NULL COMMENT 'item_1 validity_1 start date within spaceman',
   active_to_dt                        DATE            COMMENT 'item_1 validity_1 end date within spaceman (means item_1 is no longer available in the current spaceman data)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_SPACEMAN_ITEM PRIMARY KEY (spaceman_item_sid)
       NOT ENFORCED
)
COMMENT = 'this table contains the set of items defined in the spaceman database. a surrogate key is necessary due to the fact that the WAWI-item_1-number based key can be reused if the item_1 number is reused in WAWI.';
