CREATE OR REPLACE TABLE kfl_production_dbp_data.cos_bonuskauf_status_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
bonuskauf_status_id INTEGER NOT NULL
OPTIONS(description='Gibt den Status des Coupons an.  0 = inaktiv, 1 = aktiv, 2 = widerruft, bzw. inactive, active, revoked respektiv'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
bonuskauf_status_bez STRING(200) NOT NULL
OPTIONS(description='Bezeichung des Status des Coupons inaktiv, aktiv,  widerruft, bzw. inactive, active, revoked respektiv'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, bonuskauf_status_id, spr_id) NOT ENFORCED
) OPTIONS(description='Sprachtabelle für den Status des Coupons');