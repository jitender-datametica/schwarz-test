CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_SCM.MV_DT_UEBERNAHMEQUOTE_VZ2
(
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
	BEST_VOR_DISPO_ID,
	BEDARF_NETTO,
	BEDARF_NACH_MBM_ART,
	BEDARF_NACH_RUNDUNG,
	BEDARF_NACH_DYN_RUNDUNG,
	BEDARF_NACH_MBM_LIEFERANT,
	BV_QUELLE_ID,
	BV_QUELLE_BEZ,
	BEST_BELEG_ID,
	BEST_BELEG_POS_ID,
	BESTELLART_ID,
	BESTELLSTATUS_TYP_ID,
	MENGE_BV_GESAMT,
	MENGE_BV_STANDARD,
	MENGE_BV_BEVORRATUNG,
	MENGE_BV_IWT,
	MENGE_BV_WERBUNG,
	DAT_VERFUEGBARKEIT,
	DAT_BEDARFSPERIODE_ENDE,
	DAT_BESTANDSPERIODE_ENDE,
	MENGE_BEST_GESAMT,
	MENGE_BEST_WERBUNG,
	MENGE_BEST_IWT,
	MENGE_SPLIT_GESAMT,
	MENGE_SPLIT_IWT,
	MENGE_SPLIT_WERBUNG,
	BESTELLSTATUS_VZ_ID,
	BESTELLSTATUS_VZ_SHORT_DESC,
	BESTELLSTATUS_VZ_DESC,
	FG,
	BEST_VOR_DISPO_1ST_FG
)

TARGET_LAG = '30 minutes' refresh_mode = AUTO initialize = ON_CREATE
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_LOG
--WAREHOUSE = WH_KFL_D_DYNAMIC_TABLE_LOG

 AS
--2025-07-07, AP0244447, SPEC0287477, dknop, initial
--2025-08-01, AP0244447, SPEC0287477, nwag, lieferdatum EKET + manual D2020 orders
--2025-08-04, AP0244447, SPEC0287477, nwag, avoid dups due to > 1 GPID
--2025-10-16, nwag,  add. check for product to show up in D2020 tables on a given order day
--2026-01-14, nwag, prio IWT > Standard
WITH art_gp_tag AS (SELECT  mandant_id, dat_plan, art_id 
                    FROM dbp_view.v_art_gp_dispo_tag a 
                    JOIN dbp_view.v_tag t 
                        ON t.dat=a.dat_plan 
                        AND t.akt_kj BETWEEN -2 AND 0 
                    WHERE dat_plan >= '2025-02-01' GROUP BY 1,2,3)
SELECT DISTINCT
COALESCE(art_gp_tag.art_id,ekpo.art_id) AS ART_ID_
,art_gp_tag1.vz_dispo_artikelstatus_id
--,art_gp_tag1.art_dispo_id
,COALESCE(art_gp_tag1.menge_einh_id, ekpo.best_menge_einh_id)
,COALESCE(gp_vz_tag.wup_id,ekpo.wup_id) AS WUP_ID_
,COALESCE(gp_vz_tag.nb_id,ekpo.nb_id)
,COALESCE(ekpo.gp_id,gp_vz_tag.gp_id)
,COALESCE(art_gp_tag.mandant_id,ekpo.mandant_id) AS MANDANT_ID_
,COALESCE(ekpo.gp_teilsortiment_id,gp_vz_tag.gp_teilsortiment_id)
,COALESCE(gp_vz_tag.lagerort_id,ekpo.lagerort_id) AS lagerort_id
,COALESCE(ekpo.disponent_id, gp_vz_tag.disponent_id) AS disponent_id
,gp_vz_tag.vz_dispo_status_id
,gp_vz_tag.autodispo_fg
,COALESCE(art_gp_tag.dat_plan,ekpo.dat_best_beleg) AS DAT_PLAN_
,COALESCE(v_b_vor.dat_best,ekpo.dat_best_beleg) 
,COALESCE(eket_ldat.dat_lief_wunsch,v_b_vor.dat_lief,ekpo.dat_lief_wunsch) AS DAT_LIEF_
,CASE WHEN fg_ = 'M' THEN NULL ELSE COALESCE(v_b_split.BEST_VOR_DISPO_ID,v_b_vor.BEST_VOR_DISPO_ID) END AS BEST_VOR_DISPO_ID_
,v_b_vor.bedarf_netto
,v_b_vor.bedarf_nach_mbm_art
,v_b_vor.bedarf_nach_rundung
,v_b_vor.bedarf_nach_dyn_rundung
,v_b_vor.bedarf_nach_mbm_lieferant
,CASE WHEN fg_ = 'M' THEN 0 ELSE COALESCE(v_b_vor.bv_quelle_id,0) END AS bv_quelle_id_
,CASE WHEN bv_quelle_id_=1 THEN 'OP-Prepare (Standard)' 
      WHEN bv_quelle_id_=2 THEN 'Promotion Monitoring (Werbung)' ELSE 'Kein BV' END AS bv_quelle_bez
