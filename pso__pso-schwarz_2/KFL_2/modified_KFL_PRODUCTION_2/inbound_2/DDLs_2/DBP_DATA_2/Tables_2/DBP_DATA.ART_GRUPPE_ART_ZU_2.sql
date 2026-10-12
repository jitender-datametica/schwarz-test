--==============================================================
-- Table: art_gruppe_art_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gruppe_art_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_GRUPPE_ART_ZU_2 (
   art_gruppe_id                       INTEGER     NOT NULL COMMENT 'ID der Artikel_2-Gruppierung (System generiert im DWH)',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikel_2 - ID einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1',
   umrech_faktor                       NUMBER(29,5)     NOT NULL DEFAULT 0 COMMENT 'Umrechnungsfaktor Standardmäßig immer 1. Kann jedoch vom User geändert werden, z. B. um verschiedene Gebinde korrekt zu berechnen. Kann Wert mit Dezimalstellen sein.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GRUPPE_ART_ZU PRIMARY KEY (art_gruppe_id, mandant_id, art_id) NOT ENFORCED
)  COMMENT = 'EK-INT - Artikelzuordnung zu Artikel_2-Gruppierungen (Zusammenfassung von Artikelnummern in diverse Gruppen für das Reporting / manueller Upload - langfristig Ablösung durch PIM)';

