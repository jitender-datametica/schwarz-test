CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_IN_WARTUNGSPLAN_DET_2(
	WERK_ID,
	MANDANT_ID,
	TP_OBJEKT_ID,
	TECHN_PLATZ_ID,
	WART_PLAN_ID,
	WART_PLAN_POS_ID,
	WART_PLAN_ABRUF_ID,
	ARBEITSPLAN_ID,
	INSTANDHALTUNG_LEISTUNGSART_ID,
	QUAL_MELDUNG_ID,
	DAT_PLAN,
	DAT_ERLEDIGUNG,
	UMTERMINIERUNG_WARTUNGSPLAN_FG,
	DAT_START,
	ZYKLUS_WERT,
	ZYKLUS_EINH_ID,
	AUFTRAG_ID,
	AUFTRAGSART_ID,
	MONATSENDE_UVV,
	WRG_ID,
	DELTA_IN_TAGEN_MONATSENDEUVV_ZU_ERLEDIGUNGSDATUM,
	DELTA_IN_TAGEN_ERLEDIGUNGSDATUM_ECKSTARTTERMIN,
	WART_PLAN_STATUS_ID,
	ARBEITSPLAN_MENGE,
	BETRAG,
	IST_MENGE,
	ANZAHL_WARTUNGSPOSITIONEN_GEPLANT_IST,
	ANZAHL_WARTUNGSPOSITIONEN_ERLEDIGT_IST,
	ANZAHL_WARTUNGSPOSITIONEN_GEPLANT_IST_STUNDEN,
	ANZAHL_WARTUNGSPOSITIONEN_ERLEDIGT_IST_STUNDEN,
	ANZAHL_WARTUNGSPOSITIONEN_ERLEDIGT_IST_NOT_STUNDEN,
	ANZAHL_WARTUNGSPOSITIONEN_GEPLANT_IST_NOT_STUNDEN,
	ANZAHL_UMTERMINIERUNGEN_NACH_DEM_ABRUFDATUM,
	ANZAHL_UMTERMINIERUNGEN_TOTAL,
	ANZAHL_WARTUNGSPOSITIONEN_ERLEDIGT_IST_STUNDEN_LEISTUNGSART,
	ANZAHL_WARTUNGSPOSITIONEN_GEPLANT_LEISTUNGSART,
	ANZAHL_TERMINGERECHTE_DURCHFUHRUNG_UVV,
	ANZAHL_WARTUNGSPOSITIONEN_OFFEN
) AS
--2023-01-02,AP0153902_SPEC0181369, dknop, initial
--2023-02-28,AP0153902_SPEC0181369, dknop, updating table name 
--2023-04-25,AP0153902_SPEC0181369, dknop, removing leading zeros from plangruppe_id in arbeitsplan_id
--2023-06-16,AP0153902_SPEC0181369, dknop, adding wart_plan_status_id
--2023-07-21, dknop, adding dbp_view.v_in_wartungsplan_abruf_2
--2023-10-26, dknop, replacing in_w_hist.dat_erledigung with in_w_ab.dat_abschluss
--2023-11-23, dknop, adding instandhaltung_leistungsart_id <> '300'
--2024-01-24, dknop, updating logic for anzahl_termingerechte_durchfuhrung_UVV
--2024-02-20, dknop, updating techn_platz_id to be taken from v_tp_objekt_per_2
--2024-04-22, adding filter  dknop,  auftrag_id = '-1' AND dat_plan < current_date -2
--2024-08-27, AP0226234,SPEC0255818, dknop, change tp_objekt_id source from v_in_instandhaltung_objekt_qual_2 to v_in_instandhaltung_2
--2025-04-10, adding filter  dknop,  correcting condtion auftrag_id = '-1' AND dat_plan < current_date -2
SELECT 
 in_w_det.werk_id
