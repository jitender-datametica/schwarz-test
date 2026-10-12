--20241121 alavih: Anpassung bzgl. Filialumgliederung


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_rpm_immobilie_1 (rpm_immobilie_id, dat_von, techn_platz_id,
vs_id, mandant_id, wrg_id, gesamtbew_note, bewertungszahl_a, bewertungszahl_b, bewertungszahl_c, dat_bis, eigentum_bez,
beri_relevanz, gj_umbvorschl, wup_id, nb_id, wup_standort, strasse, plz, zielumsatz_3gj, dat_eroeffn_fb_imm) AS SELECT
 V01.rpm_hierarchie_id AS rpm_immobilie_id,
 V01.dat_von,
 V01.techn_platz_id,
 COALESCE(W.vs_id, 0) AS vs_id,
 V01.mandant_id,
 V01.wrg_id,
 V01.gesamtbew_note,
 V01.bewertungszahl_a,
 V01.bewertungszahl_b,
 V01.bewertungszahl_c,
 V01.dat_bis,
 COALESCE(V07.rpm_feld_auspr_bez, '') AS eigentum_bez,
 COALESCE(V17.rpm_feld_auspr_bez, '') AS beri_relevanz,
  CASE
  WHEN V01.gj_umbvorschl IS NULL
  THEN 0
  ELSE V01.gj_umbvorschl
  END AS gj_umbvorschl,
 COALESCE(W.aktuell_wup_id, V01.wup_id) AS wup_id,
 COALESCE(V01.nb_id, 0) AS nb_id,
 COALESCE(V01.wup_standort, '') AS wup_standort,
 COALESCE(V01.strasse, '') AS strasse,
 V01.plz,
 V01.zielumsatz_3gj,
 V01.dat_eroeffn_fb_imm
FROM kfl_production_dbp_view.v_rpm_immobilie_per_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_l_rpm_feld_1 AS V88 ON V88.rpm_feld_id = 8
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_zu_per_1 AS V03 ON V88.rpm_feld_id = V03.rpm_feld_id AND V01.rpm_hierarchie_id
     = V03.rpm_hierarchie_id AND V03.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_l_rpm_tab_1 AS V05 ON V05.rpm_tab_bez = 'INM_INITIATIVE' AND V03.rpm_tab_id = V05.rpm_tab_id
   
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_auspr_zu_1 AS V06 ON V88.rpm_feld_id = V06.rpm_feld_id AND V05.rpm_tab_id =
    V06.rpm_tab_id AND V03.rpm_feld_auspr_id = V06.rpm_feld_auspr_id
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_1 AS V07 ON V06.rpm_feld_id = V07.rpm_feld_id AND V06.rpm_tab_id
      = V07.rpm_tab_id AND V06.rpm_feld_auspr_id = V07.rpm_feld_auspr_id AND V07.spr_id = 22
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS W ON V01.wup_id = W.wup_id AND V01.mandant_id = W.mandant_id AND V01.nb_id =
    W.nb_id AND V01.wup_id > 0
 LEFT JOIN kfl_production_dbp_view.v_l_rpm_feld_1 AS V77 ON V77.rpm_feld_id = 31
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_zu_per_1 AS V13 ON V77.rpm_feld_id = V13.rpm_feld_id AND V01.rpm_hierarchie_id
     = V13.rpm_hierarchie_id AND V13.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_l_rpm_tab_1 AS V15 ON V15.rpm_tab_bez = 'INM_INITIATIVE' AND V13.rpm_tab_id = V15.rpm_tab_id
   
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_auspr_zu_1 AS V16 ON V77.rpm_feld_id = V16.rpm_feld_id AND V15.rpm_tab_id =
    V16.rpm_tab_id AND V13.rpm_feld_auspr_id = V16.rpm_feld_auspr_id
 LEFT JOIN kfl_production_dbp_view.v_rpm_feld_auspr_spr_zu_1 AS V17 ON V16.rpm_feld_id = V17.rpm_feld_id AND V16.rpm_tab_id
      = V17.rpm_tab_id AND V16.rpm_feld_auspr_id = V17.rpm_feld_auspr_id AND V17.spr_id = 22
WHERE V01.dat_bis = DATE '9999-12-31';