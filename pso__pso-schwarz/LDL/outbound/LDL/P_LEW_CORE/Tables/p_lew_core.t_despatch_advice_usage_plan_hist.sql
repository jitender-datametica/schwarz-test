CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_despatch_advice_usage_plan_hist (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
bus_year BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='LIDL business year, begins in March and lasts until end of Ferbruar of the next calendar year'),
advice_usage_target_rate NUMERIC(18,5) NOT NULL
OPTIONS(description='Target rate of despatch advices which have been used in the receivings process among all sent despatch advices from EDI suppliers only'),
advice_edi_target_rate NUMERIC(18,5) NOT NULL
OPTIONS(description='Target rate of despatch advices which have been used in the receivings process among all receivings (EDI suppliers only)'),
advice_avail_edi_target_rate NUMERIC(18,5) NOT NULL
OPTIONS(description='Target rate of sent despatch advices among all receivings (EDI suppliers only)'),
advice_avail_target_rate NUMERIC(18,5) NOT NULL
OPTIONS(description='Target rate of sent despatch advices among all receivings (all suppliers)'),
advice_target_rate NUMERIC(18,5) NOT NULL
OPTIONS(description='Target rate of despatch advices which have been used in the receivings process among all receivings (all suppliers)'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Attribute set was not delivered by source system (anymore), if deleted_fg=1'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 (minus unendlich)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 (plus unendlich)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (client_id, bus_year, dwh_valid_from) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Table contains planned rates of the usage of despatch advices in processes or by suppliers. Source: sharepoint.');