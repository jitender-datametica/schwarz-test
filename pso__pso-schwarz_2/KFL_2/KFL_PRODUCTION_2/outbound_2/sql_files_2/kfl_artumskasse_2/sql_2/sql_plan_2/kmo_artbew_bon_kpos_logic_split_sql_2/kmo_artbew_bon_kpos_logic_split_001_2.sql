CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_bon_delta_main_2 (
    mandant_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    dat_booking DATE NOT NULL,
    xml_name STRING(255)
);


/* Umsatz maximal bis gestern */ INSERT INTO dbp_etl.kmo_artbew_bon_delta_main_2 (
    mandant_id, wup_id,
    dat_booking, xml_name
)
(
    SELECT
        mandant_id,
        wup_id,
        dat_booking,
        datei_name
    FROM dbp_ods.ods_bon_transaction_2 AS T
    WHERE
        mandant_id > 1
        AND TRIM(kassensystem_name) = 'KPOS'
        AND DATE(bon_booking) BETWEEN DATE '2024-03-01' AND DATE '2024-06-30'
    GROUP BY
        mandant_id,
        wup_id,
        datei_name,
        dat_booking
);
