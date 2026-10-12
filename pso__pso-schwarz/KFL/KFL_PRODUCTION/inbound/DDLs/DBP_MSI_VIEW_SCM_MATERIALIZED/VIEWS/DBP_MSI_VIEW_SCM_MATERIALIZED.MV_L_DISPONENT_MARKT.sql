create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_L_DISPONENT_MARKT(
	MANDANT_ID,
	DISPONENT_ID,
	DISPONENT_NAME
) as
   SELECT
   v00.mandant_id, v00.disponent_id, v00.disponent_name
   FROM
   (
   SELECT
   v01.mandant_id, v01.disponent_id, v01.disponent_name, 1 AS prio
   FROM dbp_view.v_disponent_wup_zu v01
   WHERE
   v01.nb_id=0
       AND (v01.mandant_id, v01.wup_id) IN
   (SELECT mandant_id, wup_id FROM dbp_view.v_wup WHERE nb_id=0 AND fipo_pruef_objekt_id > 0 AND vw_id > 0)
   UNION ALL
   SELECT DISTINCT 
   v02.mandant_id, '-1' AS disponent_id, CAST('nicht gepflegt / not maintained' AS VARCHAR(35) ) AS disponent_name, 2 AS prio
   FROM dbp_view.v_mandant v02
   ) v00
   QUALIFY ROW_NUMBER() OVER (PARTITION BY mandant_id, disponent_id ORDER BY PRIO) = 1;