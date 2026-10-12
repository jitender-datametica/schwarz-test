/* --------------------------------------------------------------------------------
   DDL for table: t_lil_gfk_category_descr
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_LIL_GFK_CATEGORY_DESCR (
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'unique identifier of the client',
   gfk_cat_sid                         NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key GFK_CATEGORY',
   lang_cd                             VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Sprache - Code',
   gfk_cat_name                        VARCHAR(100)     COLLATE 'en-ci' COMMENT 'Beschreibung GfK-Sub-Kategorie',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefuegt oder veraendert hat',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten fachlichen(!) Aenderung',   
   CONSTRAINT PK_T_LIL_GFK_CATEGORY_DESCR PRIMARY KEY (gfk_cat_sid, lang_cd) NOT ENFORCED 
)  COMMENT = '$Revision: 0000 $ Mehrsprachige Bezeichnungen der Warengruppen-Kategorien fur t_market_subgroup und t_market_household_loyalty';

