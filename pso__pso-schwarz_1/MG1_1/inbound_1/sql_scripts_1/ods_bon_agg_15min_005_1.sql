--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.bon_agg_kassenberichte_1;

CREATE TABLE DBP_ETL.bon_agg_kassenberichte_1  (
      wup_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      bon_dat DATE NOT NULL
     )
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

INSERT INTO DBP_ETL.bon_agg_kassenberichte_1
(
    mandant_id
   ,wup_id
   ,kassensystem_name
   ,kasse_nr
   ,bon_dat
)
SELECT
    mandant_id
   ,wup_id
   ,kassensystem_name
   ,kasse_nr
   ,bon_dat
FROM DBP_ETL.bon_agg_kassenberichte_tmp_1 t1_1
GROUP BY 1,2,3,4,5
;

