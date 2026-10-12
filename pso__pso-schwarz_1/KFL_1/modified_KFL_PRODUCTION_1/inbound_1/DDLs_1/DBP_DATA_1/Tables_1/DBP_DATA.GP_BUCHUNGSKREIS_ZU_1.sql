--==============================================================
-- Table: gp_buchungskreis_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_buchungskreis_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GP_BUCHUNGSKREIS_ZU_1 (
   system_id                           INTEGER     NOT NULL COMMENT 'Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).',
   gp_id                               INTEGER     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   einkaufsorganisation_id             INTEGER     NOT NULL COMMENT '1000=Warenlieferant 5000=Frischelieferant 9000=? könnte es auch geben.',
   buchungskreis_id                    INTEGER     NOT NULL COMMENT 'Zuordnung des Buchungskreises zu dem WUP_1 über die SAP Quelle T001K und T001. Der Buchungskreis entspricht unter dem Mandanten einer Zusammenfassung von Werken (Hierarchie: Mandant_1, Buchungskreis, Werk/Betrieb). Bsp: Buchungskreis 282 entspricht Kaufland',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   zahlsperre_id                       VARCHAR(1)       COMMENT 'Eindeutiger Schluessel fuer eine_1 Zahlsperre eines Lieferanten. Referenz zu der Tabelle l_zahlsperre_1;',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GP_BUCHUNGSKREIS_ZU PRIMARY KEY (system_id, gp_id, einkaufsorganisation_id, buchungskreis_id, mandant_id) NOT ENFORCED
)  COMMENT = 'RPW - Buchungkreisabhängige Informationen zum Lieferanten aus der SAP Tabelle LFB1.';
