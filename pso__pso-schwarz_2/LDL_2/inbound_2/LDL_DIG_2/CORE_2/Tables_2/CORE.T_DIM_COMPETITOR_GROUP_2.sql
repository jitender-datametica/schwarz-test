/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COMPETITOR_GROUP_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 25. Juli 2024 11:06:09
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COMPETITOR_GROUP_2 (
   COMPETITOR_GROUP_CD                 VARCHAR(20)     NOT NULL COMMENT 'The unqiue code that identifies different Competitor Groups.',
   COMPETITOR_GROUP_NAME               VARCHAR(100)    COMMENT 'The name of the competitor group.',
   COMPETITOR_GROUP_CLASS_NAME         VARCHAR(100)    COMMENT 'Classification of the Competitor Group, based on the characteristics of the competitors e.g. Generalist or Specialist',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_COMPETITOR_GROUP PRIMARY KEY (COMPETITOR_GROUP_CD) NOT ENFORCED 
)  COMMENT = 'A minor dimension that contains details for the competitor groups. A competitor group is a group of competitor IDs (competitor_cd) that represent the same business e.g. Amazon.de and Amazon-marketplace.de having different competitor_cd will be grouped together under the same competitor_group_cd such as Amazon. 
             
             The Names of the Competitor groups and which Competitors belong to them is decided by business users in Lidl and is based on the way Lild Users need to group competitors for reporting and comparison. It is not strictly based on legal entities and/or Holding Company - Subsidiary relationships ';
