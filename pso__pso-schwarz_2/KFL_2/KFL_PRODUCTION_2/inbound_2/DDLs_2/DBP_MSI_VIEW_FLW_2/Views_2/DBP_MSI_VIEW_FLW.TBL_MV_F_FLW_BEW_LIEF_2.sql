CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_BEW_LIEF_2
   -- 26.10.2011 system_id entfernt
    -- Alex Lipkin Bedienung retourenpos_fg <>1 hinzugefuegt
    -- 28.01.2014 twie: Umgestellt auf 1:1 View flw_bew_2, vorher kamen Daten aus mv_f_flw_bew_2
    -- 22.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
   AS
   SELECT
   v01.mandant_id, v01.best_beleg_id, v01.best_beleg_pos_id, v01.lagerbew_beleg_id, v01.bde_vorgang_id, v01.werk_id, v01.charge_id, v01.lagerort_id, v01.dat_erfasst, v01.zeit_erfasst, v01.beleg_gruppe_id, v01.dat_haltbarkeit, v01.betrag_bew AS betrag_bew_org   -- als Zwischenschritt zur besseren Analyse, wird nicht im FE angezeigt
   , v01.auftrag_id, v01.kj, v01.loesch_fg, v01.flw_art_id, v01.dme_einh_id, CASE WHEN v01.storno_fg = 1 OR v01.retourenpos_fg = 1 THEN -1
   ELSE 1
   END AS vorzeichen, v01.nettogew  * vorzeichen AS nettogew_lief, v01.menge_bme * vorzeichen AS menge_bme_lief, v01.menge_dme * vorzeichen AS menge_dme_lief, v01.flw_beleg_typ_id, v01.altnv_menge_einh_id  AS menge_einh_id, v01.storno_fg, v01.status_mb, v01.retourenpos_fg , v01.wrg_id AS wrg_id_org, v100.DEFAULT_WRG
   FROM dbp_view.v_flw_bew_2 v01
   JOIN dbp_view.v_mandant_2 v100
   ON v01.mandant_id = v100.mandant_id
   WHERE v01.flw_beleg_typ_id = 'WE'
   AND v01.beleg_gruppe_id = 'B'
   AND v01.status_mb IN ('A','B','C')
   AND v01.loesch_fg <> 1
   AND v01.retourenpos_fg<>1
;