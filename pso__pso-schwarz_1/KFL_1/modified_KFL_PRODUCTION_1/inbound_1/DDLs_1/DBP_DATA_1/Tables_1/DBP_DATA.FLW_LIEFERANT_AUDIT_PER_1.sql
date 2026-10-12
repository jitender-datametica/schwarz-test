--==============================================================
-- Table: flw_lieferant_audit_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lieferant_audit_per_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_LIEFERANT_AUDIT_PER_1 (
   dat_von                             DATE             NOT NULL COMMENT 'Datum eines Audits audits aus zfw_qm_audit.ab. ',
   flw_lief_id                         INTEGER     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   dat_bis                             DATE             NOT NULL COMMENT 'Datum, bis zu dem ein neuer Audit stattgefunden hat. Beim aktuellsten Audit ist der Wert 31.12.9999 enthalten. Wird im DWH erstellt',
   audit_qzahl                         INTEGER     COMMENT 'Qualitätskennzahl- Ganzzahliger Wert auf einer Skala zwischen 0 und 100. aus zfw_qm_audit.zz_audit',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_LIEFERANT_AUDIT_PER PRIMARY KEY (dat_von, flw_lief_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Die Tabelle bildet die Auditpunktzahl der Fleischwerkslieferanten historisch ab. Aus zfw_qm_audit';

