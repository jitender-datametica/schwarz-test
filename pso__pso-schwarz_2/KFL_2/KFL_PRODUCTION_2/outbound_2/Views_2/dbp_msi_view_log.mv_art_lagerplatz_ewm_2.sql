CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_art_lagerplatz_ewm_2 (lagernummer_id, mandant_id, dat, art_id,
art_guid, wup_id, nb_id, lagertyp_id, lagerplatz_id, artikelsortiment_id, menge_fixiert, tr_fg, tkl_fg) AS SELECT A_LP.lagernummer_id
 ,
 A_LP.mandant_id,
 T.dat,
 A_LP.art_id,
 A_LP.art_guid,
 A_LP.wup_id,
 A_LP.nb_id,
 A_LP.lagertyp_id,
 A_LP.lagerplatz_id,
 A_SORT.artikelsortiment_id,
 A_LP.menge_fixiert_fg AS menge_fixiert,
 A_LP.tr_fg,
 A_LP.tkl_fg
FROM kfl_production_dbp_view.v_art_lagerplatz_per_ewm_2 AS A_LP
 INNER JOIN kfl_production_dbp_view.v_tag_2 AS T ON T.dat BETWEEN A_LP.dat_von AND A_LP.dat_bis
 INNER JOIN kfl_production_dbp_view.v_art_wup_status_per_2 AS MARC_2 ON A_LP.mandant_id = MARC.mandant_id AND A_LP.art_id =
     MARC.art_id AND A_LP.wup_id = MARC.wup_id AND MARC.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_fremd_lagerort_artikelsortiment_zu_2 AS A_SORT ON MARC.fremd_lagerort_id = A_SORT.fremd_lagerort_id
    AND MARC.mandant_id = A_SORT.mandant_id;