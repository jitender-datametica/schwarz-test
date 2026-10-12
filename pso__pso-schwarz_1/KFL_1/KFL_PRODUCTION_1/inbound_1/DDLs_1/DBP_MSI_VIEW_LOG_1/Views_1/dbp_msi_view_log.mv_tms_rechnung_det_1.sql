create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_TMS_RECHNUNG_DET_1(
	MANDANT_ID,
	SYSTEM_ID,
	TMS_TOUR_ID,
	TMS_TOUR_BEZ,
	TRANSPORTATION_UNIT_ID,
	KJ_TRANSPORTATION_UNIT,
	TRANSPORTATION_UNIT_ID_EXT,
	DAT_TOUR,
	TMS_KONTO_ID,
	TMS_TOURSTATUS_ID,
	TMS_TOURTYP_ID,
	STARTLAGER_TMS_GP_ID,
	SPEDITION_TMS_GP_ID,
	SPEDITION_TMS_GP_TYP_CD,
	TMS,
	LIEFERKUNDE_TMS_GP_ID,
	LIEFERKUNDE_TMS_GP_TYP_CD,
	TMS_STANDORTTYP_ID,
	ANZ_STELLPLATZ,
	ANZ_STELLPLATZ_GESAMT,
	TMS_TOURART_ID,
	WRG_ID,
	KOSTEN_UPLOAD_FG,
	TOURART_ID,
	ANTEIL_STELLPLATZ,
	BETRAG_FIXKOSTEN,
	BETRAG_NETTO,
	BETRAG_KOSTEN,
	EWM_FG,
	RICHTUNG_ID,
	FRACHTZAHLER_ID
) as
















WITH  m_kostenart AS (
SELECT 'MDIES' AS m_tms_konto_id UNION 
SELECT 'MSTRO' AS m_tms_konto_id UNION
SELECT 'MGAS' AS m_tms_konto_id UNION
SELECT 'MMAUT' AS m_tms_konto_id UNION
SELECT 'MKUEH' AS m_tms_konto_id ),

