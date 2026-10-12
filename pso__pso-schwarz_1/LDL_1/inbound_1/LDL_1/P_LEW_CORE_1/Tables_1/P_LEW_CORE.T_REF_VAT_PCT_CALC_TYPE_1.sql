/* --------------------------------------------------------------------------------
   DDL for table: t_ref_vat_pct_calc_type_1
   generated from Powerdesigner on Dienstag, 12. März 2024 10:15:48
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_REF_VAT_PCT_CALC_TYPE_1 (
   vat_pct_calc_type_id                NUMBER(38,0)     NOT NULL COMMENT 'MwSt-Berechnungsart; siehe t_ref_vat_pct_calc_type_1',
   vat_pct_calc_type_descr             VARCHAR(100)     COLLATE 'en-ci' COMMENT 'N/A',   
   CONSTRAINT PK_T_REF_VAT_PCT_CALC_TYPE PRIMARY KEY (vat_pct_calc_type_id) NOT ENFORCED 
)  COMMENT = '$Revision: 00000 $';

