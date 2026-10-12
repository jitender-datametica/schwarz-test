--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.d_tanktresor_help_2 ;

CREATE TABLE DBP_ETL.d_tanktresor_help_2  (
        marktnummer     CHAR(4) COLLATE 'en-ci',
        wg_text         CHAR(40) COLLATE 'en-ci',
        schluessel2     CHAR(20) COLLATE 'en-ci',
        wert            VARCHAR(30) COLLATE 'en-ci',
        datum           CHAR(10) COLLATE 'en-ci',
        td_insert TIMESTAMP_LTZ(9),
        td_update TIMESTAMP_LTZ(9)
      )
;

