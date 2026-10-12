--==============================================================
-- Table: wbs_l_mandant_zeitslots_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: wbs_l_mandant_zeitslots_2
   generated from Powerdesigner on Wednesday, August 24, 2022 12:58:18 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.WBS_L_MANDANT_ZEITSLOTS_2 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_2 im DWH.',
   zeitslot_id                         INTEGER    NOT NULL COMMENT 'ID des Zeitslots fuer die Kalkulation und Bestellung von zusaetzlicher Werbeware. Mandanten haben nicht unbedingt gleiche Zeitslots.',
   zeitslot_bez                        VARCHAR(50)     NOT NULL COMMENT 'Beschreibung des Zeitslots. Textform, kann eine_2 Uhrzeit oder ein Infotext sein (z.B. "keine Hochrechnung").',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_WBS_L_MANDANT_ZEITSLOTS PRIMARY KEY (mandant_id, zeitslot_id) NOT ENFORCED
)  COMMENT = 'SCM-WBS - A time slot concerns the calculation and resupply-reporting for additional promotional item_2 quantities. This table lists time slot options (zeitslot_id, zeitslot_bez) in MSI processboard that are available to a client (mandant_id), including no calculation. For each delivery group clients can have only one time slot per day, but several delivery groups in one time slot a day are possible. Standard assignments also follow this list, but users can make changes to them in MSI with other entries, which then are stored in table ts_wbs_zeitslots_aenderung. No one-time ad-hoc additions to time slots. If different time slots than the ones available are requested, it has to be done through a ticket, which is again a lasting change.';
