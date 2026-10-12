CREATE OR REPLACE TABLE DBP_ETL.umsnetto  (
       buchungskreis    VARCHAR( 4)
      ,marktnummer      VARCHAR( 4)
      ,fi_konto         VARCHAR(10)
      ,kontobez         VARCHAR(50)
      ,netto_umsatz     VARCHAR(12)
      ,brutto_umsatz    VARCHAR(12)
      ,steuersatz       VARCHAR( 2)
      ,gjmo             VARCHAR( 6)
      ,td_insert        TIMESTAMP_LTZ(9)
      ,td_update        TIMESTAMP_LTZ(9)
      )
;

CREATE OR REPLACE  TABLE DBP_ETL.artbew_konto_work  (
      mandant_id        BYTEINT         NOT NULL,
      wup_id            INTEGER         NOT NULL,
      konto_id          INTEGER         NOT NULL,
      bewart_id         SMALLINT        NOT NULL,
      nb_id             SMALLINT        NOT NULL,
      arthiertyp_id     BYTEINT         NOT NULL,
      umsatz_brutto     DECIMAL(18,2),
      umsatz_netto      DECIMAL(18,2),
      umsatz_wrg        CHAR(3)         COLLATE 'en-ci',
      umsatz_brutto_konz DECIMAL(18,2),
      umsatz_netto_konz DECIMAL(18,2),
      kjmo              INTEGER
)
;


CREATE OR REPLACE TABLE DBP_ETL.artbew_abt_sum_work  (
      mandant_id        BYTEINT         NOT NULL,
      wup_id            INTEGER         NOT NULL,
      nb_id             SMALLINT        NOT NULL,
      abt_id            SMALLINT        NOT NULL,
      bewart_id         SMALLINT        NOT NULL,
      dat               DATE            NOT NULL,
      arthiertyp_id     BYTEINT         NOT NULL,
      umsatz_brutto     DECIMAL(18,2),
      umsatz_netto      DECIMAL(18,2),
      umsatz_wrg        CHAR(3)         COLLATE 'en-ci',
      umsatz_brutto_konz DECIMAL(18,2),
      umsatz_netto_konz DECIMAL(18,2),
      kjmo              INTEGER         NOT NULL
)
;