,in_w_det.mandant_id
,CASE WHEN in_w_det.tp_objekt_id=0 THEN COALESCE(COALESCE(in_inst.tp_objekt_id,in_inst_add.tp_objekt_id), '-1') ELSE in_w_det.tp_objekt_id END AS tp_objekt_id
,COALESCE(tp.techn_platz_id,'-1') AS techn_platz_id
,in_w_hist.wart_plan_id
,in_w_det.wart_plan_pos_id
,in_w_hist.wart_plan_abruf_id 
,CONCAT(in_w_det.plantyp_id,'/', LTRIM(in_w_det.plangruppe_id,0),'/',in_w_det.plangruppenzaehler) AS arbeitsplan_id
,in_w_det.instandhaltung_leistungsart_id
,in_w_ab.qual_meldung_id
,in_w_hist.dat_plan--
,in_w_ab.dat_abschluss AS dat_erledigung --,in_w_hist.dat_erledigung AS dat_erledigung
,CASE WHEN in_w_hist.dat_plan <> in_a_pps.dat_start THEN 1 ELSE 0 END umterminierung_wartungsplan_fg
,in_a_pps.dat_start AS dat_start
,in_w_z.zyklus_wert
,in_w_z.zyklus_einh_id
,COALESCE(CASE WHEN in_w_ab.auftrag_id='' THEN NULL ELSE in_w_ab.auftrag_id END,'-1') AS auftrag_id_
,COALESCE(COALESCE(in_a.auftragsart_id,
                   CASE WHEN COALESCE(tp.tp_objekt_typ,'-1')= '3' THEN 'CS36'
                        WHEN COALESCE(tp.tp_objekt_typ,'-1')= '4' THEN 'CS46'
                        WHEN COALESCE(tp.tp_objekt_typ,'-1')= '5' THEN 'CS56'
                        WHEN COALESCE(tp.tp_objekt_typ,'-1')= '7' THEN 'CS76'
                        ELSE '-1'END ),'-1') AS auftragsart_id_---
,CASE WHEN in_w_det.instandhaltung_leistungsart_id='012' THEN LAST_DAY(in_w_hist.dat_plan) ELSE NULL END AS monatsende_UVV
,COALESCE (ist_kost_1.wrg_id, '-1') AS wrg_id
,SUM(CASE WHEN in_w_det.instandhaltung_leistungsart_id='012' THEN DATEDIFF(DAY,monatsende_UVV,in_w_ab.dat_abschluss ) ELSE NULL END) AS delta_in_tagen_monatsendeUVV_zu_erledigungsdatum
,SUM(CASE WHEN in_a_pps.dat_start IS NOT NULL AND in_w_ab.dat_abschluss IS NOT NULL THEN DATEDIFF(DAY,in_w_ab.dat_abschluss,in_a_pps.dat_start) ELSE NULL END) AS delta_in_tagen_erledigungsdatum_eckstarttermin
,LISTAGG(DISTINCT in_w_status.wart_plan_status_id,' ') WITHIN GROUP (ORDER BY in_w_status.wart_plan_status_id ASC) AS wart_plan_status_id
,SUM(CASE WHEN arbeitsplan_menge.arbeitsplan_menge_einh_id IN ('STD', 'H') THEN arbeitsplan_menge 
      WHEN arbeitsplan_menge.arbeitsplan_menge_einh_id IN ('MIN') THEN arbeitsplan_menge/60
      WHEN arbeitsplan_menge.arbeitsplan_menge_einh_id IN ('SEK', 'SEC') THEN arbeitsplan_menge/3600
      ELSE arbeitsplan_menge END) AS arbeitsplan_menge
,SUM(ist_kost_1.betrag) AS betrag
,ZEROIFNULL(SUM(CASE WHEN ist_kost_1.menge_einh_id IN ('STD', 'H') THEN ist_kost_1.menge
      WHEN ist_kost_1.menge_einh_id IN ('MIN') THEN ist_kost_1.menge/60
      WHEN ist_kost_1.menge_einh_id IN ('SEK', 'SEC') THEN ist_kost_1.menge/3600
      ELSE ist_kost_1.menge END)) AS ist_menge
,COUNT(DISTINCT in_w_det.wart_plan_pos_id) AS anzahl_wartungspositionen_geplant_ist
,CASE WHEN in_w_ab.dat_abschluss IS NOT NULL THEN COUNT(DISTINCT in_w_det.wart_plan_pos_id) ELSE 0 END AS anzahl_wartungspositionen_erledigt_ist

,CASE WHEN ist_menge> 0 THEN COUNT(DISTINCT in_w_det.wart_plan_pos_id) ELSE 0 END AS anzahl_wartungspositionen_geplant_ist_stunden
,CASE WHEN ist_menge> 0 AND in_w_ab.dat_abschluss IS NOT NULL THEN COUNT(DISTINCT in_w_det.wart_plan_pos_id) ELSE 0 END AS anzahl_wartungspositionen_erledigt_ist_stunden


,CASE WHEN (ist_menge= 0 OR ist_menge IS NULL) AND in_w_ab.dat_abschluss IS NOT NULL THEN COUNT(DISTINCT in_w_det.wart_plan_pos_id) ELSE 0 END AS anzahl_wartungspositionen_erledigt_ist_not_stunden
,CASE WHEN (ist_menge= 0 OR ist_menge IS NULL) THEN COUNT(DISTINCT in_w_det.wart_plan_pos_id) ELSE 0 END AS anzahl_wartungspositionen_geplant_ist_not_stunden

