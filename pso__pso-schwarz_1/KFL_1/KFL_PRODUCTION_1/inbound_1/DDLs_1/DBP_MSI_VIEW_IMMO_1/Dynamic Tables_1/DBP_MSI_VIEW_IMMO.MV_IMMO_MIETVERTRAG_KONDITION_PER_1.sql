CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETVERTRAG_KONDITION_PER_1(
	MANDANT_ID,
	MV_INTRENO,
	MO_INTRENO,
	WRG_ID,
	WRG_HILF,
	MIETE_PER_ANNO_FUTURE,
	MIETE_PER_ANNO_CURRENT,
	MIETE_PER_ANNO_CURRENT1,
	MIETE_PER_ANNO_FUTURE1,
	MIETE_PER_ANNO
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS


   SELECT
   a.mandant_id,
   a.mv_intreno,
   a.mo_intreno,
   CASE WHEN (a.wrg_id='EUR' AND a.mandant_id NOT IN (1,5))
    THEN (v8.wrg_id)
    ELSE a.wrg_id
   END AS wrg_id,
   a.wrg_id AS wrg_hilf,
   SUM( CASE WHEN CURRENT_DATE() <dat_von THEN a.miete_per_anno ELSE NULL END) AS miete_per_anno_future,
   SUM( CASE WHEN CURRENT_DATE() >=dat_von THEN a.miete_per_anno ELSE NULL END) AS miete_per_anno_current,
   CASE WHEN (a.wrg_id='EUR' AND a.mandant_id NOT IN (1,5)) THEN (miete_per_anno_current)*(v9.umrechnungskurs) ELSE miete_per_anno_current END AS miete_per_anno_current1,
   CASE WHEN (a.wrg_id='EUR' AND a.mandant_id NOT IN (1,5)) THEN (miete_per_anno_future)*(v9.umrechnungskurs) ELSE miete_per_anno_future END AS miete_per_anno_future1,
   COALESCE(miete_per_anno_current1, miete_per_anno_future1) AS miete_per_anno
 
   FROM dbp_view.v_immo_mietvertrag_kondition_per_1 AS a
   
   LEFT JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v8
   ON v8.wrg_typ_id=1 
   AND v8.mandant_id=a.mandant_id
   
   LEFT JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf_1 AS v9
   ON v9.wrg_typ_id=0 
   AND
   v9.mandant_id=a.mandant_id
   WHERE CURRENT_DATE() <= dat_bis
   AND konditionsart_id IN ('3000','6100','8000','8003','8200','8210','8220','8230')
   GROUP BY 1,2,3,4,5
    ,v9.umrechnungskurs
   ;