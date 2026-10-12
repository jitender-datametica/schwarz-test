CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.BEWART (
BEWART_ID INTEGER NOT NULL
OPTIONS(description='Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (BEWART_ID) NOT ENFORCED
) OPTIONS(description='Enthält alle Bewegungsarten');