CREATE OR REPLACE TABLE kfl_production_dbp_data.immo_mietvertrag_sicherheit_2 (
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
mv_intreno STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Interner Schlüssel des Immobilienobjekts'),
sicherheit_lfd_nr INTEGER NOT NULL OPTIONS(description='Position innerhalb der Gruppe_2'),
beschreibung STRING(60) COLLATE 'und:ci' NOT NULL OPTIONS(description='Beschreibung Sicherheiten'),
sicherheit_typ INTEGER NOT NULL OPTIONS(description='Art_2 der Sicherheit'),
dat_bis DATE NOT NULL OPTIONS(description='Datum: Gültig bis'),
betrag_soll NUMERIC(18,2) NOT NULL OPTIONS(description='Sollbetrag Sicherheiten'),
soll_wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der  Währung für den Soll-Betrag, z.B. CZK, EUR'),
betrag_ist NUMERIC(18,2) NOT NULL OPTIONS(description='Istbetrag Sicherheiten'),
ist_wrg_id STRING(3) NOT NULL OPTIONS(description='Kurzbezeichnung der  Währung für den Ist-Betrag, z.B. CZK, EUR'),
dat_eingeloest_am DATE NOT NULL OPTIONS(description='Datum Sicherheit eingelöst am'),
dat_rueckgabe_am DATE NOT NULL OPTIONS(description='Datum Rückgabe Sicherheit'),
dat_eingang_am DATE NOT NULL OPTIONS(description='Eingang Sicherheit bei KL'),
dat_uebergabe_am DATE NOT NULL OPTIONS(description='Datum Übergabe an Begünstigten'),
buergschaft_nr STRING(60) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bürgschaftsnummer'),
buergschaft_grund STRING(60) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bürgschaftsgrund'),
rueckgabe_voraussetzung STRING(60) COLLATE 'und:ci' NOT NULL OPTIONS(description='Rückgabevoraussetzung'),
bank_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Banknummer'),
kaution_bez STRING(80) COLLATE 'und:ci' OPTIONS(description='Kautionsbezeichnung'),
dat_ausstellung_am DATE OPTIONS(description='Deposit Issue Datum'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, sicherheit_lfd_nr) NOT ENFORCED
) OPTIONS(description='IMMO - Mietvertrag Mietsicherheiten / Bürgschaften - SAP REFX - ZBI_V_DEPOSIT');