--==============================================================
-- Table: flw_besch_faktura_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_besch_faktura_det_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_BESCH_FAKTURA_DET_2 (
   faktura_beleg_id                    INTEGER     NOT NULL COMMENT 'Faktura Belegnummer aus vbeln',
   faktura_beleg_pos_id                INTEGER     NOT NULL COMMENT 'Belegposition aus posnr',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   flw_art_id                          INTEGER     COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   vorlage_beleg_id                    INTEGER     NOT NULL COMMENT 'Belegnummer des Vorlagebelegs aus SAP vgbel',
   menge_faktura_vkme                  NUMBER(29,3)     NOT NULL COMMENT 'Tatsächlich fakturierte Menge in Verkaufsmengeneinheit aus fkimg',
   menge_faktura_lme                   NUMBER(29,3)     NOT NULL COMMENT 'Fakturamenge in Lagermenheneinheiten aus fklmg',
   verk_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Einheit der Verkaufsmenge aus vrkme',
   gewicht_netto                       NUMBER(29,3)     NOT NULL COMMENT 'Nettogewicht aus ntgew',
   wert_ek_netto                       NUMBER(29,4)     NOT NULL COMMENT 'Nettowert der Fakturaposition in Belegwährung aus netwr',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   lief_pos_typ_id                     VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Positionstyp Vertriebsbeleg z.Bsp. kostenlose Lieferung aus pstyv',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   dat_preisfindung                    DATE             NOT NULL COMMENT 'Datum für Preisfindung und Währungskurs, kann vom Fakturadatum abweichen',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   vk_brutto                           NUMBER(29,2)      NOT NULL DEFAULT 0 COMMENT 'Normal-Verkaufspreis Brutto für den Artikel. Denormalisiert, wird im VE-Prozess angereichert aus art_wup_zu_per_2',
   vk_aktion_brutto                    NUMBER(29,2)      NOT NULL DEFAULT 0 COMMENT 'Aktions-Verkaufspreis Brutto für den Artikel. Denormalisiert, wird im VE-Prozess angereichert aus Aktionsdaten',
   dat_leist_erstellung                DATE             COMMENT 'Datum der Leistungserstellung aus dem Feld fbuda',
   zwsum_2_betrag                      NUMBER(29,2)     NOT NULL DEFAULT 0 COMMENT 'Konditionszwischensumme 2 aus dem Kalkulationsschema aus kzwi2',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_BESCH_FAKTURA_DET PRIMARY KEY (faktura_beleg_id, faktura_beleg_pos_id, mandant_id) NOT ENFORCED
)  COMMENT = 'FLW - Fakturabelege Detaildaten aus der SAP-Tabelle vbrp';

