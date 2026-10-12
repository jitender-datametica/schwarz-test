--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.fww_wme_kopf_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.fww_wme_kopf_1  (
         mandant_1                  CHAR( 3)
        ,aktionsnummer            CHAR(10) COLLATE 'en-ci'
        ,aktionsart               CHAR( 4)
        ,werbekategorie           CHAR(18)
        ,gueltig_ab               CHAR(10)
        ,gueltig_bis              CHAR(10)
        ,status_1                   CHAR( 1)
        ,werbekategorie_bez       CHAR(60)
        ,aktionsart_bez           CHAR(20)
        ,spras                    CHAR( 1)
     )

;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.fww_wme_kopf_tmp_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.fww_wme_kopf_tmp_1  (
      mandant_id        BYTEINT ,
      sap_werbe_kat_id  CHAR(4) ,
      werbe_kat_id      INTEGER  ,
      werbekategorie_bez CHAR(40) COLLATE 'en-cs',
      SPRAS             CHAR(1) COLLATE 'en-ci'
      )
;

