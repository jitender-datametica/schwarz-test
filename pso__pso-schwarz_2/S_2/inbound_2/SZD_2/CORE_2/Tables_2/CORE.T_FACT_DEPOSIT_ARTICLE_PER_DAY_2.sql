CREATE TABLE CORE.t_fact_deposit_article_per_day_2 (
   item_sid             NUMBER     NOT NULL COMMENT 'The unique identifier for an item_2',
   rvm_sid              NUMBER     NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
   lob_cd               VARCHAR(50)  NOT NULL COMMENT 'The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland lob=line os business',
   country_pol_cd       VARCHAR(2)  NOT NULL COMMENT 'The code identifying a political country_2 according to ISO 3166.',
   item_gtin            VARCHAR(20) NOT NULL COMMENT 'A European article number',
   return_dt            DATE       NOT NULL COMMENT 'The date for returned deposit articles.',
   return_cnt           NUMBER     NOT NULL COMMENT 'The number for the item_2 return',
   item_container_type_cd VARCHAR(50)  NOT NULL COMMENT 'The description of a container which can be foreign or own container',
   dwh_created_tmsp     TIMESTAMP_LTZ NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   dwh_updated_tmsp     TIMESTAMP_LTZ NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_FACT_DEPOSIT_ARTICLE_PER_DAY PRIMARY KEY (item_sid, rvm_sid, return_dt) NOT ENFORCED
) COMMENT = 'A table for the deposit articles per day of RVMs';
