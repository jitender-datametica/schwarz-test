--==============================================================
-- Table: ts_in_werk_flaeche_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_in_werk_flaeche_per_1
   generated from Powerdesigner on Montag, 20. Februar 2023 09:55:49
*/ --------------------------------------------------------------------------------
      
	  

CREATE TABLE DBP_MSI_VIEW_LOG.TS_IN_WERK_FLAECHE_PER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk',
   gebaeude_bez                        VARCHAR(100)     NOT NULL DEFAULT 'total' COMMENT 'Gebäude Bezeichnung, z. B. FOOD',
   gebaeudeteil_bez                    VARCHAR(100)     NOT NULL DEFAULT 'total' COMMENT 'Gebäudeteil Bezeichnung, z. B. Halle 1',
   flaeche_qm                          NUMBER(18,3)     COMMENT 'Flaeche in Quadratmetern',
   dat_von                             DATE             COMMENT 'Datum, ab dem der Datensatz gültig ist',
   dat_bis                             DATE             COMMENT 'Gültig bis',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_IN_WERK_FLAECHE_PER PRIMARY KEY (mandant_id, werk_id, gebaeude_bez, gebaeudeteil_bez) NOT ENFORCED
)  COMMENT = 'Flaeche in m² pro Werk (SAP Industry) mit Gueltigkeitsintervall, da Erweiterungen von VZ haeufiger vorkommen koennen. Wird durch TS Dokument versorgt.';
