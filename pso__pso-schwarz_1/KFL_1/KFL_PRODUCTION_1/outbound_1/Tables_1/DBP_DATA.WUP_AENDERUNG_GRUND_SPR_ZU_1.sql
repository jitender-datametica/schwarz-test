--==============================================================
-- Table: wup_aenderung_grund_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wup_aenderung_grund_spr_zu_1
   generated from Powerdesigner on Mittwoch, 31. Juli 2024 11:46:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wup_aenderung_grund_spr_zu_1 (
wup_aenderung_grund_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Numerischer Code fuer den Grund der WUP_1 ID Aenderung. Ist gefuellt fuer die wup_id, die die Aenderung erfahren hat, somit bei der aktuellen wup_id standardmaessig 0. Der Aenderungsgrund steht immer in der alten wup_1 ID.            Moegliche Auspraegungen:            0 = keine Aenderung            1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)            2 = Umzug (seit Einfuehrung der Filialumgliederungen)            3 = Umgliederung            4 = Abriss / Neubau'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
wup_aenderung_grund_bez STRING(100) NOT NULL
OPTIONS(description='Bezeichnung des Änderungsgrundes der WUP_1 ID in jeweiliger Sprache.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wup_aenderung_grund_id, spr_id) NOT ENFORCED
)
OPTIONS(description='Zuordnungstabelle zwischen den Änderungsgrunde der WUP_1 ID und der Sprache. Beinhaltet von der Sprache abhängige Bezeichnungen der Gründe.');