/* --------------------------------------------------------------------------------
   DDL for table: t_ref_vat_pct_calc_type_2
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_vat_pct_calc_type_2 (
vat_pct_calc_type_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='MwSt-Berechnungsart; siehe t_ref_vat_pct_calc_type_2'),
vat_pct_calc_type_descr STRING(100) COLLATE 'und:ci' OPTIONS(description='N/A'),
PRIMARY KEY (vat_pct_calc_type_id) NOT ENFORCED
) OPTIONS(description='$Revision: 00000 $');