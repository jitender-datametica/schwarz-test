/* --------------------------------------------------------------------------------
   DDL for table: t_customer_loyalty_mapping_hist_2
   generated from Powerdesigner on Wednesday, February 21, 2024 1:07:11 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_customer_loyalty_mapping_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
customer_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Kunde; FK auf CUSTOMER'),
loyalty_cd STRING(100) NOT NULL
OPTIONS(description='Loyalty-ID, die fuer den Kunden im LidlPlus-System vergeben wurde; gehasht bei Telefonnummern'),
ident_type_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='Typ der Loyalty-ID'),
mapping_start_tmsp DATETIME OPTIONS(description='Zeitpunkt, ab dem das Mapping fachlich gilt'),
mapping_end_tmsp DATETIME OPTIONS(description='Zeitpunkt, bis zu dem das Mapping fachlich gilt'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Lokation ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_2 angenommen'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (loyalty_cd, customer_sid, dwh_valid_from) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. CULO; Mappingtabelle zwischen Loyalty-ID und Customer aus LidlPlus;              LidlPlus');