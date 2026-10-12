--==============================================================
-- Table: flw_art_werk_prognose_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_art_werk_prognose_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_art_werk_prognose_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
flw_kunde_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH generierter Surrogate Key für die Kundennummer aus SAP'),
dat_lief DATE NOT NULL OPTIONS(description='Lieferdatum aus lfdat'),
prognosetyp_id STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Prognosetyp aus prognose_typ.  M = Materialprognose, F = Filialprognose'),
dat_erstellung_von DATE NOT NULL
OPTIONS(description='Datum, an dem die Prognose im Industrie-System verarbeitet wurde aus erdatum'),
prognose_version BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Prognose Version, von FUR vergeben'),
version_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Bei Änderungen der Prognose innerhalb FLW wird eine_2 höhere Version erzeugt'),
dat_erstellung_bis DATE NOT NULL
OPTIONS(description='Feld wird im DWH angereichert. Ende des Zeitraums zwischen einem dat_erstellung und dem folgenden dat_erstellung'),
bestellmenge NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Bestellmenge aus bestmg'),
dat_bereitstellung DATE NOT NULL OPTIONS(description='Fleischwerk Bereitstelldatum aus Liefertermin-DB aus berdatum'),
best_menge_einh_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Bestellmengeinheit aus bstme'),
frueh_spaet_kz STRING(1) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichnet, ob der Markt früh oder spät beliefert wird aus fskz'),
bedarfsplan_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Quelle: bedarfsplannummer. Enthält char-Angaben wie z.Bsp. hawa, schwein, rind,...COMPRESS SCWEIN, RIND, HVO'),
flw_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Fleischwerk Flag. Ist = 1, wenn die Prognose für FLW relevant ist. Wird über prognose_version gefüllt. prognose_version beginnt für FLW mit 0, für FUR mit 1'),
menge_basis NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Menge in Basismengeneinheit aus basmg'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flw_art_id, werk_id, flw_kunde_id, dat_lief, dat_erstellung_von, prognose_version, version_lfd_nr,
 mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Fleischwerk Absatzplanung (Prognosedaten) aus zfw_absatzplan - MULTISET');