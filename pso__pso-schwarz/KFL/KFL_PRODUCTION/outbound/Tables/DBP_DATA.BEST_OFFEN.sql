--==============================================================
-- Table: best_offen
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: best_offen
   generated from Powerdesigner on Montag, 6. Februar 2023 14:31:21
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.best_offen (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
best_beleg_id INTEGER NOT NULL OPTIONS(description='Belegnummer des Einkaufsbelegs.'),
best_beleg_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Positionsnummer des Einkaufsbelegs.'),
wup_id BIGNUMERIC(38,0)
OPTIONS(description='Der "WUP" beinhaltet Märkte und Läger. WUP = WarenUmschlagsPlatz. Mutter Wup ID wird verwendet für Beziehung Lager zu Verteilzentrum.'),
nb_id BIGNUMERIC(38,0) OPTIONS(description='Nebenbetrieb. Im bisherigen System die 4 Stelle der Marktnummer.'),
gp_id BIGNUMERIC(38,0) OPTIONS(description='Geschäftspartner-ID (Lieferanten-ID).'),
art_id BIGNUMERIC(38,0)
OPTIONS(description='Input: Artikel - Id einschließlich der Generationen-ID (9-stellig); Output: 7stellige L&S-ID + Counter = 8stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.'),
dat_best_beleg DATE OPTIONS(description='Datum des Bestellbelegs'),
dat_lief_wunsch DATE OPTIONS(description='Wunschlieferdatum (EINDT).'),
kunde_id BIGNUMERIC(38,0) OPTIONS(description='Warenempfänger (Marktnummer).'),
nb_id_kunde BIGNUMERIC(38,0)
OPTIONS(description='Nebenbetrieb Warenempfänger. Im bisherigen System die 4 Stelle der Marktnummer.'),
einkaufsorganisation_id BIGNUMERIC(38,0) OPTIONS(description='Einkaufsorganisation.'),
einkaeufer_grp_id STRING(3) OPTIONS(description='Einkäufergruppe.'),
menge_best NUMERIC(13,3) OPTIONS(description='Bestellmenge.'),
menge_einh_id STRING(3) OPTIONS(description='Basismengeneinheit.'),
menge_lief_ist NUMERIC(13,3) OPTIONS(description='Tatsächlich gelieferte Menge in VME.'),
endlief_fg BIGNUMERIC(38,0) OPTIONS(description='Endlieferungskennzeichen.'),
menge_offen NUMERIC(13,3) OPTIONS(description='Offene Menge.'),
bestellart_id STRING(4) OPTIONS(description='Bestellart.'),
dat_generierung DATE OPTIONS(description='Generierungsdatum.'),
block_stock_fg BIGNUMERIC(38,0) OPTIONS(description='Block Stock Flag.'),
cpo_fg BIGNUMERIC(38,0) OPTIONS(description='Collective Purchase Orders Flag.'),
best_aend_kz STRING(1)
OPTIONS(description='Lösch- / Änderungskennzeichen für die Bestellposition. L wenn die Bestellposition gelöscht wurde, D wenn das Lieferdatum geändert wurde, sonst NULL.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, best_beleg_id, best_beleg_pos_id) NOT ENFORCED
) OPTIONS(description='Enthält offene Bestellungen auf Ebene Bestellposition aus ZEK_OPENORDER.');