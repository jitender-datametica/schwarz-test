-- 2023-10-26, dknop, replacing in_w_hist.dat_erledigung with in_w_ab.dat_abschluss

-- 2023-11-23, dknop, adding instandhaltung_leistungsart_id <> '300'

-- 2023-06-16,AP0153902_SPEC0181369, dknop, adding wart_plan_status_id

-- 2025-04-10, adding filter  dknop,  correcting condtion auftrag_id = '-1' AND dat_plan < current_date -2

-- 2023-01-02,AP0153902_SPEC0181369, dknop, initial
 -- 2023-07-21, dknop, adding dbp_view.v_in_wartungsplan_abruf_1

-- 2024-04-22, adding filter  dknop,  auftrag_id = '-1' AND dat_plan < current_date -2

-- 2023-04-25,AP0153902_SPEC0181369, dknop, removing leading zeros from plangruppe_id in arbeitsplan_id

-- 2024-02-20, dknop, updating techn_platz_id to be taken from v_tp_objekt_per_1

-- 2024-01-24, dknop, updating logic for anzahl_termingerechte_durchfuhrung_UVV

-- 2024-08-27, AP0226234,SPEC0255818, dknop, change tp_objekt_id source from v_in_instandhaltung_objekt_qual_1 to v_in_instandhaltung_1

-- 2023-02-28,AP0153902_SPEC0181369, dknop, updating table name

CREATE OR REPLACE TABLE FUNCTION kfl_production_dbp_msi_view_log.mv_in_wartungsplan_det_1(USERID STRING) AS
-- ,in_w_hist.dat_erledigung AS dat_erledigung
 -- 
 SELECT t10.werk_id,
 t10.mandant_id,
 t10.tp_objekt_id,
 t10.techn_platz_id,
 t10.wart_plan_id,
 t10.wart_plan_pos_id,
 t10.wart_plan_abruf_id,
 t10.arbeitsplan_id,
 t10.instandhaltung_leistungsart_id,
 t10.qual_meldung_id,
 t10.dat_plan -- 
