--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.gastro_finanz_1 ;
CREATE TABLE DBP_ETL.gastro_finanz_1  (
         marktnummer 	INTEGER
        ,creationtime   timestamp(0)
        ,buchzeit       timestamp(0)
        ,neukz          CHAR(1)
        ,schluessel 	CHAR(3)
        ,zm             CHAR(3)
        ,betrag         DECIMAL(18,2)
        ,info1          VARCHAR(20)    
,td_insert TIMESTAMP_LTZ(9)
,td_update TIMESTAMP_LTZ(9)
)
;

