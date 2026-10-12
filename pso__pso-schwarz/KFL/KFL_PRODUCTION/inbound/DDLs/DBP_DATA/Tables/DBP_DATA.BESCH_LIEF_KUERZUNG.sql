--==============================================================
-- Table: besch_lief_kuerzung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_kuerzung
   generated from Powerdesigner on Montag, 6. November 2023 15:57:00
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BESCH_LIEF_KUERZUNG (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant',
   dat_lief_soll                       DATE             NOT NULL COMMENT 'Datum aus dem Quellfeld eindt',
   best_beleg_id                       NUMBER(18,0)     NOT NULL COMMENT 'ID des Belegs bezogen auf den Bestellbeleg, das Quellfeld ist vbeln (also der Lieferbeleg)',
   best_beleg_pos_id                   NUMBER(38,0)     NOT NULL COMMENT 'Position des Bestellbelegs (müsste also aus ebelp sein) aus posid ',
   menge_best_bme                      NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'bestellte Menge des Artikel dieser Position in Bestellmengeneinheit. Aus menge',
   menge_lief_bme                      NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Tatsächlich gelieferte Menge in Bestellmengeneinheiten aus lfimg',
   ek_netto_bnk_soll                   NUMBER(18,4)     COMMENT 'Einkaufspreis netto_bnk bezogen auf die bestellte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung.',
   ek_netto_bnk_ist                    NUMBER(18,4)     COMMENT 'Einkaufspreis netto_bnk bezogen auf die gekürzte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung.',
   vk_netto_ist                        NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Verkaufspreis netto  bezogen auf die gekürzte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung',
   vk_netto_soll                       NUMBER(18,4)     NOT NULL DEFAULT 0 COMMENT 'Verkaufspreis netto  bezogen auf die bestellte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung',
   menge_best_kolli                    NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Dieses Feld enthält die Bestellmenge in der Kollimengeneinheit.  In der Versorgung angereichert zur Performanceverbesserung',
   menge_lief_kolli                    NUMBER(18,3)     NOT NULL DEFAULT 0 COMMENT 'Anzahl der gekürzten Position in Kollimengeneinheit In der Versorgung angereichert zur Performanceverbesserung',
   wrg_id                              VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der Währung, z.Bsp. CZK, EUR',
   quelle                              VARCHAR(10)      NOT NULL COLLATE 'en-ci' DEFAULT 'ZDELMON' COMMENT 'Quelltabelle SAP Retail',
   versandstelle_id                    VARCHAR(4)       NOT NULL DEFAULT '' COMMENT 'Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine Gruppe von Laderampen) oder um eine logische Gruppierung (z.B. eine Gruppe von Personen, die für die Versandaktivitäten zuständig ist) handeln.',
   art_id                              NUMBER(38,0)     COMMENT 'Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BESCH_LIEF_KUERZUNG PRIMARY KEY (mandant_id, dat_lief_soll, best_beleg_id, best_beleg_pos_id) NOT ENFORCED
)  COMMENT = 'AIS KMO - Hier sind durch die Logistik gekürzte Lieferungen (nicht oder nur teilweise erfüllte Bestellungen) in KMO gespeichert. Quelle ist zldelmon_short';
