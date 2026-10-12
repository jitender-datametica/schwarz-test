/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CHARGER_CLASSIFICATION_2
   generated from Powerdesigner on Mittwoch, 9. Juli 2025 09:38:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CHARGER_CLASSIFICATION_2 (
   CHARGER_CLASSIFICATION_ID           NUMBER(38, 0)   NOT NULL COMMENT 'Unique identifier of the classification of a charger.',
   CHARGER_LABEL_PREFIX_CD             VARCHAR(50)     NOT NULL COMMENT 'Business/Natural Key - The first letter of the label a charger can have that define the division.',
   CHARGER_PROVIDER_SYSTEM_CD          VARCHAR(50)     NOT NULL COMMENT 'Business/Natural Key - The provider system of the charger.',
   CHARGER_POWER_CLASS_CD              VARCHAR(50)     NOT NULL COMMENT 'Business/Natural Key - The code defining the ability of the charger to charge different types of vehicles.',
   CHARGER_CLASSIFICATION_NAME         VARCHAR(100)    NOT NULL COMMENT 'Descriptive Attribute - The name of the charger classification.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CHARGER_CLASSIFICATION PRIMARY KEY (CHARGER_CLASSIFICATION_ID) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Provides a classification on chargers based on their provider, division and provided power. - Source - Manual';
