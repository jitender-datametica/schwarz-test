CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_pcon_abwesenh_logik_fg_zu (mandant_id,
mandant_bez, mandant_kbez, abwesenheit_id, kjmo_bis, kjmo_von, logik_kz, langzeit_abwesend_fg, pflege_fg,
beschaeftigungs_verbot_fg, krankheit_unfall_fg, sonstige_abwesenheit_fg, freigestellt_fg, mutterschutz_fg, elternzeit_fg
, fg_aendern) AS SELECT v01.mandant_id,
 v02.mandant_bez,
 v02.mandant_kbez,
 v01.abwesenheit_id,
 v01.kjmo_bis,
 v01.kjmo_von,
 v01.logik_kz,
 v01.langzeit_abwesend_fg,
 v01.pflege_fg,
 v01.beschaeftigungs_verbot_fg,
 v01.krankheit_unfall_fg,
 v01.sonstige_abwesenheit_fg,
 v01.freigestellt_fg,
 v01.mutterschutz_fg,
 v01.elternzeit_fg,
 -- wird als Dummy benoetigt in MSI
 1 AS fg_aendern
FROM kfl_production_dbp_view.v_pcon_abwesenh_logik_fg_zu AS v01
 LEFT JOIN kfl_production_dbp_msi_view_shr_materialized.mv_mandant AS v02 ON v01.mandant_id = v02.mandant_id;