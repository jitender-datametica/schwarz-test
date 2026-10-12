CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.TBL_MV_F_FLW_KONDIT_VORGANG_1
   AS 
   SELECT
   v01.mandant_id, v01.beleg_kondition_id, v01.beleg_kondition_pos_id, v01.beleg_konditionsart_id
   , v03.werk_id, v03.loesch_id, v03.best_beleg_pos_id, v03.best_beleg_id, v03.flw_art_id AS in_art_id, v04.flw_lief_id AS in_lief_id
   , V01.WRG_ID, v05.dat_lief_wunsch, V100.DEFAULT_WRG,v01.betrag_beleg_kondition
   FROM dbp_view.v_flw_kondit_vorgang_1 v01
   INNER JOIN dbp_view.v_flw_besch_best_kondit_zu_1 v02
   ON  v01.mandant_id = v02.mandant_id
   AND v01.beleg_kondition_id = v02.beleg_kondition_id
   AND v01.beleg_kondition_pos_id = v02.best_beleg_pos_id
   AND v01.beleg_konditionsart_id = v02.beleg_konditionsart_id
   INNER JOIN dbp_view.v_flw_besch_best_det_1 v03
   ON  v02.mandant_id = v03.mandant_id
   AND v02.best_beleg_pos_id = v03.best_beleg_pos_id
   AND v02.best_beleg_id = v03.best_beleg_id
   INNER JOIN dbp_view.v_flw_besch_best_1 v04
   ON  v02.mandant_id = v04.mandant_id
   AND v02.best_beleg_id = v04.best_beleg_id
   INNER JOIN dbp_view.v_flw_lief_einteilung_1 v05
   ON v02.best_beleg_id = v05.best_beleg_id
   AND v02.best_beleg_pos_id = v05.best_beleg_pos_id
   AND v02.mandant_id = v05.mandant_id

   -- Ermittlung der default Waehrung
   JOIN
   dbp_view.v_mandant_1 v100
   ON v01.mandant_id = v100.mandant_id
   WHERE v01.mandant_id IN (1,2);