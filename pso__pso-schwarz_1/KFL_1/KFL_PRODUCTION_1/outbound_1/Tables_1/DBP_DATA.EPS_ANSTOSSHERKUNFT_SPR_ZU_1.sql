--==============================================================
-- Table: eps_anstossherkunft_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_anstossherkunft_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.eps_anstossherkunft_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
anstossherkunft_kz STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Redundant - Speziell für MSI - Kennzeichen - Bezeichnung der Anstoßherkunft (z.B. m = dezentral, z = zentral)'),
anstossherkunft_bez STRING(50) COLLATE 'und:ci'
OPTIONS(description='Sprachabhängige Bezeichnung der Anstoßherkunft (z.B. m = dezentral, z = zentral)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Sprachabhängige Bezeichnungen der Anstoßherkunft - manuelle Beladung');