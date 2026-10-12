/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_REGIONAL_PRODUCT_MANAGER_2
   GENERATED FROM POWERDESIGNER ON Donnerstag, 19. September 2024 10:36:52
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_REGIONAL_PRODUCT_MANAGER_2 (
   WSHOP_CD                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
   REG_PROD_MANAGER_CD                 VARCHAR(10)     NOT NULL COMMENT 'A code indentifiyng the regional product manager.',
   REG_PROD_MANAGER_NAME               VARCHAR(100)    COMMENT 'Full name (first name + family name) of the regional product manager.',
   REG_PROD_MANAGER_TEAM_NAME          VARCHAR(100)    COMMENT 'Name of the team to which the regional product manager belongs.',
   REG_PROD_MANAGER_TEAM_LEAD_NAME     VARCHAR(100)    COMMENT 'Full name (first name + family name) of the person who is the leader of the regional product management team.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_DIM_REGIONAL_PRODUCT_MANAGER PRIMARY KEY (WSHOP_CD, REG_PROD_MANAGER_CD) NOT ENFORCED 
)  COMMENT = 'This minor dimension contains data about regional product managers, their respective teams and team lead names.';
