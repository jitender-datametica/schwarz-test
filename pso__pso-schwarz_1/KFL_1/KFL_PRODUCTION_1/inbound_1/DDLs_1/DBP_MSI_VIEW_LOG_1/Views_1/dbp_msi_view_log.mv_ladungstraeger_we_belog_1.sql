create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_LOG.MV_LADUNGSTRAEGER_WE_BELOG_1(
	MANDANT_ID,
	TRANSPORTATION_UNIT_ID,
	KJ_TRANSPORTATION_UNIT,
	EXT_BELEG_IDS,
	LIEF_BELEG_ID,
	LIEFERUNG_HAS_SELBSTABHOL_FG,
	BEST_BELEG_IDS,
	TU_HAS_SELBSTABHOL_FG
) as



WITH ekpo_1 AS
(SELECT 
  tu_c.mandant_id
 ,tu_c.beleg_id AS lief_beleg_id
 ,tu_c.transportation_unit_id
 ,tu_c.kj_transportation_unit
 ,ekpo.best_beleg_id
 ,ekes.ext_beleg_id
 ,MAX(ekpo.selbstabhol_fg) max_selbstabhol_fg
 
 FROM dbp_view.v_besch_best_det_1 ekpo_1 
 
 JOIN dbp_view.v_besch_bestaetigung_1 ekes
 ON ekes.mandant_id=ekpo.mandant_id
 AND ekes.best_beleg_id=ekpo.best_beleg_id
 AND ekes.best_beleg_pos_id=ekpo.best_beleg_pos_id
 
 JOIN dbp_view.v_transportation_unit_carrier_log_1 tu_c
 ON tu_c.mandant_id=ekpo.mandant_id
 AND tu_c.beleg_id=ekes.lief_beleg_id    
 AND tu_c.kj_transportation_unit BETWEEN YEAR(CURRENT_DATE)-2 AND YEAR(CURRENT_DATE)

 GROUP BY  
  tu_c.mandant_id
 ,tu_c.beleg_id
 ,tu_c.transportation_unit_id,tu_c.kj_transportation_unit
 ,ekpo.best_beleg_id, ekes.ext_beleg_id)
 
SELECT 
 ekpo.mandant_id 
,ekpo.transportation_unit_id
,ekpo.kj_transportation_unit

,ekpo.ext_beleg_id
,ekpo.lief_beleg_id
,ekpo.max_selbstabhol_fg AS lieferung_has_selbstabhol_fg
,LISTAGG(ekpo.best_beleg_id, ',') WITHIN GROUP(ORDER BY ekpo.mandant_id , ekpo.transportation_unit_id) AS best_beleg_ids
,MAX(tu_sak.tu_has_selbstabhol_fg) AS tu_has_selbstabhol_fg
 FROM ekpo_1

JOIN (
  SELECT mandant_id
  ,transportation_unit_id, kj_transportation_unit
  ,MAX(max_selbstabhol_fg) AS tu_has_selbstabhol_fg FROM ekpo_1 GROUP BY 1,2,3) tu_sak
   ON ekpo.mandant_id = tu_sak.mandant_id
   AND  ekpo.transportation_unit_id = tu_sak.transportation_unit_id
   AND  ekpo.kj_transportation_unit = tu_sak.kj_transportation_unit



GROUP BY 
  ekpo.mandant_id
 ,ekpo.transportation_unit_id
 ,ekpo.kj_transportation_unit
 ,ekpo.ext_beleg_id
 ,ekpo.lief_beleg_id
 ,ekpo.max_selbstabhol_fg

 ORDER BY
  ekpo.mandant_id
 ,ekpo.transportation_unit_id
 ,ekpo.kj_transportation_unit
 ,ekpo.ext_beleg_id
 ,ekpo.lief_beleg_id
 ,ekpo.max_selbstabhol_fg
 ;
