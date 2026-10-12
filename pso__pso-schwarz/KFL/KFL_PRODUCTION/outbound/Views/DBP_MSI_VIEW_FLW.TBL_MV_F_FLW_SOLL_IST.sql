CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.tbl_mv_f_flw_soll_ist AS SELECT v00.mandant_id,
 v00.flw_art_id AS in_art_id,
 v00.charge_id,
 v00.werk_id,
 v00.dat_soll_ist,
 v00.auftrag_id,
 v00.wechsel_id,
 v00.flw_lief_id AS in_lief_id,
 v00.ist_menge_bme,
 v00.ist_menge_dme,
 v00.dme_einh_id,
 v00.basismenge_einh_id,
 v00.best_beleg_id,
 v00.input_material_typ_id,
 v00.soll_menge_bme,
 v00.zerl_soll_menge_bme,
 v00.betrag_soll_ist,
 v00.wrg_id,
 v00.trennprozess_id,
 v00.schnittliste_id,
 v00.sek_schl_id,
 v00.soll_ohne_ist_fg,
 DT8.preis_steuer_kz,
 DT8.gld,
 DT8.preis_faktor,
 DT8.standard_preis,
 DT8.wrg_id AS wrg_id_dt8,
 V100.default_wrg,
 V06.wrg_id AS wrg_id_v06,
 V06.nettopreis,
 V06.bruttopreis
