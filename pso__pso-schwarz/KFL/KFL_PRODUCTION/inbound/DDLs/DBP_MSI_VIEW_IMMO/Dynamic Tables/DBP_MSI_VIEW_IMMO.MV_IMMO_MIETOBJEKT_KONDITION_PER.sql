CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_IMMO_MIETOBJEKT_KONDITION_PER(
	MANDANT_ID,
	MO_INTRENO,
	WRG_ID,
	MIETE_PER_ANNO
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
   v1.mandant_id, v1.mo_intreno, v1.wrg_id, CASE WHEN (v1.wrg_id='EUR' AND v1.mandant_id NOT IN (1,5)) THEN (v1.zwischensumme) * v1.umrechnungskurs  ELSE v1.zwischensumme END AS miete_per_anno
   FROM  (
   SELECT
   a.mandant_id, a.mo_intreno, CASE WHEN (a.wrg_id='EUR' AND a.mandant_id NOT IN (1,5)) THEN v8.wrg_id ELSE a.wrg_id END AS wrg_id, SUM(a.miete_per_anno) AS zwischensumme, v8.umrechnungskurs AS umrechnungskurs

   FROM dbp_view.v_immo_mietobjekt_kondition_per AS a
   LEFT JOIN dbp_msi_view_immo.mv_mandant_wrg_kurs_zu_hilf AS v8
   ON v8.wrg_typ_id=0 
   AND v8.mandant_id=a.mandant_id

   WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
   AND konditionsart_id IN ('3000','6100','8000','8003','8200','8210','8220','8230')
   GROUP BY 1,2,3,5
   ) v1;