,
 t10.dat_erledigung,
 t10.umterminierung_wartungsplan_fg,
 t10.dat_start,
 t10.zyklus_wert,
 t10.zyklus_einh_id,
 t10.auftrag_id_,
 t10.auftragsart_id_,
 t10.monatsende_uvv,
 t10.wrg_id,
 t10.delta_in_tagen_monatsendeuvv_zu_erledigungsdatum,
 t10.delta_in_tagen_erledigungsdatum_eckstarttermin,
 t10.wart_plan_status_id,
 t10.arbeitsplan_menge,
 t10.betrag,
 IFNULL(t10.a0, 0) AS ist_menge,
 t10.anzahl_wartungspositionen_geplant_ist,
  CASE
  WHEN t10.dat_erledigung IS NOT NULL
  THEN CAST(t10.anzahl_wartungspositionen_geplant_ist AS INTEGER)
  ELSE 0
  END AS anzahl_wartungspositionen_erledigt_ist,
  CASE
  WHEN IFNULL(t10.a0, 0) > 0
  THEN CAST(t10.anzahl_wartungspositionen_geplant_ist AS INTEGER)
  ELSE 0
  END AS anzahl_wartungspositionen_geplant_ist_stunden,
  CASE
  WHEN IFNULL(t10.a0, 0) > 0 AND t10.dat_erledigung IS NOT NULL
  THEN CAST(t10.anzahl_wartungspositionen_geplant_ist AS INTEGER)
  ELSE 0
  END AS anzahl_wartungspositionen_erledigt_ist_stunden,
  CASE
  WHEN (IFNULL(t10.a0, 0) = 0 OR IFNULL(t10.a0, 0) IS NULL) AND t10.dat_erledigung IS NOT NULL
  THEN CAST(t10.anzahl_wartungspositionen_geplant_ist AS INTEGER)
  ELSE 0
  END AS anzahl_wartungspositionen_erledigt_ist_not_stunden,
  CASE
  WHEN IFNULL(t10.a0, 0) = 0 OR IFNULL(t10.a0, 0) IS NULL
  THEN CAST(t10.anzahl_wartungspositionen_geplant_ist AS INTEGER)
  ELSE 0
  END AS anzahl_wartungspositionen_geplant_ist_not_stunden,
  CASE
  WHEN t10.umterminierung_wartungsplan_fg = 1
  THEN CAST(t10.a0_0 AS INTEGER)
  ELSE 0
  END AS anzahl_umterminierungen_nach_dem_abrufdatum,
 t10.a0_0 AS anzahl_umterminierungen_total,
  CASE
  WHEN t10.instandhaltung_leistungsart_id = '012' AND t10.dat_erledigung IS NOT NULL
  THEN CAST(t10.anzahl_wartungspositionen_geplant_ist AS INTEGER)
  ELSE 0
  END AS anzahl_wartungspositionen_erledigt_ist_stunden_leistungsart,
  CASE
  WHEN t10.instandhaltung_leistungsart_id = '012'
  THEN CAST(t10.anzahl_wartungspositionen_geplant_ist AS INTEGER)
  ELSE 0
  END AS anzahl_wartungspositionen_geplant_leistungsart,
  CASE
  WHEN t10.auftragsart_id_ IN ('CS34', 'CS44', 'CS36', 'CS46', 'CS56', 'CS76')
  THEN CASE
   WHEN t10.instandhaltung_leistungsart_id = '012' AND t10.delta_in_tagen_monatsendeuvv_zu_erledigungsdatum <= 0 AND
     IFNULL(t10.a0, 0) > 0
   THEN CAST(t10.anzahl_wartungspositionen_geplant_ist AS INTEGER)
   ELSE 0
   END
  ELSE CASE
   WHEN t10.instandhaltung_leistungsart_id = '012' AND t10.delta_in_tagen_monatsendeuvv_zu_erledigungsdatum <= 0
   THEN CAST(t10.anzahl_wartungspositionen_geplant_ist AS INTEGER)
   ELSE 0
   END
  END AS anzahl_termingerechte_durchfuhrung_uvv,
  CASE
  WHEN t10.dat_erledigung IS NULL
  THEN CAST(t10.anzahl_wartungspositionen_geplant_ist AS INTEGER)
  ELSE 0
  END AS anzahl_wartungspositionen_offen
