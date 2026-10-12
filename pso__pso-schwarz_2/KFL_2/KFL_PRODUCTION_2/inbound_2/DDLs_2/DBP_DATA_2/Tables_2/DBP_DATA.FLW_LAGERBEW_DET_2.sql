--==============================================================
-- Table: flw_lagerbew_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lagerbew_det_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_LAGERBEW_DET_2 CLUSTER BY (KJ) (
   flw_art_id                          NUMBER(38,0)     NOT NULL COMMENT 'Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   lagerbew_beleg_id                   NUMBER(18,0)     NOT NULL COMMENT 'Das Feld enthält die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung.',
   lagerbew_beleg_pos_id               NUMBER(38,0)     NOT NULL COMMENT 'Das Feld enthält die Nummer einer Lagerbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Quelle zeile',
   kj                                  NUMBER(38,0)     NOT NULL COMMENT 'Kalenderjahr, Format JJJJ',
   auto_id                             VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen für eine_2 automatisch erzeugte Position aus SAP xauto',
   flw_lief_id                         NUMBER(38,0)     NOT NULL COMMENT 'Lieferantennummer. Im DWH erzeugter numerischer Schlüssel',
   charge_id                           VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Charge aus charg',
   soll_haben_kz                       VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Soll-Haben-Kennzeichen aus SAP shkzg',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   betrag_lagerbew                     NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Betrag der Belegposition in der Hauswährung des Buchungskreises. Entspricht dem eknetto_bnk aus SAP mseg.dmbtr. Gilt für V-Preis gesteuertes Material',
   betrag_lagerbew_altnv               NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Buchungsbetrag in alternativer Preissteuerung aus bualt. Gilt für S-Preis gesteuertes Material. Liefert für Standardpreisartikel die GLD-Bewertung',
   menge_lagerbew_bme                  NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Menge in Basismengeneinheit aus menge',
   menge_bstmg                         NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Menge in Bestellmengeneinheit aus bstmg',
   best_menge_einh_id                  VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Bestellmengeneinheit aus SAP.bstme. Referenziert auf die Tabelle einh',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   empfaenger_id                       NUMBER(38,0)     NOT NULL COMMENT 'Im DWH generierter Surrogate Key für die Kundennummer aus SAP',
   best_beleg_id                       NUMBER(18,0)     NOT NULL COMMENT 'Bestellbeleg aus ebeln',
   best_beleg_pos_id                   NUMBER(38,0)     COMMENT 'Belegposition des Einkaufsbelegs aus ebelp',
   menge_erf                           NUMBER(18,3)     NOT NULL COMMENT 'Menge in der Erfassungsmengeneinheit aus erfmg',
   lager_bewart_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Lager Bewegungsart aus bwart',
   auftrag_id                          VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr. Compress -1',
   kostenstelle_id                     VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'Kostenstelle aus kostl',
   lagerort_id                         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel für die Lagerorte',
   menge_bestellpreis                  NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Menge in Bestellpreismengeneinheit aus bprmg',
   bestellpreis_menge_einh_id          VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Gibt die Maßeinheit an, auf die sich der Bestellpreis bezieht. aus bprme',
   erfsngs_menge_einh_id               VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der alternativen Mengeneinheit aus meinh',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_LAGERBEW_DET PRIMARY KEY (mandant_id, lagerbew_beleg_id, lagerbew_beleg_pos_id, kj) NOT ENFORCED
)  COMMENT = 'FLW - Lagerbewegungen Positionen aus Quelle SAP mseg';