,CASE WHEN fg_ = 'M' THEN ekpo.BEST_BELEG_ID WHEN v_b_split.menge_gesamt IS NOT NULL THEN v_b_split.BEST_BELEG_ID ELSE COALESCE(ekpo.BEST_BELEG_ID,-1) END BEST_BELEG_ID_
,CASE WHEN fg_ = 'M' THEN ekpo.BEST_BELEG_pos_ID WHEN v_b_split.menge_gesamt IS NOT NULL THEN v_b_split.BEST_BELEG_POS_ID  ELSE COALESCE(ekpo.BEST_BELEG_pos_ID,-1) END BEST_BELEG_POS_ID_
,CASE WHEN fg_ = 'M' THEN COALESCE(ekpo.BESTELLART_ID,'-1') WHEN BEST_BELEG_ID_ = '-1' THEN '-1' ELSE COALESCE(ekpo.BESTELLART_ID,'-1') END

,CASE WHEN COALESCE(ekpo.menge_block_werbung,0) > 0 AND COALESCE(fg_,'M') = 'M' OR COALESCE(v_b_vor.menge_best_werbung,0) > 0 THEN 'W'
      WHEN COALESCE(v_b_vor.menge_best_bevorratung,0) > 0 THEN 'B'
      WHEN COALESCE(ekpo.menge_block_iwt,0) > 0  AND COALESCE(fg_,'M') = 'M' OR COALESCE(v_b_vor.menge_best_iwt,0) > 0 THEN 'I' 
	  --WHEN COALESCE(v_b_vor.menge_best_normal,0) > 0 THEN 'S'
      ELSE 'S'
      END AS BESTELLSTATUS_TYP_ID