kosten_all AS (
SELECT 
 tms_rech_d.mandant_id
,tms_rech_d.SYSTEM_ID
,TRY_CAST(tms_rech_d.tms_tour_id AS NUMBER(38)) AS tms_tour_id
,tms_rech_d.dat_tour
,TO_CHAR(tms_rech_d.tms_konto_id) AS tms_konto_id
,wrg_id
,tms_rech.ersteller_tms_gp_id AS frachtzahler_tms_gp_id
,SUM(tms_rech_d.betrag_netto) AS betrag_netto_
,0 AS betrag_fixkosten_
,0 AS betrag_kosten_
FROM dbp_view.v_tms_rechnung_det_1  tms_rech_d 
  
JOIN dbp_view.v_tms_rechnung_1 tms_rech
ON tms_rech_d.tms_rech_beleg_id = tms_rech.tms_rech_beleg_id
AND tms_rech_d.mandant_id = tms_rech.mandant_id
AND tms_rech_d.SYSTEM_ID = tms_rech.SYSTEM_ID


WHERE tms_rech.storno_fg = 0 AND betrag_netto <> 0
GROUP BY 1,2,3,4,5,6,7

UNION

SELECT
 tms_tour.mandant_id
,tms_tour.SYSTEM_ID
,tms_tour.tms_tour_id
,tms_tour.dat_tour
,'MFIX' AS tms_konto_id
,wrg_id
,b_netto.ersteller_tms_gp_id AS frachtzahler_tms_gp_id
,0 AS betrag_netto_
,SUM(CASE WHEN b_netto.betrag_netto_ >0 THEN 0 ELSE tms_tour.betrag_fixkosten END) AS betrag_fixkosten_
,0 AS betrag_kosten_
FROM dbp_view.v_tms_tour_1 tms_tour_1
 LEFT JOIN(SELECT 
 tms_rech_d.mandant_id
,TRY_CAST(tms_rech_d.tms_tour_id AS NUMBER(38)) AS tms_tour_id
,tms_rech_d.dat_tour
,tms_rech.ersteller_tms_gp_id
,SUM(tms_rech_d.betrag_netto) AS betrag_netto_
FROM dbp_view.v_tms_rechnung_det_1 tms_rech_d 
  
JOIN dbp_view.v_tms_rechnung_1 tms_rech
ON tms_rech_d.tms_rech_beleg_id = tms_rech.tms_rech_beleg_id
AND tms_rech_d.mandant_id = tms_rech.mandant_id
AND tms_rech_d.SYSTEM_ID = tms_rech.SYSTEM_ID

WHERE tms_rech.storno_fg = 0 AND betrag_netto <> 0 AND tms_konto_id=700
           GROUP BY 1,2,3,4) b_netto
  ON tms_tour.mandant_id = b_netto.mandant_id
  AND tms_tour.tms_tour_id = b_netto.tms_tour_id
  AND tms_tour.dat_tour = b_netto.dat_tour
  
LEFT JOIN dbp_view.v_transportation_unit_1 tu
ON tms_tour.mandant_id = tu.mandant_id
AND tms_tour.transportation_unit_id_ext = tu.transportation_unit_id_ext

LEFT JOIN dbp_view.v_transportation_unit_kosten_1 tu_k
ON  tu.mandant_id = tu_k.mandant_id
AND tu.transportation_unit_id = tu_k.transportation_unit_id
              
GROUP BY 1,2,3,4,5,6,7

UNION

SELECT
 tms_tour.mandant_id
,tms_tour.system_id
,tms_tour.tms_tour_id
,tms_tour.dat_tour
,m_tms_konto_id
 ,tu_k.wrg_id
 ,tms_dispo.BESTAND_TMS_GP_ID AS frachtzahler_tms_gp_id
,SUM(CASE WHEN m_tms_konto_id = 'MDIES' THEN betrag_diesel   
WHEN m_tms_konto_id = 'MSTRO' THEN betrag_strom  
WHEN m_tms_konto_id = 'MGAS' THEN betrag_gas 
WHEN m_tms_konto_id = 'MMAUT' THEN betrag_maut 
WHEN m_tms_konto_id = 'MKUEH' THEN betrag_kuehlung  
ELSE 0 END) AS betrag_netto_
,0 AS betrag_fixkosten_






  ,0 AS betrag_kosten_
FROM dbp_view.v_tms_tour_1 tms_tour_1
    
INNER JOIN dbp_view.v_tms_dispostelle_1 tms_dispo
	ON tms_dispo.mandant_id = tms_tour.mandant_id
	AND tms_dispo.TMS_DISPOSTELLE_ID = tms_tour.TMS_TOUR_DISPOSTELLE_ID
    AND tms_dispo.SYSTEM_ID = tms_tour.SYSTEM_ID
    

CROSS JOIN m_kostenart
  
LEFT JOIN dbp_view.v_transportation_unit_1 tu
ON tms_tour.mandant_id = tu.mandant_id
AND tms_tour.transportation_unit_id_ext = tu.transportation_unit_id_ext
  
LEFT JOIN dbp_view.v_transportation_unit_kosten_1 tu_k
ON  tms_tour.mandant_id = tu_k.mandant_id
AND COALESCE(tu.transportation_unit_id,TRY_CAST( RIGHT(tms_tour.transportation_unit_id_ext, LENGTH(TRIM(tms_tour.transportation_unit_id_ext) ) -6 ) AS NUMBER)) = tu_k.transportation_unit_id
AND CASE WHEN tu.KJ_TRANSPORTATION_UNIT IS NOT NULL THEN tu.KJ_TRANSPORTATION_UNIT ELSE 1 END = CASE WHEN tu.KJ_TRANSPORTATION_UNIT IS NOT NULL THEN tu_k.KJ_TRANSPORTATION_UNIT ELSE 1 END


WHERE (COALESCE(tu_k.betrag_diesel,0) + COALESCE(tu_k.betrag_strom,0) + COALESCE(tu_k.betrag_gas,0) + COALESCE(tu_k.betrag_maut,0) + COALESCE(tu_k.betrag_kuehlung,0))>0

GROUP BY 1,2,3,4,5,6,7
)

SELECT 
 kost.mandant_id
 ,tms_tour.SYSTEM_ID
