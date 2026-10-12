--==============================================================
-- Table: vis_monat_umsatz_wg
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_monat_umsatz_wg
   generated from Powerdesigner on Freitag, 16. Mai 2025 15:56:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vis_monat_umsatz_wg (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Warengruppe'),
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr'),
ums_netto BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto'),
ums_netto_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
ums_netto_kvvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
ums_netto_plan BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto Planwert'),
ums_brutto BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz brutto'),
ums_brutto_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz brutto Kalendertag im Vorjahr'),
menge_absatz BIGNUMERIC(38,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_kvj BIGNUMERIC(38,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge Kalendertag im Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
menge_absatz_kvvj BIGNUMERIC(38,3) DEFAULT 0 NOT NULL
OPTIONS(description='Menge Kalendertag im Vor-Vorjahr in Basismengeneinheit. Stück und Gewichtsartikel gemischt'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, kjmo, arthiertyp_id, wg_id) NOT ENFORCED
) OPTIONS(description='VIS - Aggregat auf Monatsebene - MULTISET');