CREATE OR REPLACE TABLE DBP_ETL.kmo_artbew_bon_delta_main_1 (
  mandant_id  BYTEINT NOT NULL,
  wup_id      INTEGER NOT NULL,
  dat_booking DATE NOT NULL,
  xml_name    VARCHAR(255)
);

INSERT INTO DBP_ETL.kmo_artbew_bon_delta_main_1 (mandant_id
                                              ,wup_id
                                              ,dat_booking
                                              ,xml_name )
SELECT t.mandant_id
      ,t.wup_id
      ,dat_booking
      ,t.datei_name 
FROM DBP_ODS.ods_bon_transaction_1 t

WHERE t.mandant_id > 1 AND TRIM(t.kassensystem_name) = 'KPOS'
  AND CAST(t.bon_booking AS DATE) between '2024-03-01' and '2024-06-30' /*Umsatz maximal bis gestern*/
GROUP BY 1,2,3,4
;
