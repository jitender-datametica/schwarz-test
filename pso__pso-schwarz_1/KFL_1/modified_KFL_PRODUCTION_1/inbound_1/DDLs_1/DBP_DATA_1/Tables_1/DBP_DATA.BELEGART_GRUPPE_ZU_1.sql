--==============================================================
-- Table: belegart_gruppe_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegart_gruppe_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELEGART_GRUPPE_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;',
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   belegart_gruppe_id                  INTEGER     NOT NULL COMMENT 'Gruppierung über die Belegarten (fortlaufende Nummer)',
   belegart_id                         VARCHAR(2)       NOT NULL COMMENT 'Eindeutiger Schluessel fuer die Belegarten bei den Eingangsrechnungen (z. B. Rechnung, Gutschrit, Bela, Rbela, usw.).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELEGART_GRUPPE_ZU PRIMARY KEY (system_id, belegart_gruppe_id, belegart_id, mandant_id) NOT ENFORCED
)  COMMENT = 'RPW - DATA - Zuordnung Belegart zu Beleggruppe
             ';

