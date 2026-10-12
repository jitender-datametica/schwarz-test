/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CHARGE_POINT_PLUGIN_TYPE
   generated from Powerdesigner on Dienstag, 16. Januar 2024 10:48:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CHARGE_POINT_PLUGIN_TYPE (
   CHARGE_POINT_PLUGIN_TYPE_CD         VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charger plugin type.',
   CHARGE_POINT_PLUGIN_TYPE_NAME       VARCHAR(100)    NOT NULL COMMENT 'The displayable name of the charger plugin type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CHARGE_POINT_PLUGIN_TYPE PRIMARY KEY (CHARGE_POINT_PLUGIN_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - The type of the plugin of a charge point on a charger station. - Source - Manual';
