create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_UEBERNAHMEQUOTE_VZ_1(
	ART_ID,
	VZ_DISPO_ARTIKELSTATUS_ID,
	MENGE_EINH_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	MANDANT_ID,
	GP_TEILSORTIMENT_ID,
	LAGERORT_ID,
	DISPONENT_ID,
	VZ_DISPO_STATUS_ID,
	AUTODISPO_FG,
	DAT_PLAN,
	DAT_BEST,
	DAT_LIEF,
	BEDARF_NETTO,
	BEDARF_NACH_MBM_ART,
	BEDARF_NACH_RUNDUNG,
	BEDARF_NACH_DYN_RUNDUNG,
	BEDARF_NACH_MBM_LIEFERANT,
	BV_QUELLE_ID,
	BV_QUELLE_BEZ,
	MENGE_BEST_GESAMT,
	MENGE_BEST_NORMAL,
	MENGE_BEST_BEVORRATUNG,
	MENGE_BEST_IWT,
	MENGE_BEST_WERBUNG,
	DAT_VERFUEGBARKEIT,
	DAT_BEDARFSPERIODE_ENDE,
	DAT_BESTANDSPERIODE_ENDE,
	MENGE_GESAMT_SPLIT,
	MENGE_IWT_GESAMT_SPLIT,
	MENGE_WERBUNG_GESAMT_SPLIT,
	BESTELLSTATUS_VZ_ID,
	BESTELLSTATUS_VZ_SHORT_DESC,
	BESTELLSTATUS_VZ_DESC
) as
--AP0169994, dknop, initial
--AP0169994, nwag, added discarded OP, uncommented ULI-Handling + other adjustments
--AP0169994, nwag, changed ORDPLAN join to SAP-surrogate keys

SELECT DISTINCT
 art_gp_tag.art_id
,art_gp_tag.vz_dispo_artikelstatus_id
,art_gp_tag.menge_einh_id
,gp_vz_tag.wup_id
,gp_vz_tag.nb_id
,gp_vz_tag.gp_id
,gp_vz_tag.mandant_id
,gp_vz_tag.gp_teilsortiment_id
,gp_vz_tag.lagerort_id
,gp_vz_tag.disponent_id
,gp_vz_tag.vz_dispo_status_id
,gp_vz_tag.autodispo_fg
,art_gp_tag.dat_plan
,v_b_vor.dat_best
,v_b_vor.dat_lief
,v_b_vor.bedarf_netto
,v_b_vor.bedarf_nach_mbm_art
,v_b_vor.bedarf_nach_rundung
,v_b_vor.bedarf_nach_dyn_rundung
,v_b_vor.bedarf_nach_mbm_lieferant
,v_b_vor.bv_quelle_id
,CASE WHEN v_b_vor.bv_quelle_id=1 THEN 'OP-Prepare (Standard)' 
      WHEN v_b_vor.bv_quelle_id=2 THEN 'Promotion Monitoring (Werbung)' ELSE '' END AS bv_quelle_bez
,v_b_vor.menge_best_gesamt
,v_b_vor.menge_best_normal
,v_b_vor.menge_best_bevorratung
,v_b_vor.menge_best_iwt
,v_b_vor.menge_best_werbung
,v_b_vor.dat_verfuegbarkeit
,v_b_vor.dat_besdarfsperiode_ende
,v_b_vor.dat_bestandsperiode_ende
,v_b_split.menge_gesamt AS menge_gesamt_split
,v_b_split.menge_iwt_gesamt AS menge_iwt_gesamt_split
,v_b_split.menge_werbung_gesamt AS menge_werbung_gesamt_split
,CASE WHEN v_b_split.menge_gesamt = v_b_vor.menge_best_gesamt THEN '1'
      WHEN COALESCE(v_b_split.menge_gesamt,0) = 0 THEN '2'
      WHEN v_b_split.menge_gesamt < v_b_vor.menge_best_gesamt THEN '3'
      WHEN v_b_split.menge_gesamt > v_b_vor.menge_best_gesamt THEN '4'
      ELSE '-1' END AS bestellstatus_VZ_id
,CASE WHEN v_b_split.menge_gesamt = v_b_vor.menge_best_gesamt THEN 'VB'
      WHEN COALESCE(v_b_split.menge_gesamt,0) = 0 THEN 'V0'
      WHEN v_b_split.menge_gesamt < v_b_vor.menge_best_gesamt THEN 'V-'
      WHEN v_b_split.menge_gesamt > v_b_vor.menge_best_gesamt THEN 'V+'
      ELSE 'n/a' END AS bestellstatus_VZ_short_desc
      ,CASE WHEN v_b_split.menge_gesamt = v_b_vor.menge_best_gesamt THEN 'Übernommen'
      WHEN COALESCE(v_b_split.menge_gesamt,0) = 0 THEN 'Verworfen'
      WHEN v_b_split.menge_gesamt < v_b_vor.menge_best_gesamt THEN 'Reduziert'
      WHEN v_b_split.menge_gesamt > v_b_vor.menge_best_gesamt THEN 'Erhöht'
      ELSE 'n/a' END AS bestellstatus_VZ_desc

FROM dbp_view.v_art_gp_dispo_tag_1 art_gp_tag

JOIN dbp_view.v_gp_dispo_vz_tag_1 gp_vz_tag
ON  art_gp_tag.mandant_id = gp_vz_tag.mandant_id
AND art_gp_tag.gp_dispo_id = gp_vz_tag.gp_dispo_id
AND art_gp_tag.dat_plan = gp_vz_tag.dat_plan

JOIN dbp_view.v_vz_best_vor_1 v_b_vor
ON art_gp_tag.mandant_id=v_b_vor.mandant_id
AND art_gp_tag.dat_plan=v_b_vor.dat_plan
AND art_gp_tag.dat_plan=v_b_vor.dat_best --entspr. status_1 quo!
AND art_gp_tag.gp_dispo_id=v_b_vor.gp_dispo_id
AND gp_vz_tag.wup_id=v_b_vor.wup_id
AND art_gp_tag.art_dispo_id=v_b_vor.art_dispo_id

LEFT JOIN dbp_view.v_vz_best_split_1 v_b_split
ON art_gp_tag.mandant_id = v_b_split.mandant_id
AND art_gp_tag.art_dispo_id = v_b_split.art_dispo_id
AND art_gp_tag.gp_dispo_id = v_b_split.gp_dispo_id
AND v_b_vor.dat_verfuegbarkeit = v_b_split.dat_verfuegbarkeit

WHERE ( art_gp_tag.mandant_id = 1 AND VZ_DISPO_ARTIKELSTATUS_ID NOT IN (0, 50) )
OR  ( art_gp_tag.mandant_id <> 1 AND VZ_DISPO_ARTIKELSTATUS_ID <> 50 );