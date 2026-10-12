--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.check_umsatz_s122 ;
CREATE TABLE DBP_ETL.check_umsatz_s122  (
 quellsystem                VARCHAR( 2)
,dat_bon                    VARCHAR( 8)
,kasse_schl                 VARCHAR( 4)
,wup_id                     INTEGER
,kasse_krs_id               VARCHAR( 5)
,kassierer_id               INTEGER
,kasse_nr                   INTEGER
,journal_code               VARCHAR( 4)
,vtweg_id                   VARCHAR( 2)
,vkorg_id                   VARCHAR( 4)
,bezirk_id                  VARCHAR( 6)
,wrg_id                     VARCHAR( 5)
,anz_bon_sap                INTEGER
,anz_bonpos_sap             INTEGER
,anz_abbruch_sap            INTEGER
,anz_bonstorno_sap          INTEGER
,anz_sofortstorno_sap       INTEGER
,anz_zeilenstorno_sap       INTEGER
,umsatz_netto_sap           DECIMAL(18,2) DEFAULT 0.00
,umsatz_brutto_sap          DECIMAL(18,2) DEFAULT 0.00
,wert_abbruch_sap           DECIMAL(18,2) DEFAULT 0.00
,wert_bonstorno_sap         DECIMAL(18,2) DEFAULT 0.00
,wert_sofortstorno_sap      DECIMAL(18,2) DEFAULT 0.00
,umsatz_brutto_kassennr_sap DECIMAL(18,2) DEFAULT 0.00
,wert_zeilenstorno_sap      DECIMAL(18,2) DEFAULT 0.00
,td_insert                  TIMESTAMP_LTZ(9)
,td_update                  TIMESTAMP_LTZ(9)
)
;

