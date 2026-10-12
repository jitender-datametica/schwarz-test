/* FOR PARAMETER WRITEBACK FROM MSI TO MODEL */
CREATE TABLE CORE.TS_HADOOP_PARAMETERS_WBS(
	MANDANT_ID NUMBER(38,0)  COMMENT 'Mandant ID',
    LAND_ID VARCHAR(255) COMMENT 'Land ID', -- kann nach der Migration weg 
    DISCOUNT_STEPS NUMBER(38,0)  COMMENT 'Abstand zwischen zwei Rabatten - Pflege uebers Frontend',
    PRICE_ENDING VARCHAR(255)  COMMENT 'User Parameter for Price Threshold', -- brauchen wir dies wirklich ?? 
    DISCOUNT_COUNT NUMBER(38,0)  COMMENT 'Max. Anzahl der Rabattierung - Pflege uebers Frontend',
    MIN_DISCOUNT NUMBER(38,0)  COMMENT 'Mindest Rabatt - Pflege uebers Frontend',
    MAX_DISCOUNT NUMBER(38,0) COMMENT 'Maximaler Rabatt - Pflege uebers Frontend',
    MIN_PRICE FLOAT  COMMENT 'min. Warenwert - Pflege uebers Frontend',
    NO_TOUCH_TIME NUMBER(38,0)  COMMENT 'No Touch Zeitraum- Pflege uebers Frontend',
    TIME_BTW_DISCOUNTS NUMBER(38,0)  COMMENT 'Anzahl Tage zwischen zwei Rabatten - Pflege uebers Frontend',
    DISCOUNT_DAYS VARCHAR(255)  COMMENT 'Wochentag des Rabatts - Pflege uebers Frontend',
    CREATED_AT TIMESTAMP_NTZ(9)  COMMENT 'Zeitpunkt der Erstellung der Parameter',
    USER_ID VARCHAR(100)  COMMENT 'Ersteller',
    VALID_TO_NUMBER_OF_DAYS NUMBER(38,0)  COMMENT 'Preisgueltigkeit - Pflege uebers Frontend',
    PRICE_ENDING_THRESHOLD NUMBER(38,0)  COMMENT 'Preisendung - Pflege uebers Frontend',
    MAX_DISCOUNT_FOR_MAX_PRICE NUMBER(38,0)  COMMENT 'Max Rabatt ab Wert x - Pflege uebers Frontend',
    MAX_PRICE_FOR_MAX_DISCOUNT NUMBER(38,0)  COMMENT 'Wert x fuer anderen max Rabatt - Pflege uebers Frontend',
    DISCOUNT_ENDING NUMBER(38,0)  COMMENT 'Rundung auf Rabatt: 0 - Rabatt 1 - Preis - Pflege uebers Frontend',
    DATES_BTW_DISCOUNTS NUMBER(38,0) COMMENT 'Zweiter Rabatt muss innerhalb dieser Tage gegeben werden'
);