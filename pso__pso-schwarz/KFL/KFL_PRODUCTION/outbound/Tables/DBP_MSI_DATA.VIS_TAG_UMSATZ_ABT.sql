--==============================================================
-- Table: vis_tag_umsatz_abt
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: vis_tag_umsatz_abt
   generated from Powerdesigner on Freitag, 16. Mai 2025 16:06:32
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.vis_tag_umsatz_abt (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
dat DATE NOT NULL OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM-DD'),
nb_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
arthiertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
abt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Abteilungs ID negativer Zahlenraum: im DWH generierte IDs, positive Werte: aus Stammdatensystem übernommen'),
kjmo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahremonat, Format JJJJMM'),
kjwo BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kalenderjahreswoche, Format JJJJWW'),
ums_netto BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto'),
ums_netto_wvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorjahr'),
ums_netto_wvvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto Wochentag im Vorvorjahr'),
ums_netto_kvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vorjahr'),
ums_netto_kvvj BIGNUMERIC(38,2) NOT NULL OPTIONS(description='Umsatz netto Kalendertag im Vor-Vorjahr'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, dat, nb_id, wup_id, arthiertyp_id, abt_id) NOT ENFORCED
) CLUSTER BY mandant_id, dat
OPTIONS(description='VIS - Aggregat auf Tagesebene - MULTISET');