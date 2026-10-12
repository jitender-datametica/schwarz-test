CREATE OR REPLACE TABLE kfl_production_dbp_data.l_cos_bonuskauf_status (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
bonuskauf_status_id INTEGER NOT NULL
OPTIONS(description='Gibt den Status des Coupons an.  0 = inaktiv, 1 = aktiv, 2 = widerruft, bzw. inactive, active, revoked respektiv '),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bonuskauf_status_id) NOT ENFORCED
) OPTIONS(description='Lookup-Tabelle für den Status des Coupons.');