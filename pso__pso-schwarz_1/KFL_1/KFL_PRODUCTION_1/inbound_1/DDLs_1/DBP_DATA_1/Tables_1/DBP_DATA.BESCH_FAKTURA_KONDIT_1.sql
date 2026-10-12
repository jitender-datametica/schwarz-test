--==============================================================
-- Table: besch_faktura_kondit_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_kondit_1
   generated from Powerdesigner on Dienstag, 20. September 2022 16:47:53
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_FAKTURA_KONDIT_1 CLUSTER BY (
     MANDANT_ID,
     KONDITION_SCHL_ID 
)(
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH fuer Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   faktura_beleg_id                    NUMBER(18,0)    NOT NULL COMMENT 'Das Feld enthaelt die Beleg ID der der Faktura und dient der eindeutigen Identifikation der Fakturabelege.Aus vbeln. Oder generiert aus mjahr+ mbeln',
   faktura_beleg_pos_id                NUMBER(38,0)    NOT NULL COMMENT 'Das Feld enthaelt die Nummer einer Fakturaposition und dient zusammen mit der Fakturabeleg ID  der eindeutigen Identifikation der Fakturabelegpositionen. Aus posnr',
   beleg_kondition_id                  NUMBER(18,0)    NOT NULL COMMENT 'Nummer der Belegkondition aus knumv',
   kondition_schl_id                   VARCHAR(4)      COLLATE 'en-ci' NOT NULL COMMENT 'ID des Konditionsschlüssels aus kschl',
   wrg_id                              VARCHAR(3)      COMMENT 'Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR',
   kondition_wert                      NUMBER(18,2)    NOT NULL COMMENT 'Wert der Kondition zu GLD in Fakturawaehrung (Euro) aus kwert',
   kappl                               VARCHAR(2)      COLLATE 'en-ci' NOT NULL COMMENT 'ID der Applikation aus kappl, z.Bsp. V für Vertrieb',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_FAKTURA_KONDIT PRIMARY KEY (mandant_id, faktura_beleg_id, faktura_beleg_pos_id, beleg_kondition_id, kondition_schl_id) NOT ENFORCED
)  COMMENT = 'WWC - Hier sind die Konditionssaetze zu den Fakturen hinterlegt (nur für Exportvorgaenge). Quelle ist konv';