-- 2022-04-06,AP0128105,SPEC0150931  dknop, initial

-- 2023-12-18, dknop, INC7856312, AND lpa.DAT_LIEF_SOLL = bl.DAT_LIEF_SOLL for better performance

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_lief_plantour_arbeitsvorrat_1 (mandant_id,
lagernummer_id, lief_pal_typ_id, werbeware_id, lief_beleg_id, lief_typ_id, dat_lief_soll, av_herkunft_id, wup_id, nb_id
, plantour_id, vp_fg, stp_faktor_tour, anz_stp, dat_aenderung, anzahl_packstueck) AS SELECT BL.mandant_id,
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
FROM kfl_production_dbp_view.v_lief_plantour_arbeitsvorrat_1 AS LPA
 INNER JOIN kfl_production_dbp_view.v_besch_lief_1 AS BL ON LPA.mandant_id = BL.mandant_id AND LPA.lief_beleg_id = BL.lief_beleg_id
    -- avoid duplicates due to re_1-use of LIEF_BELEG_ID in BG:

    -- AND lpa.DAT_AENDERUNG BETWEEN bl.DAT_LIEF_SOLL  - 365 AND bl.DAT_LIEF_SOLL +30
 AND LPA.dat_lief_soll = BL.dat_lief_soll;