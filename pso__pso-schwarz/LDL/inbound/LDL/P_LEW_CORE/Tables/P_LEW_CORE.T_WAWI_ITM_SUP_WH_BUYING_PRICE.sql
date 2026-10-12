CREATE TABLE P_LEW_CORE.T_WAWI_ITM_SUP_WH_BUYING_PRICE (
   client_id                           NUMERIC(38,0)   NOT NULL,
   wh_loc_sid                          NUMERIC(38,0)   NOT NULL,
   item_sid                            NUMERIC(38,0)   NOT NULL,
   sup_sid                             NUMERIC(38,0)   NOT NULL,
   dat_rec_start                       DATE            NOT NULL,
   dat_rec_end                         DATE            NOT NULL,
   dat_valid_from                      DATE            NOT NULL,
   dat_valid_until                     DATE,
   dat_valid_until_group               DATE,
   currency_nr                         NUMERIC(38,0),
   group_nr                            NUMERIC(18,0),
   delivery_item_cd                    VARCHAR(3)      COLLATE 'en-ci',
   dur_shelflife_cust                  VARCHAR(10)     COLLATE 'en-ci',
   period_id_shelflife_cust            NUMERIC(38,0),
   dur_shelflife_store                 VARCHAR(10)     COLLATE 'en-ci',
   period_id_shelflife_store           NUMERIC(38,0),
   dur_shelflife_wh                    VARCHAR(10)     COLLATE 'en-ci',
   period_id_shelflife_wh              NUMERIC(38,0),
   price_buying                        NUMERIC(38,5)   NOT NULL,
   price_buying_special                NUMERIC(38,5),
   currency_nr_special                 NUMERIC(38,0),
   origin_country_cd                   VARCHAR(3)      COLLATE 'en-ci',
   buying_list_type_id                 NUMERIC(38,0),
   load_id                             NUMERIC(38,0)   NOT NULL,   
   CONSTRAINT PK_T_WAWI_ITM_SUP_WH_BUYING_PRICE PRIMARY KEY (client_id) NOT ENFORCED 
)  COMMENT = '2Do:
             table comment
             PK';
