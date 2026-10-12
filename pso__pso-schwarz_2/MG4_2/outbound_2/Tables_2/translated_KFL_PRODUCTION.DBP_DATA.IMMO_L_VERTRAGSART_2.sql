CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_l_vertragsart_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
vertragsart_id INTEGER NOT NULL OPTIONS(description='Vertragsart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, vertragsart_id) NOT ENFORCED
) OPTIONS(description='IMMO - Art_2 des Vermietungsvertrags  - SAP REFX - TIV2F');