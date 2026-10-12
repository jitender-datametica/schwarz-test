--==============================================================
-- Table: wbs_mandant_auslieferungsgruppe_tag_zeitslots_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_mandant_auslieferungsgruppe_tag_zeitslots_zu_1
   generated from Powerdesigner on Wednesday, August 24, 2022 12:59:22 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_mandant_auslieferungsgruppe_tag_zeitslots_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
auslieferungsgruppe_id STRING(4) NOT NULL
OPTIONS(description='ID der Auslieferungsgruppe. Eine_1 Auslieferungsgruppe (manchmal auch Ausliefergruppe) ist eine_1 Buendelung von Artikeln mit gleichen Eigenschaften Aufgrund welchen sie zusammen ausgeliefert werden koennen, VZ in Richtung Filiale. Z.B.: Food Trocken (Mehl, Konserven, Nudeln), Tiefkuehlware (Fisch, Pizza, Eis, Tiefkuehlgemuese), etc.'),
wtag_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Wochentags. Mo - So = 1 - 7.'),
zeitslot_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Zeitslots fuer die Kalkulation und Bestellung von zusaetzlicher Werbeware. Mandanten haben nicht unbedingt gleiche Zeitslots.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, auslieferungsgruppe_id, wtag_id, zeitslot_id) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - This table contains the standard settings of time slots (zeitslot_id) in MSI processboard for each client (mandant_id), delivery group (auslieferungsgruppe_id) and weekday (wtag_id). A time slot concerns the calculation and resupply-reporting for additional promotional item_1 quantities. All possible time slots come from the list of options in wbs_l_mandant_zeitslots. For each delivery group clients can have only one time slot per weekday, but several delivery groups in one time slot are possible. Users can assign a different time slot in MSI, which is then stored in table ts_wbs_zeitslots_aenderung.');