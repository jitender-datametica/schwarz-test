CREATE OR REPLACE TABLE kfl_production_dbp_data.l_plombe_status (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
plombe_status_id INTEGER NOT NULL
OPTIONS(description='ID des Plomben-Status / Fehlergrunds. (z. B. 0 = kein Fehler, 1 = Unbekannte Plombe, 6 = Plombe fehlt) aus VALPOS.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, plombe_status_id) NOT ENFORCED
)
OPTIONS(description='Lookup-Tabelle für die Status- und Fehlercodes einer Plombe. Quelle: (SAP RET) DD07V (Domäne ZLVPLO_STATUS).');