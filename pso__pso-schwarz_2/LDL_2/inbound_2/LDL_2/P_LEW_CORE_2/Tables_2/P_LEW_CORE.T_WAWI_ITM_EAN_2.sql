/* --------------------------------------------------------------------------------
   DDL for table: t_wawi_itm_ean_2
   generated from Powerdesigner on Freitag, 27. Oktober 2023 10:49:42
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_WAWI_ITM_EAN_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'DWH-Mandant_2; FK auf CLIENT; table name before the trans-all migration: client_id',
   item_sid                            NUMBER(38,0)    NOT NULL COMMENT 'Systemgenerierte Artikelnummer; table name before the trans-all migration: item_sid',
   dat_rec_start                       DATE            NOT NULL COMMENT 'column name before the trans-all migration: dat_rec_start',
   dat_rec_end                         DATE            NOT NULL COMMENT 'column name before the trans-all migration: dat_rec_end',
   ean_2                                 VARCHAR(13)     COLLATE 'en-ci' NOT NULL COMMENT 'column name before the trans-all migration: ean_2',
   ean_item_desc                       VARCHAR(50)     COMMENT 'column name before the trans-all migration: ean_item_desc',
   ean_item_long_descr                 VARCHAR(250)    COMMENT 'extended desription of the EAN_2
            WAWI: ARTEANCODES.ONLINE_DESC',
   custom_nr                           VARCHAR(100)    COLLATE 'en-ci' COMMENT 'column name before the trans-all migration: custom_nr',
   custom_key                          VARCHAR(100)    COLLATE 'en-ci' COMMENT 'column name before the trans-all migration: custom_key',
   language_id                         NUMBER(38,0)    NOT NULL COMMENT 'Sprache; table name before the trans-all migration: language_id',
   load_id                             NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat; table name before the trans-all migration: load_id',   
   CONSTRAINT PK_T_WAWI_ITM_EAN PRIMARY KEY (client_id, item_sid, dat_rec_start, ean_2, language_id) NOT ENFORCED 
)  COMMENT = '$Revision: 5995 $. Auto Generated  9/27/2017';
