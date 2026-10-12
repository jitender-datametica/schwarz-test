DROP TABLE IF EXISTS DBP_ETL.bon_agg_kassenberichte_tmp_1;
--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.

--Comment from validation checker
--MESSAGE: SQL compilation error:
CREATE TABLE DBP_ETL.bon_agg_kassenberichte_tmp_1  (
      bon_id VARCHAR(25) COLLATE 'en-cs' NOT NULL,
      bon_dat DATE NOT NULL,
      wup_id INTEGER NOT NULL,
      mandant_id BYTEINT NOT NULL,
      kassensystem_name CHAR(10),
      kasse_nr SMALLINT NOT NULL ,
      xml_name VARCHAR(255)
     )
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
INSERT INTO DBP_ETL.bon_agg_kassenberichte_tmp_1
(
    bon_id
   ,mandant_id
   ,wup_id
   ,kassensystem_name
   ,kasse_nr
   ,bon_dat
   ,xml_name
)
SELECT
    bon_id
   ,mandant_id
   ,wup_id
   ,kassensystem_name
   ,kasse_nr
   ,bon_dat
   ,datei_name AS xml_name
FROM DBP_ODS.ods_bon_transaction_1 t2
WHERE t2.bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE-1
;