,CASE WHEN fg_ = 'M' THEN NULL ELSE v_b_vor.menge_best_gesamt END AS menge_bv_gesamt
,CASE WHEN fg_ = 'M' THEN NULL ELSE v_b_vor.menge_best_normal END AS menge_bv_standard
,CASE WHEN fg_ = 'M' THEN NULL ELSE v_b_vor.menge_best_bevorratung END AS menge_bv_bevorratung
,CASE WHEN fg_ = 'M' THEN NULL ELSE v_b_vor.menge_best_iwt END AS menge_bv_iwt
,CASE WHEN fg_ = 'M' THEN NULL ELSE v_b_vor.menge_best_werbung END AS menge_bv_werbung
,CASE WHEN fg_ = 'M' THEN NULL ELSE v_b_vor.dat_verfuegbarkeit END
,CASE WHEN fg_ = 'M' THEN NULL ELSE v_b_vor.dat_besdarfsperiode_ende END
,CASE WHEN fg_ = 'M' THEN NULL ELSE v_b_vor.dat_bestandsperiode_ende END
,CASE WHEN v_b_split.menge_gesamt IS NULL AND fg_ = 'BV' THEN NULL ELSE ekpo.menge_best_kolli END AS menge_best_gesamt
,CASE WHEN v_b_split.menge_gesamt IS NULL AND fg_ = 'BV' THEN NULL ELSE ekpo.MENGE_BLOCK_werbung END AS menge_best_werbung
,CASE WHEN v_b_split.menge_gesamt IS NULL AND fg_ = 'BV' THEN NULL ELSE ekpo.MENGE_BLOCK_iwt END AS menge_best_iwt
,v_b_split.menge_gesamt AS menge_split_gesamt
,v_b_split.menge_iwt_gesamt AS menge_split_iwt
,v_b_split.menge_werbung_gesamt AS menge_split_werbung
,CASE WHEN fg_ = 'M' AND ekpo.menge_best_kolli IS NOT NULL AND (v_b_split.menge_gesamt IS NULL OR v_b_split.best_vor_dispo_id = 0)  THEN 5
      WHEN v_b_split.menge_gesamt = v_b_vor.menge_best_gesamt AND v_b_split.best_vor_dispo_id <> 0 THEN 1
      WHEN COALESCE(v_b_split.menge_gesamt,0) = 0 AND v_b_vor.menge_best_gesamt > 0 AND v_b_vor.best_vor_dispo_id <> 0 THEN 2
      WHEN v_b_split.menge_gesamt < v_b_vor.menge_best_gesamt AND v_b_split.best_vor_dispo_id <> 0 THEN 3
      WHEN v_b_split.menge_gesamt > v_b_vor.menge_best_gesamt AND v_b_split.best_vor_dispo_id <> 0 THEN 4
      ELSE 5 END AS bestellstatus_VZ_id
,CASE WHEN bestellstatus_VZ_id = 5 THEN '0M'
      WHEN bestellstatus_VZ_id = 1 THEN 'VB'
      WHEN bestellstatus_VZ_id = 2 THEN 'V0'
      WHEN bestellstatus_VZ_id = 3 THEN 'V-'
      WHEN bestellstatus_VZ_id = 4 THEN 'V+'
      ELSE 'n/a' END AS bestellstatus_VZ_short_desc
,CASE WHEN bestellstatus_VZ_id = 5 THEN 'Manuell'
      WHEN bestellstatus_VZ_id = 1 THEN 'Übernommen'
      WHEN bestellstatus_VZ_id = 2 THEN 'Verworfen'
      WHEN bestellstatus_VZ_id = 3 THEN 'Reduziert'
      WHEN bestellstatus_VZ_id = 4 THEN 'Erhöht'
      ELSE 'n/a' END AS bestellstatus_VZ_desc,
      FG_,
CASE WHEN BEST_VOR_DISPO_ID_ IS NULL THEN 1
     WHEN ROW_NUMBER() OVER (PARTITION BY MANDANT_ID_, ART_ID_, WUP_ID_, DAT_PLAN_, BEST_VOR_DISPO_ID_ ORDER BY BEST_BELEG_ID_ DESC) = 1 THEN 1 ELSE 0 END AS best_vor_dispo_1st_fg
FROM  
--allen möglichen VZ/Artikel/Tag kombinationen:
art_gp_tag
--zu diesen erstmal 2 Datensätze erzeugen -> für EKPO-only oder Dispo2020:
JOIN (SELECT 'M' AS FG_ UNION SELECT 'BV' AS FG_) m_bv_fg ON 1=1

LEFT JOIN dbp_view.v_vz_best_vor v_b_vor
ON art_gp_tag.mandant_id=v_b_vor.mandant_id
AND art_gp_tag.dat_plan=v_b_vor.dat_plan
AND v_b_vor.dat_best = art_gp_tag.dat_plan 
AND v_b_vor.art_id = art_gp_tag.art_id 
AND v_b_vor.best_vor_dispo_id > 0

LEFT JOIN dbp_view.v_art_gp_dispo_tag art_gp_tag1
ON art_gp_tag1.mandant_id=v_b_vor.mandant_id
AND art_gp_tag1.dat_plan=v_b_vor.dat_plan
AND art_gp_tag1.gp_dispo_id=v_b_vor.gp_dispo_id
AND art_gp_tag1.art_dispo_id=v_b_vor.art_dispo_id

