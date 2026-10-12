--==============================================================
-- Table: ims_standort_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_standort_2
   generated from Powerdesigner on Montag, 22. August 2022 08:10:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_standort_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
standort_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID eines Standorts. Entspricht bei Bestandsmärkten der Marktnummer,  bei zukünftigen Standorten eine_2 Nummer bzw. bei Dummy_2-Standorten XXXX'),
wup_id BIGNUMERIC(38,0) OPTIONS(description='Hier ist die Marktnummer eingetragen, wenn bekannt'),
nb_id BIGNUMERIC(38,0) OPTIONS(description='Die Nebenbetriebskennziffer zum Markt'),
standort_name STRING(40) COLLATE 'und:ci' OPTIONS(description='Name des Standorts'),
dat_eroeffnung DATE OPTIONS(description='Eröffnungsdatum'),
eigentum_kz BIGNUMERIC(38,0) OPTIONS(description='Eigentum / Miete Kennzeichen. ! = Eigentum, 0 = Miete, sonst NULL'),
umzugsfiliale_fg BIGNUMERIC(38,0) OPTIONS(description='Umzugsfiliale Flag. Wenn 1, dann Umzugsfiliale, sonst 0'),
neu_standort_fg BIGNUMERIC(38,0) OPTIONS(description='Flag kennzeichnet einen neuen Standort. Neu = 1, sonst 0'),
ginfo_markt_typ STRING(2) COLLATE 'und:ci'
OPTIONS(description='Markttyp nach Anzahl von Quadratmetern, z.Bsp. 4A ist > 4000 m2'),
umsatz_ea BIGNUMERIC(38,0)
OPTIONS(description='Umsatz laut Expansionsauftrag pro Jahr in Mio (feste Größe pro Markt, unabhängig vom Jahr)'),
verkaufsflaeche NUMERIC(18,2) OPTIONS(description='Verkaufsfläche des Marktes'),
konzessionaersflaeche NUMERIC(18,2) OPTIONS(description='extern vermietete Fläche (Konzessionäre_2)'),
betriebsflaeche NUMERIC(18,2) OPTIONS(description='Betriebsfläche des Marktes'),
sparte_id BIGNUMERIC(38,0) OPTIONS(description='ID der Sparte'),
datenquelle_kz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Zeigt an, ob die Daten aus der Excel-Planung kommen oder aus der Tabelle wup. Weitere Datenquellen sind möglich'),
wrg_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
)
OPTIONS(description='IMS - Tabelle der Standorte. Hier sind auch Expansions-Standorte enthalten, die noch keine Referenz zu einer Filiale aufweisen');