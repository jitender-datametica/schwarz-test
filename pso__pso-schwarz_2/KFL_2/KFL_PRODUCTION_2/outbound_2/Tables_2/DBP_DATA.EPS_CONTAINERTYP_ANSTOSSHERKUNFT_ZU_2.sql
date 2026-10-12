--==============================================================
-- Table: eps_containertyp_anstossherkunft_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_containertyp_anstossherkunft_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.eps_containertyp_anstossherkunft_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
containertyp_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Druckgrund (z.B. aus MDE, Änderungsdienst, Nachdruck,….)'),
anstossherkunft_kz STRING(2) COLLATE 'und:ci'
OPTIONS(description='Kennzeichen - Bezeichnung der Anstoßherkunft (z.B. m = dezentral, z = zentral)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, containertyp_id) NOT ENFORCED
)
OPTIONS(description='VIS - Lookuptabelle für die Bezeichnung der Containertypen (Druckgrund ) aus EPS (z.B. aus MDE, Änderungsdienst, Nachdruck,….) - manuelle Beladung');