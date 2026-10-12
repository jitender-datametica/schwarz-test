CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_preisindex_kukla (mandant_id, dat_erfass, kukla_id, wrg_id
, anz_art_vorkalk, anz_art_nachkalk, betrag_vkp_vorkalk, betrag_vkp_nachkalk, rate_kukla_ungewichtet_vorkalk,
rate_kukla_ungewichtet_nachkalk, rate_kukla_gewichtet_vorkalk, rate_kukla_gewichtet_nachkalk) AS SELECT mandant_id,
 dat_erfass,
 kukla_id,
 wrg_id,
 anz_art_vorkalk,
 anz_art_nachkalk,
 betrag_vkp_vorkalk,
 betrag_vkp_nachkalk,
 rate_kukla_ungewichtet_vorkalk,
 rate_kukla_ungewichtet_nachkalk,
 rate_kukla_gewichtet_vorkalk,
 rate_kukla_gewichtet_nachkalk
FROM kfl_production_dbp_data.preisindex_kukla;