CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_FLW_DATENPOOL as
   SELECT v01.mandant_id, v01.verteilprozess_id, v01.datenpool_satzart_id, v01.dat_produktion, v01.objekt_id, v01.werk_id, v01.dat_lief, v01.dat_mat_bereitstllg, 
    SECOND(v01.zeit_mat_bereitstllg) + MINUTE(v01.zeit_mat_bereitstllg) * 60 + HOUR(v01.zeit_mat_bereitstllg) * 3600 AS zeit_mat_bereitstllg_sec,
   --CAST(v01.zeit_mat_bereitstllg AS INTEGER) AS zeit_mat_bereitstllg_sec, --veraltet
   --to_time(to_char((v01.zeit_mat_bereitstllg)),'HH24.MI.SS') AS zeit_mat_bereitstllg, --veraltet
   v01.zeit_mat_bereitstllg,
   v01.flw_tourart_id, v01.flw_kunde_id AS in_kunde_id, 
   v01.verk_menge_einh_id, v01.anz_kolli_produzier, v01.komm_auftrag_status_id, v01.handling_unit_id_ext, v01.lagernummer_id, v01.flw_art_id AS in_art_id, v01.lief_beleg_id, v01.flw_art_id_verpackung AS in_art_id_verpackung, v01.verp_menge_einh_id, v01.menge_produziert
   FROM dbp_view.v_flw_datenpool v01;