--==============================================================
-- Table: in_qual_meldung_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_qual_meldung_det_2
   generated from Powerdesigner on Mittwoch, 17. August 2022 14:54:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_qual_meldung_det_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
qual_meldung_id INTEGER NOT NULL OPTIONS(description='ID der Qualitätsmeldung aus qmnum'),
qual_meldung_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Positionsnummer im Positionssatz'),
problemcode_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Problem- oder Schadenscode'),
katalogart_id_pc STRING(1) OPTIONS(description='Katalogart - Probleme/Fehler (Problemcode)'),
codegruppe_id_pc STRING(8) OPTIONS(description='Codegruppe - Probleme (Problemcode)'),
katalogart_id_ot STRING(1) OPTIONS(description='Katalogart - Probleme/Fehler (Objektteil)'),
codegruppe_id_ot STRING(8) OPTIONS(description='Codegruppe - Probleme (Objektteil)'),
pruefcode_id_ot STRING(4) OPTIONS(description='Prüfcode (Objektteil)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, qual_meldung_id, qual_meldung_pos_id) NOT ENFORCED
) OPTIONS(description='LIS - IND Tabelle QMFE, enthält Qualitätsmeldung-Positionen');