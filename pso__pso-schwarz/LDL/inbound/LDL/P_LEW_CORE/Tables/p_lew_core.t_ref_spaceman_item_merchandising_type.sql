/* --------------------------------------------------------------------------------
   DDL for table: t_ref_spaceman_item_merchandising_type
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_REF_SPACEMAN_ITEM_MERCHANDISING_TYPE (
   item_merchandising_type_cd          VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'Merchandising Type (Case/Hand/DD/EP)
            spaceman:tblapposition:MERCHANDISINGTYPE',
   item_merchandising_type_descr       VARCHAR(100)    COMMENT 'Description of the Merchandising Type.',
   shelf_capacity_type_cd              NUMBER(38,0)    COMMENT 'The numeric code of the shelf capacity type mapped to the merchandising type.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH.',
   CONSTRAINT PK_REF_SPACEMAN_ITEM_MERCHANDISING_TYPE PRIMARY KEY (item_merchandising_type_cd)
       NOT ENFORCED
)
COMMENT = 'This table contains the different merchandising type codes for items/cases in positions.';