FROM (SELECT IN_W_DET.werk_id,
   IN_W_DET.mandant_id,
    CASE
    WHEN IN_W_DET.tp_objekt_id = 0
    THEN COALESCE(COALESCE(IN_INST.tp_objekt_id, in_inst_add.tp_objekt_id), -1)
    ELSE IN_W_DET.tp_objekt_id
    END AS tp_objekt_id,
   COALESCE(TP.techn_platz_id, '-1') AS techn_platz_id,
   IN_W_HIST.wart_plan_id,
   IN_W_DET.wart_plan_pos_id,
   IN_W_HIST.wart_plan_abruf_id,
   CONCAT(IN_W_DET.plantyp_id, '/', LTRIM(IN_W_DET.plangruppe_id, '0'), '/', IN_W_DET.plangruppenzaehler) AS
   arbeitsplan_id,
   IN_W_DET.instandhaltung_leistungsart_id,
   IN_W_AB.qual_meldung_id,
   IN_W_HIST.dat_plan,
   IN_W_AB.dat_abschluss AS dat_erledigung,
    CASE
    WHEN IN_W_HIST.dat_plan <> IN_A_PPS.dat_start
    THEN 1
    ELSE 0
    END AS umterminierung_wartungsplan_fg,
   IN_A_PPS.dat_start,
   IN_W_Z.zyklus_wert,
   IN_W_Z.zyklus_einh_id,
   COALESCE(CASE
     WHEN IN_W_AB.auftrag_id = ''
     THEN NULL
     ELSE IN_W_AB.auftrag_id
     END, '-1') AS auftrag_id_,
   COALESCE(COALESCE(IN_A.auftragsart_id, CASE
      WHEN COALESCE(TP.tp_objekt_typ, '-1') = '3'
      THEN 'CS36'
      WHEN COALESCE(TP.tp_objekt_typ, '-1') = '4'
      THEN 'CS46'
      WHEN COALESCE(TP.tp_objekt_typ, '-1') = '5'
      THEN 'CS56'
      WHEN COALESCE(TP.tp_objekt_typ, '-1') = '7'
      THEN 'CS76'
      ELSE '-1'
      END), '-1') AS auftragsart_id_,
    CASE
    WHEN IN_W_DET.instandhaltung_leistungsart_id = '012'
    THEN LAST_DAY(IN_W_HIST.dat_plan, MONTH)
    ELSE NULL
    END AS monatsende_uvv,
   COALESCE(ist_kost_1.wrg_id, '-1') AS wrg_id,
   SUM(CASE
     WHEN IN_W_DET.instandhaltung_leistungsart_id = '012'
     THEN DATE_DIFF(IN_W_AB.dat_abschluss, CASE
       WHEN IN_W_DET.instandhaltung_leistungsart_id = '012'
       THEN LAST_DAY(IN_W_HIST.dat_plan, MONTH)
       ELSE NULL
       END, DAY)
     ELSE NULL
     END) AS delta_in_tagen_monatsendeuvv_zu_erledigungsdatum,
   SUM(CASE
     WHEN IN_A_PPS.dat_start IS NOT NULL AND IN_W_AB.dat_abschluss IS NOT NULL
     THEN DATE_DIFF(IN_A_PPS.dat_start, IN_W_AB.dat_abschluss, DAY)
     ELSE NULL
     END) AS delta_in_tagen_erledigungsdatum_eckstarttermin,
   STRING_AGG( in_w_status.wart_plan_status_id, ' ' ORDER BY in_w_status.wart_plan_status_id IS NULL,
     in_w_status.wart_plan_status_id) AS wart_plan_status_id,
   SUM(CASE
     WHEN arbeitsplan_menge0.arbeitsplan_menge_einh_id IN ('STD', 'H')
     THEN arbeitsplan_menge0.arbeitsplan_menge
     WHEN arbeitsplan_menge0.arbeitsplan_menge_einh_id IN ('MIN')
     THEN arbeitsplan_menge0.arbeitsplan_menge / 60
     WHEN arbeitsplan_menge0.arbeitsplan_menge_einh_id IN ('SEK', 'SEC')
     THEN arbeitsplan_menge0.arbeitsplan_menge / 3600
     ELSE arbeitsplan_menge0.arbeitsplan_menge
     END) AS arbeitsplan_menge,
   SUM(ist_kost_1.betrag) AS betrag,
   SUM(CASE
     WHEN ist_kost_1.menge_einh_id IN ('STD', 'H')
     THEN ist_kost_1.menge
     WHEN ist_kost_1.menge_einh_id IN ('MIN')
     THEN ist_kost_1.menge / 60
     WHEN ist_kost_1.menge_einh_id IN ('SEK', 'SEC')
     THEN ist_kost_1.menge / 3600
     ELSE ist_kost_1.menge
     END) AS a0,
   COUNT(DISTINCT IN_W_DET.wart_plan_pos_id) AS anzahl_wartungspositionen_geplant_ist,
   COUNT(CASE
     WHEN IN_W_HIST.dat_plan <> IN_A_PPS.dat_start
     THEN 1
     ELSE 0
     END) AS a0_0
  FROM kfl_production_dbp_view.v_in_wartungsplan_hist_1 AS IN_W_HIST
   INNER JOIN kfl_production_dbp_view.v_in_wartungsplan_abruf_1 AS IN_W_AB ON IN_W_HIST.wart_plan_id = IN_W_AB.wart_plan_id
       AND IN_W_HIST.wart_plan_abruf_id = IN_W_AB.wart_plan_abruf_id AND IN_W_HIST.mandant_id = IN_W_AB.mandant_id
   INNER JOIN kfl_production_dbp_view.v_in_wartungsplan_det_1 AS IN_W_DET ON IN_W_AB.mandant_id = IN_W_DET.mandant_id AND
       IN_W_AB.wart_plan_id = IN_W_DET.wart_plan_id AND IN_W_AB.wart_plan_pos_id = IN_W_DET.wart_plan_pos_id AND
     IN_W_DET.instandhaltung_leistungsart_id <> '300'
   INNER JOIN (SELECT mandant_id,
     dat_von,
     dat_bis,
     wart_plan_id,
     wart_plan_status_id
    FROM kfl_production_dbp_view.v_in_wartungsplan_status_per_1) AS in_w_status ON IN_W_HIST.mandant_id = in_w_status.mandant_id
       AND IN_W_HIST.wart_plan_id = in_w_status.wart_plan_id AND IN_W_HIST.dat_plan BETWEEN in_w_status.dat_von AND
     in_w_status.dat_bis
   INNER JOIN (SELECT IN_PK_PER.mandant_id,
     IN_PK_PER.plantyp_id,
     IN_PK_PER.plangruppe_id,
     IN_PG_PK_ZU_PER.plangruppenzaehler,
     IN_PK_PER.arbeitsplan_menge_einh_id,
     IN_PK_PER.dat_von,
     IN_PK_PER.dat_bis,
     SUM(IN_PK_PER.arbeitsplan_menge) AS arbeitsplan_menge
    FROM kfl_production_dbp_view.v_in_planknoten_per_1 AS IN_PK_PER
     INNER JOIN kfl_production_dbp_view.v_in_plan_planknoten_zu_per_1 AS IN_PG_PK_ZU_PER ON IN_PK_PER.plantyp_id =
          IN_PG_PK_ZU_PER.plantyp_id AND IN_PK_PER.plangruppe_id = IN_PG_PK_ZU_PER.plangruppe_id AND IN_PK_PER.planknotenzaehler_int
          = IN_PG_PK_ZU_PER.planknotenzaehler_int AND IN_PK_PER.mandant_id = IN_PG_PK_ZU_PER.mandant_id AND
       IN_PG_PK_ZU_PER.loesch_fg = 0
    GROUP BY IN_PK_PER.mandant_id,
     IN_PK_PER.plantyp_id,
     IN_PK_PER.plangruppe_id,
     IN_PG_PK_ZU_PER.plangruppenzaehler,
     IN_PK_PER.arbeitsplan_menge_einh_id,
     IN_PK_PER.dat_von,
     IN_PK_PER.dat_bis) AS arbeitsplan_menge0 ON IN_W_DET.plantyp_id = arbeitsplan_menge0.plantyp_id AND IN_W_DET.mandant_id
         = arbeitsplan_menge0.mandant_id AND IN_W_DET.plangruppe_id = arbeitsplan_menge0.plangruppe_id AND IN_W_DET.plangruppenzaehler
       = arbeitsplan_menge0.plangruppenzaehler AND IN_W_HIST.dat_plan BETWEEN arbeitsplan_menge0.dat_von AND
     arbeitsplan_menge0.dat_bis
   LEFT JOIN kfl_production_dbp_view.v_in_instandhaltung_1 AS IN_INST ON IN_W_AB.wart_plan_id = IN_INST.wart_plan_id AND
       IN_W_AB.wart_plan_abruf_id = IN_INST.wart_plan_abruf_id AND IN_W_AB.mandant_id = IN_INST.mandant_id AND IN_W_AB.wart_plan_pos_id
      = IN_INST.wart_plan_pos_id -- AND in_w_ab.auftrag_id = in_inst.auftrag_id

   LEFT JOIN (SELECT mandant_id,
     auftrag_id,
     wart_plan_id,
     tp_objekt_id,
     ROW_NUMBER() OVER (PARTITION BY CAST(wart_plan_id AS STRING) ORDER BY wart_plan_abruf_id IS NULL DESC,
        wart_plan_abruf_id DESC) AS flag
    FROM kfl_production_dbp_view.v_in_instandhaltung_1 AS IN_INST) AS in_inst_add ON IN_W_HIST.wart_plan_id = in_inst_add
     .wart_plan_id -- AND in_w_hist.wart_plan_abruf_id = in_inst_add.wart_plan_abruf_id
 AND in_inst_add.flag = 1
   LEFT JOIN kfl_production_dbp_view.v_in_auftrag_pps_1 AS IN_A_PPS ON IN_INST.mandant_id = IN_A_PPS.mandant_id AND
     IN_INST.auftrag_id = IN_A_PPS.auftrag_id
   LEFT JOIN kfl_production_dbp_view.v_in_auftrag_1 AS IN_A ON IN_INST.mandant_id = IN_A.mandant_id AND IN_INST.auftrag_id
      = IN_A.auftrag_id
   LEFT JOIN kfl_production_dbp_view.v_in_wartungsplan_zyklus_1 AS IN_W_Z ON IN_W_DET.mandant_id = IN_W_Z.mandant_id AND
     IN_W_DET.wart_plan_id = IN_W_Z.wart_plan_id
   LEFT JOIN (SELECT COALESCE(CASE
       WHEN KOST_DET.auftrag_id = ''
       THEN NULL
       ELSE KOST_DET.auftrag_id
       END, '-1') AS auftrag_id,
     KOST_DET.mandant_id,
     KOST_DET.wrg_id,
     KOST_DET.menge_einh_id,
     SUM(KOST_DET.betrag * KURS.umrechnungskurs) AS betrag,
     SUM(KOST_DET.menge) AS menge
    FROM kfl_production_dbp_view.v_ist_kosten_det_1 AS KOST_DET
     LEFT JOIN kfl_production_dbp_msi_view_log.mv_kurs_1 AS KURS_1 ON KOST_DET.wrg_id = KURS.von_wrg_id
     INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_1 AS WRG_1 ON KOST_DET.mandant_id = WRG.mandant_id
     INNER JOIN kfl_production_dbp_msi_view_log.mv_akt_msi_user_prj_wrg_typ_zu_1(USERID) AS WRG_TYP ON WRG.wrg_typ_id = WRG_TYP.wrg_typ_id
      
    WHERE KOST_DET.soll_haben_kz = 'S'
     AND KOST_DET.co_leistungsart_id IN ('INST01', 'INST02', 'INST03', 'INST04', 'INST05', 'INST06', 'INST07', 'INST08'
       , 'INST09', 'INST10', 'INST70', 'INST71', 'INST72', 'INST73', 'INST74', 'INST75', 'INST76', 'INST88', 'INST62',
       'INST63')
     AND KOST_DET.nebenkontierungsart_id <> '0CCT'
    GROUP BY KOST_DET.auftrag_id,
     KOST_DET.mandant_id,
     KOST_DET.wrg_id,
     KOST_DET.menge_einh_id) AS ist_kost_1 ON COALESCE(IN_W_AB.auftrag_id, '-1') = ist_kost_1.auftrag_id AND IN_W_AB.mandant_id
      = ist_kost_1.mandant_id
   LEFT JOIN kfl_production_dbp_view.v_tp_objekt_per_1 AS TP ON CASE
       WHEN IN_W_DET.tp_objekt_id = 0
       THEN COALESCE(COALESCE(IN_INST.tp_objekt_id, in_inst_add.tp_objekt_id), -1)
       ELSE IN_W_DET.tp_objekt_id
       END = TP.tp_objekt_id AND IN_W_DET.mandant_id = TP.mandant_id AND IN_W_HIST.dat_plan BETWEEN TP.dat_von AND TP.dat_bis
     
  WHERE IN_W_HIST.dat_plan < DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY) AND COALESCE(CASE
       WHEN IN_W_AB.auftrag_id = ''
       THEN NULL
       ELSE IN_W_AB.auftrag_id
       END, '-1') <> '-1'
   OR IN_W_HIST.dat_plan > DATE_SUB(CURRENT_DATE, INTERVAL 2 DAY)
   OR ist_kost_1.auftrag_id = '-1'
  GROUP BY IN_W_DET.werk_id,
   IN_W_DET.mandant_id,
   tp_objekt_id,
   techn_platz_id,
   IN_W_HIST.wart_plan_id,
   IN_W_DET.wart_plan_pos_id,
   IN_W_HIST.wart_plan_abruf_id,
   arbeitsplan_id,
   IN_W_DET.instandhaltung_leistungsart_id,
   IN_W_AB.qual_meldung_id,
   IN_W_HIST.dat_plan,
   dat_erledigung,
   umterminierung_wartungsplan_fg,
   IN_A_PPS.dat_start,
   IN_W_Z.zyklus_wert,
   IN_W_Z.zyklus_einh_id,
   auftrag_id_,
   auftragsart_id_,
   monatsende_uvv,
   wrg_id) AS t10;