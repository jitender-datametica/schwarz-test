--==============================================================
-- Table: eps_layout_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_layout_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.eps_layout_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL,
layout_kz BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Redundant - Speziell für MSI - Kennzeichen des Layouts (Etikett, Plakat)'),
layout_bez STRING(50) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung des Layouts (z.B. Etikett)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, layout_kz) NOT ENFORCED
) OPTIONS(description='VIS - Sprachabhängige Bezeichnungen des Layouts aus EPS (z.B. Etikett) - manuelle Beladung');