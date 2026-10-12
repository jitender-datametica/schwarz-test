--==============================================================
-- Table: l_crm_hotline_bereich_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_crm_hotline_bereich_2
   generated from Powerdesigner on Dienstag, 20. Mai 2025 16:10:45
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_CRM_HOTLINE_BEREICH_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH.',
   crm_hotline_bereich_id              NUMBER(38,0)     NOT NULL COMMENT 'ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_CRM_HOTLINE_BEREICH PRIMARY KEY (mandant_id, crm_hotline_bereich_id) NOT ENFORCED
)  COMMENT = 'Die Tabelle ist eine_2 Lookup-Tabelle für die Bereiche bzw. Abteilungen der CRM-Hotline. Sie enthält eine_2 Liste der Bereiche, an die Anrufe zugestellt werden und die Anrufe entgegennehmen, z.B. KCard, Kundenhotline, Schadenshotline oder Zentrale.Sie wird manuell befüllt.';