FROM (SELECT COALESCE(V02.mandant_id, v04.mandant_id) AS mandant_id,
   COALESCE(V02.flw_art_id, v04.flw_art_id) AS flw_art_id,
   V02.charge_id,
   COALESCE(V01.flw_lief_id, v04.flw_lief_id) AS flw_lief_id,
   COALESCE(V02.werk_id, v04.werk_id) AS werk_id,
   COALESCE(V02.dat_soll_ist, v04.dat_kalk) AS dat_soll_ist,
   COALESCE(V02.auftrag_id, v04.auftrag_id) AS auftrag_id,
   COALESCE(V02.wechsel_id, v04.wechsel_id) AS wechsel_id,
   V02.menge_bme AS ist_menge_bme,
   V02.menge_dme AS ist_menge_dme,
   V02.dme_einh_id,
   V02.basismenge_einh_id,
   V02.best_beleg_id,
   COALESCE(V02.input_material_typ_id, 'O') AS input_material_typ_id,
    CASE
    WHEN V02.trennprozess_id = 'ZERL' AND v04.ctlmp_soll_menge = 0
    THEN v04.cutp_soll_menge
    ELSE v04.ctlmp_soll_menge
    END AS soll_menge_bme,
   v04.ctlmp_soll_menge AS zerl_soll_menge_bme,
   V02.betrag_soll_ist,
   COALESCE(V02.wrg_id, v04.wrg_id) AS wrg_id,
   COALESCE(V02.trennprozess_id, v04.trennprozess_id) AS trennprozess_id_,
    CASE
    WHEN V02.trennprozess_id = 'ZERL' OR V01.flw_lief_id > - 1
    THEN V02.trennprozess_id
    WHEN COALESCE(V02.trennprozess_id, v04.trennprozess_id) IN ('', 'SDZ') AND (V02.menge_bme > 0 OR v04.ctlmp_soll_menge
         > 0)
    THEN COALESCE(V02.trennprozess_id, v04.trennprozess_id)
    ELSE NULL
    END AS trennprozess_id,
   COALESCE(V02.schnittliste_id, v04.schnittliste_id) AS schnittliste_id,
   COALESCE(V01.materialwert_kalk_id, v04.materialwert_kalk_id) AS sek_schl_id,
    CASE
    WHEN v04.mandant_id IS NOT NULL AND V01.mandant_id IS NULL
    THEN 1
    ELSE 0
    END AS soll_ohne_ist_fg
  FROM kfl_production_dbp_view.v_flw_kalk_wechsel AS V01
   INNER JOIN kfl_production_dbp_view.v_flw_soll_ist AS V02 ON V01.werk_id = V02.werk_id AND V01.dat_kalk = V02.dat_soll_ist
          AND V01.trennprozess_id = V02.trennprozess_id AND V01.wechsel_id = V02.wechsel_id AND V01.auftrag_id = V02.auftrag_id
       AND V01.schnittliste_id = V02.schnittliste_id
   FULL JOIN (SELECT DT1.mandant_id,
     DT1.flw_art_id,
     DT1.sek_schl_id AS materialwert_kalk_id,
     DT1.wrg_id,
     DT1.schnittliste_id,
     DT3.auftrag_id,
     DT3.dat_kalk,
     DT3.trennprozess_id,
     DT3.wechsel_id,
     DT3.werk_id,
     DT3.tiergattung_id,
     DT3.flw_lief_id,
     dt2.cutp_soll_menge,
     DT1.menge AS ctlmp_soll_menge
    FROM kfl_production_dbp_view.v_flw_kalk_preise AS DT1
     LEFT JOIN (SELECT SOD.mandant_id,
       SOD.flw_art_id,
       SOD.sek_schl_id,
       SUM(SOD.menge_schnitt) AS cutp_soll_menge
      FROM kfl_production_dbp_view.v_flw_schnitt_output_det AS SOD
       INNER JOIN kfl_production_dbp_view.v_flw_schnitt_input AS SI ON SOD.schnitt_id = SI.schnitt_id AND SOD.sek_schl_typ_id
            = SI.sek_schl_typ_id AND SOD.sek_schl_id = SI.sek_schl_id AND SOD.mandant_id = SI.mandant_id
      WHERE SI.sek_schl_typ_id = 'M'
       AND SI.trennprozess_id = 'ZERL'
      GROUP BY SOD.sek_schl_id,
       SOD.mandant_id,
       SOD.flw_art_id) AS dt2 ON DT1.mandant_id = dt2.mandant_id AND DT1.flw_art_id = dt2.flw_art_id AND DT1.sek_schl_id
        = dt2.sek_schl_id
     INNER JOIN kfl_production_dbp_view.v_flw_kalk_wechsel AS DT3 ON DT1.mandant_id = DT3.mandant_id AND DT1.sek_schl_id
        = DT3.materialwert_kalk_id
    WHERE DT1.input_material_typ_id = 'O'
     AND DT1.sek_schl_typ_id = 'M') AS v04 ON V01.materialwert_kalk_id = v04.materialwert_kalk_id AND V01.mandant_id =
      v04.mandant_id AND V02.flw_art_id = v04.flw_art_id) AS v00
 INNER JOIN kfl_production_dbp_view.v_flw_werk AS V03 ON v00.mandant_id = V03.mandant_id AND v00.werk_id = V03.werk_id
 LEFT JOIN (SELECT mandant_id,
   charge_id,
   min_dat_erfasst,
   SUM(nettogew) AS nettogew
  FROM kfl_production_dbp_view.v_flw_bew
  WHERE flw_beleg_typ_id = 'WE'
   AND beleg_gruppe_id = 'B'
   AND status_mb IN ('A', 'C', 'D')
   AND storno_fg = 0
   AND charge_id <> ''
  GROUP BY mandant_id,
   charge_id,
   min_dat_erfasst) AS v05 ON v00.charge_id = v05.charge_id AND v00.mandant_id = v05.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_flw_art_marktpreis_per AS V06 ON v00.werk_id = V06.werk_id AND v00.mandant_id = V06
      .mandant_id AND v00.flw_art_id = V06.flw_art_id AND v00.dat_soll_ist BETWEEN V06.dat_von AND V06.dat_bis AND V06.flw_version_id
    IN ('MMS', 'OFS', 'MOS', 'HNV', 'MMB', 'OFB', 'MOB')
 INNER JOIN kfl_production_dbp_view.v_mandant AS V100 ON v00.mandant_id = V100.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_art_bewertungskreis_per AS DT8 ON v00.mandant_id = DT8.mandant_id AND v00.flw_art_id
      = DT8.flw_art_id AND v00.dat_soll_ist BETWEEN DT8.dat_von AND DT8.dat_bis AND V03.werk_nr = DT8.bewertungskreis_id;