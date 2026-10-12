CREATE OR REPLACE TABLE KFL_PRODUCTION_DBP_DATA.ART_GRUPPE_ART_ZU_2 (
ART_GRUPPE_ID INTEGER NOT NULL OPTIONS(description='ID der Artikel_2-Gruppierung (System generiert im DWH)'),
MANDANT_ID INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ART_ID INTEGER NOT NULL
OPTIONS(description='Artikel_2 - ID einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
UMRECH_FAKTOR NUMERIC(29,5) DEFAULT 0 NOT NULL
OPTIONS(description='Umrechnungsfaktor Standardmäßig immer 1. Kann jedoch vom User geändert werden, z. B. um verschiedene Gebinde korrekt zu berechnen. Kann Wert mit Dezimalstellen sein.'),
TD_INSERT TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
TD_UPDATE TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (ART_GRUPPE_ID, MANDANT_ID, ART_ID) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER - Artikelzuordnung zu Artikel_2-Gruppierungen (Zusammenfassung von Artikelnummern in diverse Gruppen für das Reporting / manueller Upload - langfristig Ablösung durch PIM)');