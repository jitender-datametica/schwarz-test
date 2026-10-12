--==============================================================
-- Table: besch_lief_kuerzung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_lief_kuerzung
   generated from Powerdesigner on Montag, 6. November 2023 15:57:00
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_lief_kuerzung (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant'),
dat_lief_soll DATE NOT NULL OPTIONS(description='Datum aus dem Quellfeld eindt'),
best_beleg_id INTEGER NOT NULL
OPTIONS(description='ID des Belegs bezogen auf den Bestellbeleg, das Quellfeld ist vbeln (also der Lieferbeleg)'),
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Position des Bestellbelegs (müsste also aus ebelp sein) aus posid '),
menge_best_bme NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='bestellte Menge des Artikel dieser Position in Bestellmengeneinheit. Aus menge'),
menge_lief_bme NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Tatsächlich gelieferte Menge in Bestellmengeneinheiten aus lfimg'),
ek_netto_bnk_soll NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die bestellte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung.'),
ek_netto_bnk_ist NUMERIC(18,4)
OPTIONS(description='Einkaufspreis netto_bnk bezogen auf die gekürzte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung.'),
vk_netto_ist NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die gekürzte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung'),
vk_netto_soll NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufspreis netto  bezogen auf die bestellte Menge.  In der Versorgung angereichert zur Performanceverbesserung. Die Währung entspricht der Bestellung'),
menge_best_kolli NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Dieses Feld enthält die Bestellmenge in der Kollimengeneinheit.  In der Versorgung angereichert zur Performanceverbesserung'),
menge_lief_kolli NUMERIC(18,3) DEFAULT 0 NOT NULL
OPTIONS(description='Anzahl der gekürzten Position in Kollimengeneinheit In der Versorgung angereichert zur Performanceverbesserung'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
quelle STRING(10) COLLATE 'und:ci' DEFAULT 'ZDELMON' NOT NULL OPTIONS(description='Quelltabelle SAP Retail'),
versandstelle_id STRING(4) DEFAULT '' NOT NULL
OPTIONS(description='Ort, an dem Lieferungen bearbeitet werden. Es kann sich dabei um einen physischen Ort (z.B. ein Lager oder eine Gruppe von Laderampen) oder um eine logische Gruppierung (z.B. eine Gruppe von Personen, die für die Versandaktivitäten zuständig ist) handeln.'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat_lief_soll, best_beleg_id, best_beleg_pos_id) NOT ENFORCED
)
OPTIONS(description='AIS KMO - Hier sind durch die Logistik gekürzte Lieferungen (nicht oder nur teilweise erfüllte Bestellungen) in KMO gespeichert. Quelle ist zldelmon_short');