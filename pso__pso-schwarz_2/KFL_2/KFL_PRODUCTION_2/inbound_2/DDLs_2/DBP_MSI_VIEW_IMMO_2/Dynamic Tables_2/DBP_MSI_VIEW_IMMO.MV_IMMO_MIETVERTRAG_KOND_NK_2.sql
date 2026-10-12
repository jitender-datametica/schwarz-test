CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETVERTRAG_KOND_NK_2(
	MANDANT_ID,
	MV_INTRENO,
	MO_INTRENO,
	WRG_ID,
	WRG_HILF,
	WRG_TYP_ID,
	DAT_MO_GUELTIG_VON,
	DAT_MO_GUELTIG_BIS,
	MIETE_PER_ANNO,
	MIETE_PER_ANNO_FUTURE
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   

   SELECT DISTINCT
   a.mANDant_id, a.mv_intreno, a.mo_intreno, v3.wrg_id, a.wrg_id AS wrg_hilf, v3.wrg_typ_id, v4.dat_mo_gueltig_von 
   , v4.dat_mo_gueltig_bis, CASE WHEN a.wrg_id='EUR' AND a.mANDant_id NOT IN (1,5) THEN
   COALESCE(SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" >=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs) ELSE NULL END),
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs)  ELSE 0 END))
   ELSE COALESCE(SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" >=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE NULL END),
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE 0 END)) END AS miete_per_anno, CASE WHEN a.wrg_id='EUR' AND a.mANDant_id NOT IN (1,5) THEN
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs) ELSE 0 END)
   ELSE SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE 0 END)  END AS miete_per_anno_future

   FROM dbp_view.v_immo_mietvertrag_kondition_per_2 a
   JOIN dbp_msi_view_immo.mv_mANDant_wrg_kurs_zu_hilf_2 AS v3
   ON a.mANDant_id=v3.mANDant_id
   JOIN dbp_msi_view_immo.mv_mietobjekt_2 AS v4
   ON a.mo_intreno=v4.mo_intreno AND a.mANDant_id=v4.mANDant_id
   LEFT JOIN dbp_msi_view_immo.mv_mANDant_wrg_kurs_zu_hilf_2 AS v8
   ON v8.wrg_typ_id=0 AND v8.mANDant_id=a.mANDant_id
   LEFT JOIN dbp_msi_view_immo.mv_mo_status_historie_2 AS v5
   ON a.mANDant_id=v5.mANDant_id AND a.mv_intreno=v5.mv_intreno AND a.mo_intreno=v5.mo_intreno
   WHERE CURRENT_DATE <= a.dat_bis
   AND konditionsart_id IN (3500, 3530, 3540, 3510, 3790, 3520, 3550, 3800, 3810, 3820, 3830, 3840, 3850, 3860, 3870)
   AND v3.wrg_typ_id=1
   AND v5.mo_status_id NOT IN (0,6)
  GROUP BY 1,2,3,4,5,6,7,8

  UNION ALL

  SELECT DISTINCT
  a.mANDant_id, a.mv_intreno, a.mo_intreno, v3.wrg_id, a.wrg_id AS wrg_hilf, v3.wrg_typ_id, v4.dat_mo_gueltig_von, v4.dat_mo_gueltig_bis, CASE WHEN a.wrg_id='EUR' AND a.mANDant_id NOT IN (1,5) THEN
   COALESCE(SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" >=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs) ELSE NULL END),
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs)  ELSE 0 END))
   ELSE COALESCE(SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" >=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE NULL END),
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE 0 END)) END AS miete_per_anno, CASE WHEN a.wrg_id='EUR' AND a.mANDant_id NOT IN (1,5) THEN
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs) ELSE 0 END)
   ELSE SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE 0 END)  END AS miete_per_anno_future
   FROM dbp_view.v_immo_mietvertrag_kondition_per_2 a
   JOIN dbp_msi_view_immo.mv_mANDant_wrg_kurs_zu_hilf_2 AS v3
   ON a.mANDant_id=v3.mANDant_id
   JOIN dbp_msi_view_immo.mv_mietobjekt_2 AS v4
   ON a.mo_intreno=v4.mo_intreno AND a.mANDant_id=v4.mANDant_id
   LEFT JOIN dbp_msi_view_immo.mv_mANDant_wrg_kurs_zu_hilf_2 AS v8
   ON v8.wrg_typ_id=1 AND v8.mANDant_id=a.mANDant_id
   LEFT JOIN dbp_msi_view_immo.mv_mo_status_historie_2 AS v5
   ON a.mANDant_id=v5.mANDant_id AND a.mv_intreno=v5.mv_intreno AND a.mo_intreno=v5.mo_intreno
   WHERE "CURRENT_DATE" <= a.dat_bis
   AND konditionsart_id IN (3500, 3530, 3540, 3510, 3790, 3520, 3550, 3800, 3810, 3820, 3830, 3840, 3850, 3860, 3870)
   AND v3.wrg_typ_id=0
   AND v5.mo_status_id NOT IN (0,6)
  GROUP BY 1,2,3,4,5,6,7,8

  UNION ALL

  

  SELECT DISTINCT
  a.mANDant_id, v5.mv_intreno, a.mo_intreno, v3.wrg_id, a.wrg_id AS wrg_hilf, v3.wrg_typ_id, v4.dat_mo_gueltig_von, v4.dat_mo_gueltig_bis, CASE WHEN a.wrg_id='EUR' AND a.mANDant_id NOT IN (1,5) THEN
   COALESCE(SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" >=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs) ELSE NULL END),
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs)  ELSE 0 END))
   ELSE COALESCE(SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" >=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE NULL END),
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE 0 END)) END AS miete_per_anno, CASE WHEN a.wrg_id='EUR' AND a.mANDant_id NOT IN (1,5) THEN
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs) ELSE 0 END)
   ELSE SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE 0 END)  END AS miete_per_anno_future
   FROM dbp_view.v_immo_mietobjekt_kondition_per_2 a
   JOIN dbp_msi_view_immo.mv_mietobjekt_2 AS v4
   ON a.mo_intreno=v4.mo_intreno AND a.mANDant_id=v4.mANDant_id
   JOIN dbp_msi_view_immo.mv_mANDant_wrg_kurs_zu_hilf_2 AS v3
   ON a.mANDant_id=v3.mANDant_id
   LEFT JOIN dbp_msi_view_immo.mv_mANDant_wrg_kurs_zu_hilf_2 AS v8
   ON v8.wrg_typ_id=1 AND v8.mANDant_id=a.mANDant_id
   LEFT JOIN dbp_msi_view_immo.mv_mo_status_historie_2 AS v5
   ON a.mANDant_id=v5.mANDant_id AND a.mo_intreno=v5.mo_intreno
   WHERE "CURRENT_DATE" <= a.dat_bis
   AND konditionsart_id IN (3500, 3530, 3540, 3510, 3790, 3520, 3550, 3800, 3810, 3820, 3830, 3840, 3850, 3860, 3870)
   AND v3.wrg_typ_id=0
   AND v5.mo_status_id IN (0,6)
  GROUP BY 1,2,3,4,5,6,7,8

  UNION ALL

  SELECT DISTINCT
  a.mANDant_id, v5.mv_intreno, a.mo_intreno, v3.wrg_id, a.wrg_id AS wrg_hilf, v3.wrg_typ_id, v4.dat_mo_gueltig_von, v4.dat_mo_gueltig_bis, CASE WHEN a.wrg_id='EUR' AND a.mANDant_id NOT IN (1,5) THEN
   COALESCE(SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" >=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs) ELSE NULL END),
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs)  ELSE 0 END))
   ELSE COALESCE(SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" >=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE NULL END),
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE 0 END)) END AS miete_per_anno, CASE WHEN a.wrg_id='EUR' AND a.mANDant_id NOT IN (1,5) THEN
   SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN a.miete_per_anno*(v8.umrechnungskurs) ELSE 0 END)
   ELSE SUM(CASE WHEN "CURRENT_DATE" <=a.dat_bis AND "CURRENT_DATE" <=a.dat_von THEN TRUNC( a.miete_per_anno/v3.umrechnungskurs) ELSE 0 END) END AS miete_per_anno_future
   FROM dbp_view.v_immo_mietobjekt_kondition_per_2 a
   JOIN dbp_msi_view_immo.mv_mietobjekt_2 AS v4
   ON a.mo_intreno=v4.mo_intreno AND a.mANDant_id=v4.mANDant_id
   JOIN dbp_msi_view_immo.mv_mANDant_wrg_kurs_zu_hilf_2 AS v3
   ON a.mANDant_id=v3.mANDant_id
   LEFT JOIN dbp_msi_view_immo.mv_mANDant_wrg_kurs_zu_hilf_2 AS v8
   ON v8.wrg_typ_id=0 AND v8.mANDant_id=a.mANDant_id
   LEFT JOIN dbp_msi_view_immo.mv_mo_status_historie_2 AS v5
   ON a.mANDant_id=v5.mANDant_id AND a.mo_intreno=v5.mo_intreno
   WHERE "CURRENT_DATE" <= a.dat_bis
   AND konditionsart_id IN (3500, 3530, 3540, 3510, 3790, 3520, 3550, 3800, 3810, 3820, 3830, 3840, 3850, 3860, 3870)
   AND v3.wrg_typ_id=1
   AND v5.mo_status_id IN (0,6)
  GROUP BY 1,2,3,4,5,6,7,8;