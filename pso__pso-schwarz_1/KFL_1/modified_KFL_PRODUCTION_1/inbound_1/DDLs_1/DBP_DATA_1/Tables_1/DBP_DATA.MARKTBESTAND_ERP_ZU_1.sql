--==============================================================
-- Table: marktbestand_erp_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: marktbestand_erp_zu_1
   generated from Powerdesigner on Dienstag, 15. November 2022 16:31:28
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.MARKTBESTAND_ERP_ZU_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH.',
   bestand_id                          INTEGER    NOT NULL COMMENT 'Eindeutiger Schlüssel zur Referenztabelle.',
   ek_netto                            NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).',
   ek_netto_bnk                        NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten. Enthält den Aktionspreis, wenn vorhanden, sonst den Normalpreis. Einkaufspreis netto (Bedeutung vgl. Kalkulationsschema).',
   vk_netto                            NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Verkaufspreis netto.',
   wrg_id                              VARCHAR(3)      COLLATE 'en-ci' NOT NULL COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.',
   ek_nettonetto                       NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Einkaufspreis nettonetto (Bedeutung vgl. Kalkulationsschema).',
   einstandspreis                      NUMBER(29,4)    DEFAULT 0 NOT NULL COMMENT 'Kaufland Einstandspreis (Bedeutung vgl. Kalkulationsschema).',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_MARKTBESTAND_ERP_ZU PRIMARY KEY (mandant_id, bestand_id) NOT ENFORCED
)  COMMENT = 'AIS - Referenztabelle mit Mengen und Preisen zur marktbestand_erp. Quelle SAP MARD.';
