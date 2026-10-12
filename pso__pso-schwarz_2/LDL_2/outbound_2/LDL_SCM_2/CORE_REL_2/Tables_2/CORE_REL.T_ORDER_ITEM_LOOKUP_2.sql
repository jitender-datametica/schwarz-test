CREATE TABLE IF NOT EXISTS ldl_scm_core_rel.t_order_item_lookup_2 (
land_2 STRING(100),
int_liefnr_verhandlungspart BIGNUMERIC(38,0),
bezeichnung_verhandlungspart STRING(500),
ba_nr BIGNUMERIC(38,0),
ba_bezeichnung STRING(500),
ian BIGNUMERIC(38,0),
nan BIGNUMERIC(38,0),
artikel_bezeichnung STRING(500),
order_gtin BIGNUMERIC(38,0),
kolliinhalt BIGNUMERIC(38,0),
palfkt BIGNUMERIC(38,0),
source STRING(100),
dem_match_fg INTEGER
);