LEFT JOIN dbp_view.v_gp_dispo_vz_tag gp_vz_tag
ON  art_gp_tag1.mandant_id = gp_vz_tag.mandant_id
AND art_gp_tag1.gp_dispo_id = gp_vz_tag.gp_dispo_id
AND art_gp_tag1.dat_plan = gp_vz_tag.dat_plan

LEFT JOIN dbp_view.v_vz_best_split v_b_split
ON art_gp_tag1.mandant_id = v_b_split.mandant_id
AND art_gp_tag1.art_dispo_id = v_b_split.art_dispo_id
AND art_gp_tag1.gp_dispo_id = v_b_split.gp_dispo_id
AND v_b_vor.BEST_VOR_DISPO_ID = CASE WHEN v_b_split.BEST_VOR_DISPO_ID > 0 THEN v_b_split.BEST_VOR_DISPO_ID ELSE v_b_vor.BEST_VOR_DISPO_ID END --manuelle D2020 orders

--abweichendes lieferdatum gewinnt ggfs über D2020 lieferdatum
LEFT JOIN dbp_view.v_lief_einteilung eket_ldat
ON eket_ldat.mandant_id = v_b_split.mandant_id
AND eket_ldat.best_beleg_id = v_b_split.best_beleg_id
AND eket_ldat.best_beleg_pos_id = v_b_split.best_beleg_pos_id

FULL OUTER JOIN ( SELECT bb.mandant_id, bb.dat_best_beleg, bbd.best_beleg_id, bbd.best_beleg_pos_id, bbd.wup_id, bbd.nb_id, bbd.art_id, bbd.menge_best_kolli , bb.gp_id, bbd.lagerort_id, bbd.best_menge_einh_id, let.dat_lief_wunsch, bbd.gp_teilsortiment_id, bb.bestellart_id, marc.disponent_id,
CASE WHEN (bbd.menge_best_bme/ CASE WHEN COALESCE(bbd.menge_best_kolli,1) = 0 THEN 1 ELSE bbd.menge_best_kolli END) = 0 THEN 1
     ELSE (bbd.menge_best_bme/ CASE WHEN COALESCE(bbd.menge_best_kolli,1) = 0 THEN 1 ELSE bbd.menge_best_kolli END) END AS kollifaktor,
CASE WHEN bbd.best_menge_einh_id <> 'KG' THEN block.menge_block / NULLIFZERO(kollifaktor) ELSE block.menge_block END AS menge_block_werbung, 
CASE WHEN bbd.best_menge_einh_id <> 'KG' THEN iwt.menge_block / NULLIFZERO(kollifaktor) ELSE iwt.menge_block END AS menge_block_iwt
FROM dbp_view.v_besch_best_det bbd 
JOIN dbp_view.v_art_wup_status_per marc
ON marc.mandant_id = bbd.mandant_id
AND marc.art_id = bbd.art_id
AND marc.wup_id = bbd.wup_id
AND bbd.dat_best_beleg BETWEEN marc.dat_von AND marc.dat_bis
LEFT JOIN dbp_view.v_best_blockbestand block
ON block.mandant_id = bbd.mandant_id
AND block.best_beleg_id = bbd.best_beleg_id
AND block.best_beleg_pos_id = bbd.best_beleg_pos_id
AND block.prozess_id=1
LEFT JOIN dbp_view.v_best_blockbestand iwt
ON iwt.mandant_id = bbd.mandant_id
AND iwt.best_beleg_id = bbd.best_beleg_id
AND iwt.best_beleg_pos_id = bbd.best_beleg_pos_id
AND iwt.prozess_id=2
JOIN dbp_view.v_lief_einteilung let 
ON let.mandant_id = bbd.mandant_id
AND let.best_beleg_id = bbd.best_beleg_id
AND let.best_beleg_pos_id = bbd.best_beleg_pos_id
JOIN dbp_view.v_besch_best bb
ON bb.mandant_id = bbd.mandant_id
AND bb.best_beleg_id = bbd.best_beleg_id
AND ((bb.mandant_id = 1 AND bb.bestellart_id = 'ZLLF' ) OR
     (bb.mandant_id <> 1 AND bb.bestellart_id IN ( 'ZBCZ', 'ZBPL', 'ZBSK','ZBHR','ZBRO', 'ZBBG' ))
     OR bb.bestellart_id IN ('ZNL','ZNLP','ZNLS','ZNLW')
    ) 
AND bb.dat_best_beleg >= '2025-02-01'
AND (bbd.mandant_id, bbd.art_id) NOT IN (SELECT mandant_id, art_id FROM dbp_view.v_art_wg_zu_per WHERE dat_bis = '9999-12-31' AND wg_id BETWEEN 980 AND 989) --pfand, O&G-DE,...
AND (bbd.mandant_id, bbd.art_id, bbd.dat_best_beleg) IN (SELECT mandant_id, art_id, dat_plan FROM art_gp_tag) --nur relev. artikel
) ekpo
ON  art_gp_tag.mandant_id        = ekpo.mandant_id
AND art_gp_tag.art_id = ekpo.art_id
AND art_gp_tag.dat_plan   = ekpo.dat_best_beleg
AND gp_vz_tag.wup_id=ekpo.wup_id
AND ekpo.best_beleg_id = CASE WHEN fg_ ='M' THEN ekpo.best_beleg_id ELSE v_b_split.best_beleg_id END
AND ekpo.best_beleg_pos_id = CASE WHEN fg_ ='M' THEN ekpo.best_beleg_pos_id ELSE v_b_split.best_beleg_pos_id END 
AND ekpo.dat_lief_wunsch = COALESCE(eket_ldat.dat_lief_wunsch,v_b_vor.dat_lief,art_gp_tag1.dat_lief, ekpo.dat_lief_wunsch) 
AND ekpo.gp_id = COALESCE(v_b_split.gp_id,gp_vz_tag.gp_id,ekpo.gp_id)

