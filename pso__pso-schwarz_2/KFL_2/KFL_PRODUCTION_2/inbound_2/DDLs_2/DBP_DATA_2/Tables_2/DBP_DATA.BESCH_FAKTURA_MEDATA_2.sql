--==============================================================
-- Table: besch_faktura_medata_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_medata_2
   generated from Powerdesigner on Montag, 21. Juli 2025 05:50:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_FAKTURA_MEDATA_2 CLUSTER BY (DAT_FAKTURA) (
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2 ID',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   faktura_markt                       NUMBER(38,0)     NOT NULL COMMENT 'bezieht sich auf den empfangenden wup_2',
   dat_faktura                         DATE             NOT NULL COMMENT 'Abhängig von der Fakturaart ist hier entweder das Fakturadatum oder das Datum der Leistungserstellung hinterlegt',
   wup_id                              NUMBER(38,0)     NOT NULL COMMENT 'in diesem Fall der beliefernde wup_2 - Medatalager',
   nb_id                               NUMBER(38,0)     NOT NULL COMMENT 'Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer',
   zwsum_3_betrag                      NUMBER(18,4)     COMMENT 'Einkaufspreis netto  bzw. EK-Aktion_2 netto vermindert um die Reklapauschale.',
   menge_fakturiert                    NUMBER(18,3)     COMMENT 'Fakturierte Menge in Verkaufseinheiten, Displays werden als 1 gerechnet',
   ek_netto_bnk                        NUMBER(18,4)     COMMENT 'Einkaufspreis netto plus Bezugsnebenkosten (Bedeutung vgl. Kalkulationsschema).',
   ek_mep                              NUMBER(18,4)     COMMENT 'Markteinstandspreis ((Bedeutung vgl. Kalkulationsschema).',
   logistikkostenzuschlag              NUMBER(18,4)     COMMENT 'Logistikkostenzuschlag (ein kalkulierter Wert für die Zentrallagerkosten, der bei zentraler Lieferung Bestandteil einiger Einstandspreise ist).',
   betrag_ek_mep_vor_fwu               NUMBER(38,5)     COMMENT 'Menge * Markteinstandspreis ohne Logistikkosten inkl. Handlingkosten. Quellfeld: ZEKP.MEPOL.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_FAKTURA_MEDATA PRIMARY KEY (art_id, mandant_id, faktura_markt, dat_faktura) NOT ENFORCED
)  COMMENT = 'TP2 AIS - Fakturadaten aus Medata - Lägern (nicht in SAP)';
