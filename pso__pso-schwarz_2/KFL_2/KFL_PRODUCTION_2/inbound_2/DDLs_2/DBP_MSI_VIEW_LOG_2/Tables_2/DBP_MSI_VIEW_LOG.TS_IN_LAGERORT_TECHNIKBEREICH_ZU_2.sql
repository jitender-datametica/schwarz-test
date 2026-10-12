--==============================================================
-- Table: ts_in_lagerort_technikbereich_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_in_lagerort_technikbereich_zu_2
   generated from Powerdesigner on Freitag, 19. August 2022 12:18:29
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_LOG.TS_IN_LAGERORT_TECHNIKBEREICH_ZU_2 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_2',
   werk_id                             NUMBER(38,0)    NOT NULL COMMENT 'Werk',
   in_lagerort_id                      VARCHAR(4)      NOT NULL COMMENT 'Lagerort',
   technikbereich_bez                  VARCHAR(100)    COMMENT 'Bezeichnung Technikbereich',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_IN_LAGERORT_TECHNIKBEREICH_ZU PRIMARY KEY (mandant_id, werk_id, in_lagerort_id) NOT ENFORCED
)  COMMENT = 'Mappingtabelle SAP Industry Lagerort zu Technikbereich (z. B. FFZ/Flurförderfahrzeuge) - wird durch Transaction Services Dokument versorgt';
