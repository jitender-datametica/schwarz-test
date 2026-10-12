--==============================================================
-- Table: ts_objekt_info
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_objekt_info
   generated from Powerdesigner on Freitag, 19. August 2022 10:13:42
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_log.ts_tp_objekt_info_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
tp_objekt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'),
tp_objekt_typ STRING(1) OPTIONS(description='Equipmenttyp'),
gebaeude_bez STRING(100) OPTIONS(description='Gebäude Bezeichnung'),
anlage_bez STRING(100) OPTIONS(description='Anlage_1 Bezeichnung'),
anlagengruppe_bez STRING(100) OPTIONS(description='Anlagengruppe Bezeichnung'),
anlagenteil_bez STRING(100) OPTIONS(description='Anlagenteil Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, tp_objekt_id) NOT ENFORCED
)
OPTIONS(description='Zusätzliche Informationen zum Equipment (SAP Industry). Grundgesamtheit ist der aktuell gültige Stand aus tp_objekt_per_1, die _bez-Felder werden durch ein TS Dokument versorgt.');