-- 2022.02.03, AP0122465, SPEC0146157, dknop, initial

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_nachschubquoten (wup_id, art_id, nb_id,
lagernummer_id, lagerort_id, mandant_id, nach_lagertyp_id, transport_beleg_id, von_lagertyp_id, dat_quittierung,
auspack_fg, status_quittierung) AS SELECT TD.wup_id,
 TD.art_id,
 TD.nb_id,
 TD.lagernummer_id,
 TD.lagerort_id,
 TD.mandant_id,
 TD.nach_lagertyp_id,
 TD.transport_beleg_id,
 TD.von_lagertyp_id,
 TD.dat_quittierung,
 MARC.auspack_fg,
 CAST(CASE
   WHEN TD.quittierung_fg = 1 AND (TD.menge_soll_von = TD.menge_ist_nach OR TD.menge_soll_von = 0 AND TD.menge_ist_nach > 0) AND COALESCE(TD.transport_vorgang_id, '') NOT IN ('st', 'sl')
   THEN 'voll quittiert'
   WHEN TD.quittierung_fg = 1 AND TD.menge_soll_von > TD.menge_ist_nach AND COALESCE(TD.transport_vorgang_id, '') NOT IN ('st', 'sl')
   THEN 'teil quittiert'
   WHEN TD.quittierung_fg = 1 AND TD.transport_vorgang_id IN ('st', 'sl')
   THEN 'storniert'
   WHEN TD.quittierung_fg = 0
   THEN 'offen'
   ELSE 'sonstiges'
   END AS STRING) AS status_quittierung
FROM kfl_production_dbp_view.v_transportauftrag_det AS TD
 INNER JOIN kfl_production_dbp_view.v_art_vorschlagswert_per AS MARC ON TD.mandant_id = MARC.mandant_id AND TD.art_id =
    MARC.art_id AND TD.dat_quittierung BETWEEN MARC.dat_von AND MARC.dat_bis;