--==============================================================
-- Table: dra_wup_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: dra_wup_tag_1
   generated from Powerdesigner on Mittwoch, 7. September 2022 14:03:14
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DRA_WUP_TAG_1 (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant_1 im DWH',
   wup_id                              NUMBER(38,0)    NOT NULL COMMENT 'Nummer des Warenumschlagsplatzes',
   dat                                 DATE            NOT NULL COMMENT 'Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_1-DD',
   betrag_dra                          NUMBER(9,2)     NOT NULL COMMENT 'gespendeter Betrag in Euro. Kann zwischen 0,01 und 0,10 liegen',
   anz_bon                             NUMBER(38,0)    DEFAULT 0 NOT NULL COMMENT 'Anzahl der Bons zum Wert aus dem Schluessel',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DRA_WUP_TAG PRIMARY KEY (mandant_id, wup_id, dat, betrag_dra) NOT ENFORCED
)  COMMENT = 'VIS - Hier werden die gespendeten Betraege der Aktion_1 "Deutschland rundet auf" hinterlegt';