,CASE WHEN umterminierung_wartungsplan_fg= 1 THEN COUNT (umterminierung_wartungsplan_fg) ELSE 0 END anzahl_umterminierungen_nach_dem_abrufdatum
,COUNT(umterminierung_wartungsplan_fg) AS anzahl_umterminierungen_total
,CASE WHEN in_w_det.instandhaltung_leistungsart_id='012' AND in_w_ab.dat_abschluss IS NOT NULL THEN COUNT(DISTINCT in_w_det.wart_plan_pos_id) ELSE 0 END AS anzahl_wartungspositionen_erledigt_ist_stunden_leistungsart

,CASE WHEN in_w_det.instandhaltung_leistungsart_id='012' THEN COUNT(DISTINCT in_w_det.wart_plan_pos_id) ELSE 0 END AS anzahl_wartungspositionen_geplant_leistungsart

,CASE WHEN auftragsart_id_ IN ('CS34', 'CS44','CS36', 'CS46', 'CS56', 'CS76') THEN 
                                                             CASE WHEN in_w_det.instandhaltung_leistungsart_id='012' AND delta_in_tagen_monatsendeUVV_zu_erledigungsdatum<=0 AND ist_menge> 0 
                                                             THEN COUNT(DISTINCT in_w_det.wart_plan_pos_id) ELSE 0 END
                                                             ELSE CASE WHEN in_w_det.instandhaltung_leistungsart_id='012' AND delta_in_tagen_monatsendeUVV_zu_erledigungsdatum<=0
                                                             THEN COUNT(DISTINCT in_w_det.wart_plan_pos_id) ELSE 0 END
                                                             END AS anzahl_termingerechte_durchfuhrung_UVV      
,CASE WHEN in_w_ab.dat_abschluss IS NULL THEN COUNT (DISTINCT in_w_det.wart_plan_pos_id) ELSE 0 END AS anzahl_wartungspositionen_offen

FROM dbp_view.v_in_wartungsplan_hist_2 in_w_hist 

JOIN dbp_view.v_in_wartungsplan_abruf_2 in_w_ab
ON in_w_hist.wart_plan_id = in_w_ab.wart_plan_id
AND in_w_hist.wart_plan_abruf_id = in_w_ab.wart_plan_abruf_id
AND in_w_hist.mandant_id = in_w_ab.mandant_id

JOIN dbp_view.v_in_wartungsplan_det_2 in_w_det
ON in_w_ab.mandant_id = in_w_det.mandant_id
AND in_w_ab.wart_plan_id = in_w_det.wart_plan_id
AND in_w_ab.wart_plan_pos_id = in_w_det.wart_plan_pos_id
AND in_w_det.instandhaltung_leistungsart_id <> '300'


JOIN (SELECT
       mandant_id
      ,dat_von
      ,dat_bis
      ,wart_plan_id
      ,wart_plan_status_id FROM dbp_view.v_in_wartungsplan_status_per_2) in_w_status
ON in_w_hist.mandant_id = in_w_status.mandant_id
AND in_w_hist.wart_plan_id = in_w_status.wart_plan_id
AND in_w_hist.dat_plan BETWEEN in_w_status.dat_von AND in_w_status.dat_bis

JOIN (SELECT
       in_pk_per.mandant_id
      ,in_pk_per.plantyp_id
      ,in_pk_per.plangruppe_id
      ,in_pg_pk_zu_per.plangruppenzaehler
      ,in_pk_per.arbeitsplan_menge_einh_id
      ,in_pk_per.dat_von
      ,in_pk_per.dat_bis
      ,SUM(in_pk_per.arbeitsplan_menge) AS arbeitsplan_menge FROM dbp_view.v_in_planknoten_per_2 in_pk_per

JOIN dbp_view.v_in_plan_planknoten_zu_per_2 in_pg_pk_zu_per
ON in_pk_per.plantyp_id = in_pg_pk_zu_per.plantyp_id
AND in_pk_per.plangruppe_id = in_pg_pk_zu_per.plangruppe_id
AND in_pk_per.planknotenzaehler_int = in_pg_pk_zu_per.planknotenzaehler_int 
AND in_pk_per.mandant_id = in_pg_pk_zu_per.mandant_id 
AND in_pg_pk_zu_per.loesch_fg=0
      GROUP BY
       in_pk_per.mandant_id
      ,in_pk_per.plantyp_id
      ,in_pk_per.plangruppe_id
      ,in_pg_pk_zu_per.plangruppenzaehler
      ,in_pk_per.arbeitsplan_menge_einh_id
      ,in_pk_per.dat_von
      ,in_pk_per.dat_bis
     ) arbeitsplan_menge

