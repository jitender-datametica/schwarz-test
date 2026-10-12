--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.d_umsnetto_tag_1 ;

CREATE TABLE DBP_ETL.d_umsnetto_tag_1  (
       buchungskreis       VARCHAR( 4)
      ,marktnummer         VARCHAR( 4)
      ,fi_konto            VARCHAR(10)
      ,kontobez            VARCHAR(50)
      ,netto_umsatz        VARCHAR(12)
      ,brutto_umsatz       VARCHAR(12)
      ,steuersatz          VARCHAR( 2)
      ,datum               VARCHAR(10) 
      ,td_insert TIMESTAMP_LTZ(9)
      ,td_update TIMESTAMP_LTZ(9)
      )
;