,kost.tms_tour_id
,tms_tour.TMS_TOUR_BEZ
,COALESCE(tu.transportation_unit_id, tu_les.tour_id, TRY_CAST(TO_CHAR(tms_tour.dat_tour, 'YYYYMMDD') || TO_CHAR(tms_tour.tms_tour_id) AS NUMBER(38))) AS transportation_unit_id_
,COALESCE(tu.KJ_TRANSPORTATION_UNIT,YEAR(tu_les.dat_tour),YEAR(tms_tour.dat_tour)) AS KJ_TRANSPORTATION_UNIT
,tms_tour.transportation_unit_id_ext
,kost.dat_tour
,tms_konto_id
,tms_tourstatus_id
,tms_tourtyp_id
,tms_dispo.BESTAND_TMS_GP_ID AS startlager_tms_gp_id

,COALESCE(spedition_tms_gp_id, '-1') AS spedition_tms_gp_id
,spedition_tms_gp_typ_cd
,'WANKO' AS tms
,lieferkunde_tms_gp_id
,lieferkunde_tms_gp_typ_cd
,COALESCE(tms_standorttyp_id,-1) AS tms_standorttyp_id
,CASE WHEN COALESCE(tms_tour_d.anz_stellplatz_,0) = 0 THEN 1 ELSE tms_tour_d.anz_stellplatz_ END
,CASE WHEN COALESCE(tms_tour_d.anz_stellplatz_gesamt,0) = 0 THEN 1 ELSE tms_tour_d.anz_stellplatz_gesamt END
,tms_tourart_id
,CASE WHEN akt_u.wrg_typ_id = 0 THEN 'EUR' ELSE COALESCE(kost.wrg_id, CASE WHEN akt_u.wrg_typ_id = 0 THEN 'EUR' ELSE w_typ.wrg_id END) END AS wrg_id

,COALESCE(ts_wup_k.kosten_upload_fg,-1) AS kosten_upload_fg_
,tms_tourart_detail_id AS tourart_id_ 
,CASE WHEN tms_tour_d.anz_stellplatz_ IS NULL OR COALESCE(anz_stellplatz_gesamt,0)=0 THEN 1 ELSE tms_tour_d.anz_stellplatz_ END / CASE WHEN COALESCE(anz_stellplatz_gesamt,0)=0 THEN anz_kunden_gesamt ELSE anz_stellplatz_gesamt END AS anteil_stellplatz
,CASE WHEN w_typ.wrg_typ_id = 0 THEN betrag_fixkosten_ * k.umrechnungskurs ELSE betrag_fixkosten_ END  AS betrag_fixkosten 
,CASE WHEN w_typ.wrg_typ_id = 0 THEN betrag_netto_ * k.umrechnungskurs ELSE betrag_netto_ END  AS betrag_netto
,CASE WHEN w_typ.wrg_typ_id = 0 THEN betrag_kosten_ * k.umrechnungskurs ELSE betrag_kosten_ END  AS betrag_kosten
, CASE WHEN LEFT(s.KL_SYSTEM_BEZ,3)  = 'FLW' THEN 2
       WHEN tu.transportation_unit_id IS NOT NULL THEN 1 
       WHEN ( tu_les.tour_id IS NOT NULL OR ewm.dat_ewm_von > kost.dat_tour ) THEN 0 
       ELSE 1 END AS EWM_FG 
,tms_tour.TMS_TOUR_RICHTUNGSART_ID AS richtung_id
,frachtzahler_tms_gp_id AS frachtzahler_id

FROM kosten_all kost

INNER JOIN dbp_view.v_tms_tour_1 tms_tour_1
ON kost.mandant_id = tms_tour.mandant_id
AND kost.tms_tour_id = tms_tour.tms_tour_id
AND kost.dat_tour = tms_tour.dat_tour  
AND kost.SYSTEM_ID = tms_tour.SYSTEM_ID

JOIN dbp_view.v_l_system_1 s
ON tms_tour.system_id = s.system_id  

INNER JOIN dbp_view.v_tms_dispostelle_1 tms_dispo
ON tms_dispo.mandant_id = tms_tour.mandant_id
AND tms_dispo.TMS_DISPOSTELLE_ID = tms_tour.TMS_TOUR_DISPOSTELLE_ID
AND tms_dispo.SYSTEM_ID = tms_tour.SYSTEM_ID

