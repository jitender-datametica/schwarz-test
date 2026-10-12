CREATE OR REPLACE TABLE kfl_production_dbp_data.art_gruppe_art_zu_1 (
art_gruppe_id INTEGER NOT NULL OPTIONS(description='ID der Artikel_1-Gruppierung (System generiert im DWH)'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_1 im DWH'),
art_id INTEGER NOT NULL
OPTIONS(description='Artikel_1 - ID einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_1 -> Counter +1'),
umrech_faktor NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Umrechnungsfaktor Standardmäßig immer 1. Kann jedoch vom User geändert werden, z. B. um verschiedene Gebinde korrekt zu berechnen. Kann Wert mit Dezimalstellen sein.'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_gruppe_id, mandant_id, art_id) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER  - Artikelzuordnung zu Artikel_1-Gruppierungen (Zusammenfassung von Artikelnummern in diverse Gruppen für das Reporting / manueller Upload - langfristig Ablösung durch PIM)');