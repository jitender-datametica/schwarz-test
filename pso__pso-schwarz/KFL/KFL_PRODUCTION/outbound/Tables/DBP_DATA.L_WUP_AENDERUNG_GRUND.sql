--==============================================================
-- Table: l_wup_aenderung_grund
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_wup_aenderung_grund
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 11:48:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_wup_aenderung_grund (
wup_aenderung_grund_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Numerischer Code fuer den Grund der WUP ID Aenderung. Ist gefuellt fuer die wup_id, die die Aenderung erfahren hat, somit bei der aktuellen wup_id standardmaessig 0. Der Aenderungsgrund steht immer in der alten wup ID.            Moegliche Auspraegungen:            0 = keine Aenderung            1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)            2 = Umzug (seit Einfuehrung der Filialumgliederungen)            3 = Umgliederung            4 = Abriss / Neubau'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wup_aenderung_grund_id) NOT ENFORCED
)
OPTIONS(description='Diese Lookup-Tabelle beinhaltet die Gruende fuer Aenderungen der WUP ID.             Moegliche Auspraegungen:             0 = keine Aenderung             1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)             2 = Umzug (seit Einfuehrung der Filialumgliederungen)             3 = Umgliederung             4 = Abriss / Neubau');