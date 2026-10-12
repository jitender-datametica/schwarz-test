--==============================================================
-- Table: flw_lieferant_audit_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lieferant_audit_per
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_lieferant_audit_per (
dat_von DATE NOT NULL OPTIONS(description='Datum eines Audits audits aus zfw_qm_audit.ab. '),
flw_lief_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lieferantennummer. Im DWH erzeugter numerischer Schlüssel'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
dat_bis DATE NOT NULL
OPTIONS(description='Datum, bis zu dem ein neuer Audit stattgefunden hat. Beim aktuellsten Audit ist der Wert 31.12.9999 enthalten. Wird im DWH erstellt'),
audit_qzahl BIGNUMERIC(38,0)
OPTIONS(description='Qualitätskennzahl- Ganzzahliger Wert auf einer Skala zwischen 0 und 100. aus zfw_qm_audit.zz_audit'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (dat_von, flw_lief_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='FLW - Die Tabelle bildet die Auditpunktzahl der Fleischwerkslieferanten historisch ab. Aus zfw_qm_audit');