INNER JOIN (SELECT mandant_id, wup_id, MIN(COALESCE(dat, DATE'9999-12-31')) AS dat_ewm_von FROM DBP_MSI_data.ts_lagerort_ewm_dat_1 GROUP BY mandant_id, wup_id) ewm
ON tms_dispo.MANDANT_ID = ewm.MANDANT_ID 
AND tms_dispo.BESTAND_TMS_GP_ID = ewm.wup_id

LEFT JOIN dbp_view.v_transportation_unit_1 tu
ON tms_tour.mandant_id = tu.mandant_id
AND tms_tour.transportation_unit_id_ext = tu.transportation_unit_id_ext 


LEFT JOIN dbp_view.v_tour_1 tu_les
ON tms_tour.mandant_id = tu_les.mandant_id
AND TRY_CAST( RIGHT ( tms_tour.transportation_unit_id_ext, LENGTH ( TRIM (tms_tour.transportation_unit_id_ext) ) -6 ) AS NUMBER) = tu_les.tour_id
AND tms_dispo.BESTAND_TMS_GP_ID = tu_les.wup_id

LEFT JOIN dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per_1 ts_wup_k
ON tms_tour.spedition_tms_gp_id = ts_wup_k.tms_gp_id
AND tms_tour.mandant_id = ts_wup_k.mandant_id
AND tms_dispo.BESTAND_TMS_GP_ID = ts_wup_k.wup_id
AND tms_tour.dat_tour BETWEEN ts_wup_k.dat_von AND ts_wup_k.dat_bis


JOIN (
  SELECT tms_tour_det.mandant_id,tms_tour_det.system_id,tms_tour_id, dat_tour, lieferkunde_tms_gp_id, lieferkunde_tms_gp_typ_cd, COALESCE(tms_standorttyp_id,-1) AS tms_standorttyp_id,
         COUNT (DISTINCT lieferkunde_tms_gp_id ) OVER (PARTITION BY tms_tour_det.mandant_id, tms_tour_det.system_id, tms_tour_det.tms_tour_id,tms_tour_det.dat_tour) AS anz_kunden_gesamt,
	     SUM ( CASE WHEN anz_stellplatz = 0 THEN COALESCE(anz_stellplatz_retoure,0) END) AS anz_stellplatz_,
         SUM (anz_stellplatz_) OVER (PARTITION BY tms_tour_det.mandant_id, tms_tour_det.system_id, tms_tour_det.tms_tour_id,tms_tour_det.dat_tour) AS anz_stellplatz_gesamt 
     FROM dbp_view.v_tms_tour_det_1 tms_tour_det_1
    LEFT JOIN dbp_view.v_tms_gp_1 tms_gp_1
ON tms_tour_det.mandant_id = tms_gp.mandant_id 
AND tms_tour_det.lieferkunde_tms_gp_id = tms_gp.tms_gp_id
AND tms_tour_det.lieferkunde_tms_gp_typ_cd = tms_gp.tms_gp_typ_cd 
AND tms_tour_det.system_id = tms_gp.system_id 
GROUP BY tms_tour_det.mandant_id,tms_tour_det.system_id, tms_tour_id, dat_tour , lieferkunde_tms_gp_id,lieferkunde_tms_gp_typ_cd,tms_standorttyp_id) tms_tour_d

ON kost.mandant_id = tms_tour_d.mandant_id
AND kost.tms_tour_id = tms_tour_d.tms_tour_id
AND kost.dat_tour = tms_tour_d.dat_tour
AND kost.system_id = tms_tour_d.system_id 

LEFT JOIN dbp_msi_view_log.mv_kurs_1 k ON COALESCE(kost.wrg_id,'EUR') = k.von_wrg_id

INNER JOIN dbp_view.v_mandant_wrg_typ_zu_1 w_typ ON tms_tour.mandant_id = w_typ.mandant_id 

INNER JOIN dbp_msi_view_log.MV_AKT_MSI_USER_PRJ_WRG_TYP_ZU_1 akt_u 
ON w_typ.wrg_typ_id = akt_u.wrg_typ_id
;
