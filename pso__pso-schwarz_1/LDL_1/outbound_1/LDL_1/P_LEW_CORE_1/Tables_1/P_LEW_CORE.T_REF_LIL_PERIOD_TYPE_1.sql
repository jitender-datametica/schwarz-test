/* --------------------------------------------------------------------------------
   DDL for table: t_ref_lil_period_type_1
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_lil_period_type_1 (
period_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Perioden-Typ-ID'),
period_type_name STRING(100) COLLATE 'und:ci' OPTIONS(description='Beschreibung Perioden-Typ'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten fachlichen(!) Aenderung'),
PRIMARY KEY (period_type_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $ This minor entity defines the subtype discriminators for periods in the LIAM/LIFT / CM context. ');