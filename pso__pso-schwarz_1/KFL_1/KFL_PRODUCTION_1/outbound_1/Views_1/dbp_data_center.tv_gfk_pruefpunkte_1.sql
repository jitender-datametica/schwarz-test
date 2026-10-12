CREATE OR REPLACE VIEW kfl_production_dbp_data_center.tv_gfk_pruefpunkte_1 AS SELECT BES.fipo_bereich_id,
 BES.fipo_bereich_bez,
 PS.fipo_pruefpunkt_id,
 P.fipo_pruefpunkt_typ,
 PS.fipo_pruefpunkt_bez
FROM kfl_production_dbp_view.v_fipo_l_pruef_modul_1 AS PM_1
 INNER JOIN kfl_production_dbp_view.v_fipo_pruef_modul_spr_zu_1 AS PMS ON PM.fipo_pruef_modul_id = PMS.fipo_pruef_modul_id
     AND PMS.spr_id = 22 AND PMS.fipo_pruef_modul_bez = 'Kundenfeedback'
 INNER JOIN kfl_production_dbp_view.v_fipo_l_bereich_1 AS BE ON PM.fipo_pruef_modul_id = BE.fipo_pruef_modul_id
 INNER JOIN kfl_production_dbp_view.v_fipo_bereich_spr_zu_1 AS BES ON BE.fipo_bereich_id = BES.fipo_bereich_id AND BES.spr_id
    = 22
 INNER JOIN kfl_production_dbp_view.v_fipo_l_kategorie_1 AS K ON BE.fipo_bereich_id = K.fipo_bereich_id
 INNER JOIN kfl_production_dbp_view.v_fipo_kategorie_spr_zu_1 AS KS ON K.fipo_kategorie_id = KS.fipo_kategorie_id AND KS.spr_id
    = 22
 INNER JOIN kfl_production_dbp_view.v_fipo_pruefpunkt_1 AS P ON K.fipo_kategorie_id = P.fipo_kategorie_id AND P.dat_von <
    CURRENT_DATE AND P.dat_bis > CURRENT_DATE
 INNER JOIN kfl_production_dbp_view.v_fipo_pruefpunkt_spr_zu_1 AS PS ON P.fipo_pruefpunkt_id = PS.fipo_pruefpunkt_id AND
   PS.spr_id = 22;