CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_MENGENKORREKTURLISTE_DET_2 as
   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v01.dat_buch, v01.dat_aenderung_rpw, v01.gp_id, v02.art_id, v02.best_menge_einh_id, v04.menge_lagerbew_bme   AS we_menge, v02.menge_rech

   FROM dbp_view.v_besch_rech_2 v01
   INNER JOIN dbp_view.v_besch_rech_det_2  v02
   ON v01.mandant_id    = v02.mandant_id
   AND v01.wup_id        = v02.wup_id
   AND v01.rech_beleg_id = v02.rech_beleg_id
   AND v01.gj            = v02.gj
   AND v01.system_id     = v02.system_id
   AND v01.nb_id         = v02.nb_id
   INNER JOIN
   (SELECT
   mandant_id, nb_id, wup_id, system_id, beleg_id, beleg_gj
   FROM dbp_view.v_problemmeldung_2
   WHERE problemcode_id IN  ('0347   ', '0538   ', '0539   ', '0594   ')   -- PC auf Kopf-Ebene
   AND system_id = 7
   AND mandant_id = 1
   AND nb_id = 0
   GROUP BY 1,2,3,4,5,6
   ) v03
   ON v01.mandant_id    = v03.mandant_id
   AND v01.wup_id        = v03.wup_id
   AND v01.rech_beleg_id = v03.beleg_id
   AND v01.gj            = v03.beleg_gj
   AND v01.system_id     = v03.system_id
   AND v01.nb_id         = v03.nb_id
   INNER JOIN dbp_view.v_lagerbew_det_2 v04
   ON v02.mandant_id            = v04.mandant_id
   AND v02.lagerbew_beleg_id     = v04.lagerbew_beleg_id
   AND v02.lagerbew_beleg_pos_id = v04.lagerbew_beleg_pos_id
   AND v02.kj                    = v04.kj
   WHERE v01.mandant_id = 1
   AND v01.nb_id = 0

   UNION ALL

   SELECT
   v01.mandant_id, v01.wup_id, v01.nb_id, v01.dat_buch, v01.dat_aenderung_rpw, v01.gp_id, v02.art_id, v02.best_menge_einh_id, v04.menge_lagerbew_bme   AS we_menge, v02.menge_rech
   FROM dbp_view.v_besch_rech_2 v01
   INNER JOIN dbp_view.v_besch_rech_det_2  v02
   ON v01.mandant_id    = v02.mandant_id
   AND v01.wup_id        = v02.wup_id
   AND v01.rech_beleg_id = v02.rech_beleg_id
   AND v01.gj            = v02.gj
   AND v01.system_id     = v02.system_id
   AND v01.nb_id         = v02.nb_id
   INNER JOIN
   (SELECT
   mandant_id, nb_id, wup_id, system_id, beleg_id, beleg_gj, beleg_pos_id
   FROM dbp_view.v_problemmeldung_2
   WHERE problemcode_id IN ('0231   ', '0313   ', '0314   ', '0593   ', '0595   ')   -- PC auf POS-Ebene
   AND (mandant_id, nb_id, wup_id, system_id, beleg_id, beleg_gj) NOT IN
   (SELECT mandant_id, nb_id, wup_id, system_id, beleg_id, beleg_gj
   FROM dbp_view.v_problemmeldung_2
   WHERE problemcode_id IN  ('0347   ', '0538   ', '0539   ', '0594   ')   -- PC auf Kopf-Ebene
   )
   AND system_id = 7
   AND mandant_id = 1
   AND nb_id = 0
   GROUP BY 1,2,3,4,5,6,7
   ) v03
   ON v02.mandant_id        = v03.mandant_id
   AND v02.wup_id            = v03.wup_id
   AND v02.rech_beleg_id     = v03.beleg_id
   AND v02.gj                = v03.beleg_gj
   AND v02.rech_beleg_pos_id = v03.beleg_pos_id
   AND v02.system_id         = v03.system_id
   AND v02.nb_id             = v03.nb_id
   INNER JOIN dbp_view.v_lagerbew_det_2 v04
   ON v02.mandant_id            = v04.mandant_id
   AND v02.lagerbew_beleg_id     = v04.lagerbew_beleg_id
   AND v02.lagerbew_beleg_pos_id = v04.lagerbew_beleg_pos_id
   AND v02.kj                    = v04.kj

   WHERE v01.mandant_id = 1
   AND v01.nb_id = 0;