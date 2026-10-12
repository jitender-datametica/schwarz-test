--==============================================================
-- Table: eps_containertyp_layout_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_containertyp_layout_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.eps_containertyp_layout_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
containertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Druckgrund (z.B. aus MDE, Änderungsdienst, Nachdruck,….)'),
layout_kz BIGNUMERIC(38,0) OPTIONS(description='Kennzeichen des Layouts (Etikett, Plakat)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, containertyp_id) NOT ENFORCED
)
OPTIONS(description='VIS - Lookuptabelle für die Bezeichnung der Containertypen (Druckgrund ) aus EPS (z.B. aus MDE, Änderungsdienst, Nachdruck,….) - manuelle Beladung');