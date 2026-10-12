CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_buchungen_2 (bon_id, bon_zeile, wup_id, mandant_id,
buchungsschluessel_id, wrg_id, kpos_zahlung_typ_id, dat_booking, bon_dat, start_bon_zeile, kasse_nr, bon_nr,
betrag_buchung, kommentar_buchung) AS SELECT T0.bon_id,
 T0.bon_zeile,
 WUP.aktuell_wup_id AS wup_id,
 T0.mandant_id,
 T0.buchungsschluessel_id,
 SUBSTR(CAST(T0.kpos_zahlung_typ_id AS STRING), 1, 3) AS wrg_id,
 T0.kpos_zahlung_typ_id,
 T0.dat_booking,
 T0.bon_dat,
 CAST(T0.start_bon_zeile AS DATE) AS start_bon_zeile,
 T0.kasse_nr,
 T0.bon_nr,
 T0.betrag_buchung,
 T0.kommentar_buchung
FROM kfl_production_dbp_v_ods.v_ods_bon_buchungen_2 AS T0
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON T0.mandant_id = WUP.mandant_id AND T0.wup_id = WUP.wup_id
WHERE (T0.bon_id, T0.wup_id, T0.mandant_id) NOT IN (SELECT (bon_id, wup_id, mandant_id)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno_2)
UNION ALL
SELECT T1.bon_id,
 0 AS bon_zeile,
 WUP.aktuell_wup_id AS wup_id,
 T1.mandant_id,
 11 AS buchungsschluessel_id,
 T2.wrg_id,
 T2.kpos_zahlung_typ_id,
 T1.dat_booking,
 T1.bon_dat,
 T1.bon_dat AS start_bon_zeile,
 T1.kasse_nr,
 T1.bon_nr,
 SUM(T2.betrag_zahlung) AS betrag_buchung,
 '' AS kommentar_buchung
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_2 AS T1_2
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_zahlung_2 AS T2 ON T1.mandant_id = T2.mandant_id AND T1.wup_id = T2.wup_id
   AND T1.bon_dat = T2.bon_dat AND T1.bon_id = T2.bon_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON T1.mandant_id = WUP.mandant_id AND T1.wup_id = WUP.wup_id
WHERE T1.mandant_id <> 1
GROUP BY T1.bon_id,
 bon_zeile,
 wup_id,
 T1.mandant_id,
 buchungsschluessel_id,
 T2.wrg_id,
 T2.kpos_zahlung_typ_id,
 T1.dat_booking,
 T1.bon_dat,
 start_bon_zeile,
 T1.kasse_nr,
 T1.bon_nr,
 kommentar_buchung;