--==============================================================
-- Table: abrechnungsqualitaet
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abrechnungsqualitaet
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ABRECHNUNGSQUALITAET (
   kjmo                                NUMBER(38,0)     NOT NULL COMMENT 'Bezugsmonat Rechnungdaten',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   einkaufsorganisation_id             NUMBER(38,0)     COMMENT '1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
   rechnung_anz                        NUMBER(38,0)     COMMENT 'Anzahl im Bezugsmonat erfasster Rechnungen zum Lieferanten  gem. Erfassungsdatum, ohne Löschungen',
   rechnung_netto                      NUMBER(18,4)     COMMENT 'Summe der Rechnungen zum nettowert',
   rechnung_maschinell_anz             NUMBER(38,0)     COMMENT 'Anzahl maschinell gebuchter Rechnungen',
   rechnung_manuell_anz                NUMBER(38,0)     COMMENT 'Anzahl manuell gebuchter Rechnungen',
   belastungsanzeigen_anz              NUMBER(38,0)     COMMENT 'Anzahl im Bezugsmonat erfasster Belastungsanzeigen zum Lieferanten gem. Erfassungsdatum der BA ',
   belastungsanzeigen_netto            NUMBER(18,4)     COMMENT 'Summe der im Bezugsmonat erfasstern Belastungsanzeigen zum Lieferanten gem. Erfassungsdatum der BA zum Nettowert ',
   rueckbelastungsanzeigen_anz         NUMBER(38,0)     COMMENT 'Anzahl im Bezugsmonat erfasster Rückbelastungsanzeigen zum Lieferanten gem. Erfassungsdatum',
   rueckbelastungsanzeigen_netto       NUMBER(18,4)     COMMENT 'Wert im Bezugsmonat erfasster Rückbelastungsanzeigen zum Lieferanten gem. Erfassungsdatum zum Nettowert',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ABRECHNUNGSQUALITAET PRIMARY KEY (kjmo, gp_id, system_id) NOT ENFORCED
)  COMMENT = 'Aus der zentralen Rechnungsprüfung werden Informationen über Anzahl und Wert der Eingangrechnungen, maschineller und manueller Rechnungen sowie Belastungsanzeigen und Rückbelastungsanzeigen gespeichert';

