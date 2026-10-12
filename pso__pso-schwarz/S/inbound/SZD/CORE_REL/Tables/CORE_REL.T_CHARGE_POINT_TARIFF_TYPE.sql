/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGE_POINT_TARIFF_TYPE
   generated from Powerdesigner on Mittwoch, 15. November 2023 11:12:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CHARGE_POINT_TARIFF_TYPE (
   CHARGE_POINT_TARIFF_TYPE_CD         VARCHAR(50)     NOT NULL COMMENT 'The unique code of the charge point tariff type.',
   CHARGE_POINT_TARIFF_TYPE_DESCR      VARCHAR(250)    NOT NULL COMMENT 'A brief description of the tariff type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CHARGE_POINT_TARIFF_TYPE PRIMARY KEY (CHARGE_POINT_TARIFF_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - The type of tariff determines whether the charging station can be used by your own customers or employees and/or whether the charging station can also be used by third parties (public). - Source - Manual';
