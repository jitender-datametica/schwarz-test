/* --------------------------------------------------------------------------------
   DDL for table: t_ref_spaceman_item_group_2
   generated from Powerdesigner on Dienstag, 10. Januar 2023 11:00:44
*/ --------------------------------------------------------------------------------

CREATE TABLE p_lew_core.T_REF_SPACEMAN_ITEM_GROUP_2 (
   spaceman_item_grp_sid               NUMBER(38,0)    NOT NULL COMMENT 'surrogate key: item_2 group of the item_2 in the space management
            spaceman:tblapproducts:EXTDESC28',
   spaceman_item_grp_name              VARCHAR(100)    COMMENT 'name for the item_2 group of the item_2 in the space management
            spaceman:tblapproducts:EXTDESC28',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
   CONSTRAINT PK_T_REF_SPACEMAN_ITEM_GROUP PRIMARY KEY (spaceman_item_grp_sid)
       NOT enforced
)
COMMENT = 'table contains the different spaceman item_2 group codes';