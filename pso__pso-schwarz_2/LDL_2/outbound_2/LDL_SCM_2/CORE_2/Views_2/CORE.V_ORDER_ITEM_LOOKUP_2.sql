CREATE OR REPLACE VIEW ldl_scm_core.v_order_item_lookup_2 (land_2, int_liefnr_verhandlungspart, bezeichnung_verhandlungspart
, ba_nr, ba_bezeichnung, ian, nan, artikel_bezeichnung, order_gtin, kolliinhalt, palfkt) AS SELECT land_2,
 int_liefnr_verhandlungspart,
 bezeichnung_verhandlungspart,
 ba_nr,
 ba_bezeichnung,
 ian,
 nan,
 artikel_bezeichnung,
 order_gtin,
 kolliinhalt,
 palfkt
FROM ldl_scm_core_rel.t_order_item_lookup_2;