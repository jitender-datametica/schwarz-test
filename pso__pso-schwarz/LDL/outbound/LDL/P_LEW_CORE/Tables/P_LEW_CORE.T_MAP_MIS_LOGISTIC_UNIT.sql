/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_logistic_unit
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_map_mis_logistic_unit (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant; FK auf CLIENT'),
uom_cd STRING(20) NOT NULL OPTIONS(description='ELWIS: uom_id'),
mis_logistic_unit_cd BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ELWIS: logistic_unit_cd'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, uom_cd) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Tabelle zur Ermittlung des MIS-Logistic-Unit-Codes;             Inhalt wird manuell gepflegt;             ELWIS: t_r_logistic_unit_map_mis');