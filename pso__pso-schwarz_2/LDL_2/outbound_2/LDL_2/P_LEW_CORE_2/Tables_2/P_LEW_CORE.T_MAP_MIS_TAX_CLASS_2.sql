/* --------------------------------------------------------------------------------
   DDL for table: t_map_mis_tax_class_2
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:15 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_map_mis_tax_class_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH-Mandant_2; FK auf CLIENT'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='ELWIS: tax_class; pendant: t_item_tax_country_hist_2'),
mis_vat_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ELWIS: vat_id'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (client_id, tax_class_cd) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='$Revision: 0000 $. Tabelle zur Ermittlung des MIS-VAT-ID;             Inhalt wird manuell gepflegt;             ELWIS: t_s_tax_class_map_mis');