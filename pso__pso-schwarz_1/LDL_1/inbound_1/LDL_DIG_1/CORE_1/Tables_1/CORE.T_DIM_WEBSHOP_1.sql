CREATE TABLE CORE.t_dim_webshop_1 (
   wshop_cd                            VARCHAR(5)      NOT NULL COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_1 and is run by an Lidl Digital Country_1',
   wshop_name_de                       VARCHAR(250)    NOT NULL COMMENT 'The name for the Lidl webshop, where an order can be placed by a customer',
   wshop_name_en                       VARCHAR(250)    COMMENT 'The name for the Lidl webshop, where an order can be placed by a customer in English.',
   wshop_display_order_nr              NUMBER          COMMENT 'The number indicates in which order the webshop will appear in front end ',
   country_cd                          VARCHAR(5)      COMMENT 'The unique code for a country_1 according to ISO-3166 Alpha-2. E.g. \DE\ for Germany or \FR\ for France',
   dwh_created_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT pk_t_dim_webshop PRIMARY KEY (wshop_cd)
)COMMENT = 'There is one webshop per each country_1 where Lidl webshop operates. The gobal weshop has a code ''INT''';
