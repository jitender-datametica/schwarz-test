CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr_materialized.mv_pcon_abwesenh_logik_fg_zu_2 (mandant_id,
mandant_bez, mandant_kbez, abwesenheit_id, kjmo_bis, kjmo_von, logik_kz, langzeit_abwesend_fg, pflege_fg,
beschaeftigungs_verbot_fg, krankheit_unfall_fg, sonstige_abwesenheit_fg, freigestellt_fg, mutterschutz_fg, elternzeit_fg
, fg_aendern) AS SELECT V01.mandant_id,
 V02.mandant_bez,
 V02.mandant_kbez,
 V01.abwesenheit_id,
 V01.kjmo_bis,
 V01.kjmo_von,
 V01.logik_kz,
 V01.langzeit_abwesend_fg,
 V01.pflege_fg,
 V01.beschaeftigungs_verbot_fg,
 V01.krankheit_unfall_fg,
 V01.sonstige_abwesenheit_fg,
 V01.freigestellt_fg,
 V01.mutterschutz_fg,
 V01.elternzeit_fg,
 -- wird als Dummy_2 benoetigt in MSI
 1 AS fg_aendern
FROM kfl_production_dbp_view.v_pcon_abwesenh_logik_fg_zu_2 AS V01
 LEFT JOIN kfl_production_dbp_msi_view_shr_materialized.mv_mandant_2 AS V02 ON V01.mandant_id = V02.mandant_id;