ON in_w_det.plantyp_id = arbeitsplan_menge.plantyp_id
AND in_w_det.mandant_id = arbeitsplan_menge.mandant_id
AND in_w_det.plangruppe_id = arbeitsplan_menge.plangruppe_id
AND in_w_det.plangruppenzaehler = arbeitsplan_menge.plangruppenzaehler
AND in_w_hist.dat_plan  BETWEEN arbeitsplan_menge.dat_von AND arbeitsplan_menge.dat_bis 

LEFT JOIN dbp_view.v_in_instandhaltung_2 in_inst
ON in_w_ab.wart_plan_id = in_inst.wart_plan_id
AND in_w_ab.wart_plan_abruf_id = in_inst.wart_plan_abruf_id
AND in_w_ab.mandant_id = in_inst.mandant_id
AND in_w_ab.wart_plan_pos_id = in_inst.wart_plan_pos_id
--AND in_w_ab.auftrag_id = in_inst.auftrag_id


LEFT JOIN (SELECT mandant_id,auftrag_id,wart_plan_id, tp_objekt_id,
ROW_NUMBER() OVER (PARTITION BY  wart_plan_id ORDER BY wart_plan_abruf_id DESC) AS flag FROM dbp_view.v_in_instandhaltung_2 in_inst
)in_inst_add
ON in_w_hist.wart_plan_id = in_inst_add.wart_plan_id
--AND in_w_hist.wart_plan_abruf_id = in_inst_add.wart_plan_abruf_id
AND in_inst_add.flag=1

LEFT JOIN dbp_view.v_in_auftrag_pps_2 in_a_pps
ON  in_inst.mandant_id=in_a_pps.mandant_id
AND in_inst.auftrag_id=in_a_pps.auftrag_id

LEFT JOIN dbp_view.v_in_auftrag_2 in_a
ON  in_inst.mandant_id=in_a.mandant_id
AND in_inst.auftrag_id=in_a.auftrag_id

LEFT JOIN dbp_view.v_in_wartungsplan_zyklus_2 in_w_z
ON in_w_det.mandant_id = in_w_z.mandant_id
AND in_w_det.wart_plan_id = in_w_z.wart_plan_id

LEFT JOIN 
(SELECT 
 COALESCE(CASE WHEN kost_det.auftrag_id='' THEN NULL ELSE kost_det.auftrag_id END,'-1') AS auftrag_id,
 kost_det.mandant_id,
 kost_det.wrg_id,
 kost_det.menge_einh_id,
 SUM(kost_det.betrag* kurs.umrechnungskurs) AS betrag,
 SUM(kost_det.menge) AS menge
 FROM
 dbp_view.v_ist_kosten_det_2 kost_det
 LEFT JOIN dbp_msi_view_log.mv_kurs_2 kurs_2
   ON kost_det.wrg_id = kurs.von_wrg_id
   INNER JOIN dbp_view.v_mandant_wrg_typ_zu_2 wrg_2 ON kost_det.mandant_id=wrg.mandant_id  
   INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_2 wrg_typ ON wrg.wrg_typ_id = wrg_typ.wrg_typ_id
  
 WHERE 
 kost_det.soll_haben_kz = 'S'
AND kost_det.co_leistungsart_id IN ('INST01', 'INST02', 'INST03', 'INST04', 
                                    'INST05', 'INST06', 'INST07', 'INST08', 
                                    'INST09', 'INST10', 'INST70', 'INST71', 'INST72', 
                                    'INST73', 'INST74', 'INST75', 'INST76', 'INST88','INST62','INST63')
AND (kost_det.nebenkontierungsart_id <> '0CCT' OR kost_det.nebenkontierungsart_id IS NULL)


GROUP BY
 kost_det.auftrag_id,
 kost_det.mandant_id,
 kost_det.wrg_id,
 kost_det.menge_einh_id
) ist_kost_1
ON COALESCE(in_w_ab.auftrag_id,'-1')=ist_kost_1.auftrag_id
AND in_w_ab.mandant_id=ist_kost_1.mandant_id

LEFT JOIN dbp_view.v_tp_objekt_per_2 tp
ON CASE WHEN in_w_det.tp_objekt_id=0 THEN COALESCE(COALESCE(in_inst.tp_objekt_id,in_inst_add.tp_objekt_id), '-1') ELSE in_w_det.tp_objekt_id END = tp.tp_objekt_id
AND in_w_det.mandant_id=tp.mandant_id
AND in_w_hist.dat_plan BETWEEN tp.dat_von AND tp.dat_bis

WHERE ((in_w_hist.dat_plan < CURRENT_DATE - 2 AND auftrag_id_ <> '-1') OR (in_w_hist.dat_plan > CURRENT_DATE - 2) OR (ist_kost_1.auftrag_id='-1'))
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20
 ;