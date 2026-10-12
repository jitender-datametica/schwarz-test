--==============================================================
-- Table: vis_monat_umsatz_abt_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_monat_umsatz_abt_2
   generated from Powerdesigner on Freitag, 16. Mai 2025 16:02:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vis_monat_umsatz_abt_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel_2 - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsjahr'),
akt_gj BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Zähler auf Basis des aktuellen Geschäftsjahres'),
akt_mo BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zahlenfolge, die den Abstand eines Monats zum laufenden Monat_2 darstellt. Der aktuelle Monat_2 hat den Wert 0, der vorige Monat_2 -1 und der nächste Monat_2 den Wert 1'),
mo_kj BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Laufender Monat_2 im Kalenderjahr. Wert zwischen 1 und 12, wobei Januar = 1 und Dezember = 12'),
ums_netto BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto'),
ums_netto_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
ums_netto_kvvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
ums_netto_plan BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto Planwert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, nb_id, kjmo, abt_id, arthiertyp_id) NOT ENFORCED
) OPTIONS(description='VIS - Aggregat auf Monatsebene - MULTISET');