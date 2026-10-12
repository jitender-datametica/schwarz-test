CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_lief_plantour_arbeitsvorrat (mandant_id, lagernummer_id,
lief_pal_typ_id, werbeware_id, lief_beleg_id, lief_typ_id, dat_lief_soll, av_herkunft_id, wup_id, nb_id, plantour_id,
vp_fg, stp_faktor_tour, anz_stp, dat_aenderung, anzahl_packstueck) AS SELECT BL.mandant_id,
 BL.lagernummer_id,
 BL.lief_pal_typ_id,
 BL.werbeware_id,
 BL.lief_beleg_id,
 BL.lief_typ_id,
 BL.dat_lief_soll,
 LPA.av_herkunft_id,
 LPA.wup_id,
 LPA.nb_id,
 LPA.plantour_id,
 LPA.vp_fg,
 LPA.stp_faktor_tour,
 LPA.anz_stp,
 LPA.dat_aenderung,
 BL.anzahl_packstueck
FROM kfl_production_dbp_view.v_lief_plantour_arbeitsvorrat AS LPA
 INNER JOIN kfl_production_dbp_view.v_besch_lief AS BL ON LPA.mandant_id = BL.mandant_id AND LPA.lief_beleg_id = BL.lief_beleg_id
     AND LPA.dat_lief_soll = BL.dat_lief_soll;