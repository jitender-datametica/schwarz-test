--==============================================================
-- Table: art_gruppe_art_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gruppe_art_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.art_gruppe_art_zu (
art_gruppe_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Artikel-Gruppierung (System generiert im DWH)'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - ID einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1'),
umrech_faktor BIGNUMERIC(38,5) DEFAULT 0 NOT NULL
OPTIONS(description='Umrechnungsfaktor Standardmäßig immer 1. Kann jedoch vom User geändert werden, z. B. um verschiedene Gebinde korrekt zu berechnen. Kann Wert mit Dezimalstellen sein.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (art_gruppe_id, mandant_id, art_id) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER  - Artikelzuordnung zu Artikel-Gruppierungen (Zusammenfassung von Artikelnummern in diverse Gruppen für das Reporting / manueller Upload - langfristig Ablösung durch PIM)');