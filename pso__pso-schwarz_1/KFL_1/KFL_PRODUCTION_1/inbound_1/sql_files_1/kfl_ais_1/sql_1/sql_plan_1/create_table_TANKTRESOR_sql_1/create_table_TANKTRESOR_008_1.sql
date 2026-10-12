--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.d_tanktresor_help_kunden_1 ;
CREATE TABLE DBP_ETL.d_tanktresor_help_kunden_1  (
      marktnummer       CHAR(4) COLLATE 'en-ci',
      wg_text           CHAR(40) COLLATE 'en-ci',
      schluessel2       CHAR(20) COLLATE 'en-ci',
      wert              CHAR(9) COLLATE 'en-ci',
      datum             CHAR(10) COLLATE 'en-ci'
)
;

