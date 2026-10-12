--==============================================================
-- Table: inventur_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventur_det_2
   generated from Powerdesigner on Mittwoch, 7. September 2022 15:15:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventur_det_2 (
inv_beleg_id INTEGER NOT NULL OPTIONS(description='ID des Inventurbelegs aus iblnr'),
gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschaeftsjahr, Format JJJJ'),
inv_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Position des Inventurbelegs aus zeili'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
dat_letzt_zaehl DATE NOT NULL OPTIONS(description='Datum der letzten Zaehlung aus zldat'),
lagerort_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schluessel fuer die Lagerorte. Die Lagerorte sind pro Werk/Betrieb eindeutig. Aus lgort'),
dat_buch DATE NOT NULL OPTIONS(description='Buchungsdatum im Beleg aus budat'),
wup_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Input: Artikel_2 - Id einschliesslich der Generationen - ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige ArtikelID. WWNNNNPC (Warengruppe, Nummer, Pruefziffer, Counter) Regel: Neuer Artikel_2 -> Counter +1'),
lagerbew_beleg_id INTEGER
OPTIONS(description='Das Feld enthaelt die ID der Lagerbewegung und dient zusammen mit dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegung aus mblnr.'),
lagerbew_beleg_pos_id BIGNUMERIC(38,0)
OPTIONS(description='Das Feld enthaelt die Nummer einer Lagerbewegungsposition und dient zusammen mit der Lagerbewegungs ID und dem Kalenderjahr der eindeutigen Identifikation der Lagerbewegungsposition. Aus zeile '),
kj BIGNUMERIC(38,0)
OPTIONS(description='Dieses Attribut enthaelt das entsprechende Kalenderjahr und wird benoetgit um einen Beleg in Kombination mit der Belegnummer eindeutig zu identifizieren.aus mjahr '),
erfsngs_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Erfassungsmengeneinheit der Inventur_2 aus der Spalte erfme. Referenz zur Tabelle l_einh_2'),
menge_erf NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Menge in Erfassungsmengeneinheit aus erfmg'),
menge_buch NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Buchmenge zur Zaehlung aus buchm'),
menge_zaehl NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Zaehlmenge in Basismengeneinheit aus menge'),
wert_diff_inv NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Differenzbetrag in Hauswaehrung aus dmbtr'),
wert_vk_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Wert zu Verkaufspreisen brutto aus vkwrt'),
wert_vk_extern NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='extern eingegebener Verkaufswert in Hauswaehrung aus exvkw'),
wert_vk_netto NUMERIC(18,4) DEFAULT 0 NOT NULL OPTIONS(description='Wert zu Verkaufspreisen netto aus vkwra'),
vk_inventur_diff_brutto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufswert Inventurdifferenz brutto bei Zaehlerfassung aus vkmzl'),
vk_inventur_diff_netto NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Verkaufswert Inventurdifferenz netto bei Zaehlerfassung aus vknzl'),
wert_zaehl NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Wert der Inventurzaehlung (netto) zum Zeitpunkt der Inventurerfassung aus wrtzl'),
wert_menge_buch NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='Wert der Buchmenge (netto) zum Zeitpunkt der Zaehlerfassung'),
nullzaehl_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nullzaehlung Flag. Wenn = 1, ist die gezaehlte Menge = 0. Aus xnull'),
beleg_erfasser_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Beleg-Erfassers. Kann Batch-Usernamen oder FB enthalten. Aus Datenschutzgruenden darf in den Bewegungsdaten nur der Fachbereich des Erfassers abgebildet werden.Wird aus dem Quellfeld usnaz erzeugt'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (inv_beleg_id, gj, inv_beleg_pos_id, mandant_id) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='WWC - Positionsdaten des Inventurbelegs aus der SAP Tabelle iseg');