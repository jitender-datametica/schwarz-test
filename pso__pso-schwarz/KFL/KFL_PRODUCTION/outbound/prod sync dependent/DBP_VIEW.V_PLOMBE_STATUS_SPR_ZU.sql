CREATE OR REPLACE TABLE dbp_data.plombe_status_spr_zu (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
plombe_status_id INTEGER NOT NULL
OPTIONS(description='ID des Plomben-Status / Fehlergrunds. (z. B. 0 = kein Fehler, 1 = Unbekannte Plombe, 6 = Plombe fehlt) aus VALPOS'),
spr_id INTEGER NOT NULL OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
plombe_status_bez STRING(200) NOT NULL
OPTIONS(description='Sprechende Bezeichnung des Plomben-Status (z.B. Unbekannte Plombe, Plombe fehlt) aus DDTEXT.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, plombe_status_id, spr_id) NOT ENFORCED
)
OPTIONS(description='Sprachabhängige Bezeichnungen für die Plomben-Status-Codes. Quelle: (SAP RET) DD07V (Domäne ZLVPLO_STATUS).');