WHERE    ( art_gp_tag.mandant_id IS NULL OR (
( art_gp_tag.mandant_id = 1 AND VZ_DISPO_ARTIKELSTATUS_ID NOT IN (0, 50) )
OR  ( art_gp_tag.mandant_id <> 1 AND VZ_DISPO_ARTIKELSTATUS_ID <> 50 )
AND art_gp_tag.dat_plan >= '2025-02-01')
AND ( ( fg_ ='M' AND ekpo.menge_best_kolli IS NOT NULL AND COALESCE(v_b_split.best_vor_dispo_id,0) = 0 
AND NOT EXISTS (SELECT 1 FROM dbp_view.v_vz_best_split d2020 WHERE d2020.best_vor_dispo_id > 0 AND d2020.mandant_id = ekpo.mandant_id AND d2020.best_beleg_id = ekpo.best_beleg_id AND d2020.best_beleg_pos_id = ekpo.best_beleg_pos_id)
    ) OR fg_ ='BV'  AND COALESCE(v_b_vor.best_vor_dispo_id,0) > 0 
    AND COALESCE(v_b_split.best_vor_dispo_id,v_b_vor.best_vor_dispo_id) = v_b_vor.best_vor_dispo_id --verworfen oder mit passendem bezug!
    ) 
AND NOT ( ekpo.mandant_id IS NULL AND v_b_vor.mandant_id IS NULL )
)
--avoid duplication due to multiple, non-matching delivery dates within D2020 tables:
QUALIFY ROW_NUMBER() OVER (PARTITION BY MANDANT_ID_, ART_ID_, WUP_ID_, DAT_PLAN_, BEST_VOR_DISPO_ID_ , BEST_BELEG_ID_, BEST_BELEG_POS_ID_ ORDER BY menge_split_gesamt DESC NULLS LAST) = 1
;