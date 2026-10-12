/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_COMPETITOR
   GENERATED FROM POWERDESIGNER ON Montag, 29. Juli 2024 17:13:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COMPETITOR (
   COMPETITOR_CD                       VARCHAR(20)     NOT NULL COMMENT 'The unique code for the Competitor. ',
   COMPETITOR_GROUP_CD                 VARCHAR(20)     COMMENT 'The unqiue code that identifies different Competitor Groups.',
   COMPETITOR_NAME                     VARCHAR(300)    COMMENT 'The name of the competitor organization.',
   COMPETITOR_GROUP_NAME               VARCHAR(100)    COMMENT 'The name of the competitor group.',
   COMPETITOR_CLASS_NAME               VARCHAR(100)    COMMENT 'Classification of the Competitor, based on the characteristics of the competitors e.g. Generalist or Specialist',
   WSHOP_CD                            VARCHAR(5)      COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country and is run by an Lidl Digital Country',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_COMPETITOR PRIMARY KEY (COMPETITOR_CD) NOT ENFORCED 
)  COMMENT = 'A dimension table that describes the competitors. Competitor is an organization that engages in economic competition with LIDL webshops. e.g Amazon.de, Mediamarkt.de etc.';
