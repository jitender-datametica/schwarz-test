-- AP0169994, nwag, added discarded OP, uncommented ULI-Handling + other adjustments
 -- AP0169994, dknop, initial

-- AP0169994, nwag, changed ORDPLAN join to SAP-surrogate keys

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_uebernahmequote_vz_2 (art_id,
vz_dispo_artikelstatus_id, menge_einh_id, wup_id, nb_id, gp_id, mandant_id, gp_teilsortiment_id, lagerort_id,
disponent_id, vz_dispo_status_id, autodispo_fg, dat_plan, dat_best, dat_lief, bedarf_netto, bedarf_nach_mbm_art,
bedarf_nach_rundung, bedarf_nach_dyn_rundung, bedarf_nach_mbm_lieferant, bv_quelle_id, bv_quelle_bez, menge_best_gesamt
, menge_best_normal, menge_best_bevorratung, menge_best_iwt, menge_best_werbung, dat_verfuegbarkeit,
dat_bedarfsperiode_ende, dat_bestandsperiode_ende, menge_gesamt_split, menge_iwt_gesamt_split,
menge_werbung_gesamt_split, bestellstatus_vz_id, bestellstatus_vz_short_desc, bestellstatus_vz_desc) AS SELECT DISTINCT
 ART_GP_TAG.art_id,
 ART_GP_TAG.vz_dispo_artikelstatus_id,
 ART_GP_TAG.menge_einh_id,
 GP_VZ_TAG.wup_id,
 GP_VZ_TAG.nb_id,
 GP_VZ_TAG.gp_id,
 GP_VZ_TAG.mandant_id,
 GP_VZ_TAG.gp_teilsortiment_id,
 GP_VZ_TAG.lagerort_id,
 GP_VZ_TAG.disponent_id,
 GP_VZ_TAG.vz_dispo_status_id,
 GP_VZ_TAG.autodispo_fg,
 ART_GP_TAG.dat_plan,
 V_B_VOR.dat_best,
 V_B_VOR.dat_lief,
 V_B_VOR.bedarf_netto,
 V_B_VOR.bedarf_nach_mbm_art,
 V_B_VOR.bedarf_nach_rundung,
 V_B_VOR.bedarf_nach_dyn_rundung,
 V_B_VOR.bedarf_nach_mbm_lieferant,
 V_B_VOR.bv_quelle_id,
  CASE
  WHEN V_B_VOR.bv_quelle_id = 1
  THEN 'OP-Prepare (Standard)'
  WHEN V_B_VOR.bv_quelle_id = 2
  THEN 'Promotion Monitoring (Werbung)'
  ELSE ''
  END AS bv_quelle_bez,
 V_B_VOR.menge_best_gesamt,
 V_B_VOR.menge_best_normal,
 V_B_VOR.menge_best_bevorratung,
 V_B_VOR.menge_best_iwt,
 V_B_VOR.menge_best_werbung,
 V_B_VOR.dat_verfuegbarkeit,
 V_B_VOR.dat_besdarfsperiode_ende AS dat_bedarfsperiode_ende,
 V_B_VOR.dat_bestandsperiode_ende,
 V_B_SPLIT.menge_gesamt AS menge_gesamt_split,
 V_B_SPLIT.menge_iwt_gesamt AS menge_iwt_gesamt_split,
 V_B_SPLIT.menge_werbung_gesamt AS menge_werbung_gesamt_split,
  CASE
  WHEN V_B_SPLIT.menge_gesamt = V_B_VOR.menge_best_gesamt
  THEN '1'
  WHEN COALESCE(V_B_SPLIT.menge_gesamt, 0) = 0
  THEN '2'
  WHEN V_B_SPLIT.menge_gesamt < V_B_VOR.menge_best_gesamt
  THEN '3'
  WHEN V_B_SPLIT.menge_gesamt > V_B_VOR.menge_best_gesamt
  THEN '4'
  ELSE '-1'
  END AS bestellstatus_vz_id,
  CASE
  WHEN V_B_SPLIT.menge_gesamt = V_B_VOR.menge_best_gesamt
  THEN 'VB'
  WHEN COALESCE(V_B_SPLIT.menge_gesamt, 0) = 0
  THEN 'V0'
  WHEN V_B_SPLIT.menge_gesamt < V_B_VOR.menge_best_gesamt
  THEN 'V-'
  WHEN V_B_SPLIT.menge_gesamt > V_B_VOR.menge_best_gesamt
  THEN 'V+'
  ELSE 'n/a'
  END AS bestellstatus_vz_short_desc,
  CASE
  WHEN V_B_SPLIT.menge_gesamt = V_B_VOR.menge_best_gesamt
  THEN 'Übernommen'
  WHEN COALESCE(V_B_SPLIT.menge_gesamt, 0) = 0
  THEN 'Verworfen'
  WHEN V_B_SPLIT.menge_gesamt < V_B_VOR.menge_best_gesamt
  THEN 'Reduziert'
  WHEN V_B_SPLIT.menge_gesamt > V_B_VOR.menge_best_gesamt
  THEN 'Erhöht'
  ELSE 'n/a'
  END AS bestellstatus_vz_desc
FROM kfl_production_dbp_view.v_art_gp_dispo_tag_2 AS ART_GP_TAG
 INNER JOIN kfl_production_dbp_view.v_gp_dispo_vz_tag_2 AS GP_VZ_TAG ON ART_GP_TAG.mandant_id = GP_VZ_TAG.mandant_id AND
    ART_GP_TAG.gp_dispo_id = GP_VZ_TAG.gp_dispo_id AND ART_GP_TAG.dat_plan = GP_VZ_TAG.dat_plan
 INNER JOIN kfl_production_dbp_view.v_vz_best_vor_2 AS V_B_VOR ON ART_GP_TAG.mandant_id = V_B_VOR.mandant_id AND
       ART_GP_TAG.dat_plan = V_B_VOR.dat_plan AND ART_GP_TAG.dat_plan = V_B_VOR.dat_best -- entspr. status_2 quo!
 AND
     ART_GP_TAG.gp_dispo_id = V_B_VOR.gp_dispo_id AND GP_VZ_TAG.wup_id = V_B_VOR.wup_id AND ART_GP_TAG.art_dispo_id =
   V_B_VOR.art_dispo_id
 LEFT JOIN kfl_production_dbp_view.v_vz_best_split_2 AS V_B_SPLIT ON ART_GP_TAG.mandant_id = V_B_SPLIT.mandant_id AND
     ART_GP_TAG.art_dispo_id = V_B_SPLIT.art_dispo_id AND ART_GP_TAG.gp_dispo_id = V_B_SPLIT.gp_dispo_id AND V_B_VOR.dat_verfuegbarkeit
    = V_B_SPLIT.dat_verfuegbarkeit
WHERE ART_GP_TAG.mandant_id = 1 AND ART_GP_TAG.vz_dispo_artikelstatus_id NOT IN (0, 50)
 OR ART_GP_TAG.mandant_id <> 1 AND ART_GP_TAG.vz_dispo_artikelstatus_id <> 50;