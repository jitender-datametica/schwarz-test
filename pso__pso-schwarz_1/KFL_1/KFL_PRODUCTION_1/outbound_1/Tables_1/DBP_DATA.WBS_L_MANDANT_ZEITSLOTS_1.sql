--==============================================================
-- Table: wbs_l_mandant_zeitslots_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_mandant_zeitslots_1
   generated from Powerdesigner on Wednesday, August 24, 2022 12:58:18 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbs_l_mandant_zeitslots_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
zeitslot_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Zeitslots fuer die Kalkulation und Bestellung von zusaetzlicher Werbeware. Mandanten haben nicht unbedingt gleiche Zeitslots.'),
zeitslot_bez STRING(50) NOT NULL
OPTIONS(description='Beschreibung des Zeitslots. Textform, kann eine_1 Uhrzeit oder ein Infotext sein (z.B. "keine Hochrechnung").'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zeitslot_id) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - A time slot concerns the calculation and resupply-reporting for additional promotional item_1 quantities. This table lists time slot options (zeitslot_id, zeitslot_bez) in MSI processboard that are available to a client (mandant_id), including no calculation. For each delivery group clients can have only one time slot per day, but several delivery groups in one time slot a day are possible. Standard assignments also follow this list, but users can make changes to them in MSI with other entries, which then are stored in table ts_wbs_zeitslots_aenderung. No one-time ad-hoc additions to time slots. If different time slots than the ones available are requested, it has to be done through a ticket, which is again a lasting change.');