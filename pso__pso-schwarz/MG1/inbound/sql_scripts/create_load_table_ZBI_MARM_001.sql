--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_marm;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.kmo_marm  (
  matnr            INTEGER 
, matnr_char VARCHAR(36) COLLATE 'de-ci'
, quellsystem      VARCHAR (2)   COLLATE 'de-ci'
, MEINH            VARCHAR (6)   COLLATE 'de-ci'                   
, BRGEW            DECIMAL(18,3)
, GEWEI            VARCHAR (6)   COLLATE 'de-ci'                  
, UMREZ            DECIMAL(18,3)                  
, UMREN            DECIMAL(18,3) 
, laenge           DECIMAL(18,3)  
, breite           DECIMAL(18,3)  
, hoehe            DECIMAL(18,3)  
, bezugsdatum      DATE
, mandant_id       BYTEINT
, td_insert        TIMESTAMP_LTZ(9)
)
;

