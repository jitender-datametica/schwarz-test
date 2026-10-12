CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_F_ANZ_NACHMIETVERTRAEGE_2(
	MANDANT_ID,
	MO_INTRENO,
	MV_INTRENO,
	KONZESSIONAER_ID,
	NACH_MV_INTRENO,
	NACH_MV_MIETVERTRAG_NR,
	NACH_MV_STATUS_ID,
	ANZ_NACH_MV
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO
 AS

   SELECT
    v.mandant_id, v.mo_intreno, v.mv_intreno, v.partner_id AS konzessionaer_id, CASE WHEN v.anz_nach_mv > 1 THEN '' ELSE v.nach_mv_intreno END AS nach_mv_intreno, CASE WHEN v.anz_nach_mv > 1 THEN '' ELSE v.nach_mv_mietvertrag_nr END AS nach_mv_mietvertrag_nr, CASE WHEN v.anz_nach_mv =1 THEN w.mo_status_id ELSE -1 END AS nach_mv_status_id, v.anz_nach_mv

   FROM
   
   (
    SELECT
     a.mandant_id, a.partner_id, b.mo_intreno, a.mv_intreno, COALESCE(d.nach_mv_intreno,'') AS nach_mv_intreno, COALESCE(d.nach_mv_mietvertrag_nr,'') AS nach_mv_mietvertrag_nr, COUNT(c.nach_mv_intreno) AS anz_nach_mv
   FROM dbp_view.v_immo_mietvertrag_per_2 a
   JOIN dbp_view.v_immo_mietvertrag_mo_zu_per_2 b
   ON a.mandant_id = b.mandant_id AND a.mv_intreno = b.mv_intreno
   LEFT JOIN  (

    
   
   SELECT
    b.mandant_id, b.mo_intreno, b.mv_intreno AS nach_mv_intreno, a.mietvertrag_nr AS nach_mv_mietvertrag_nr, b.mo_status_id AS nach_mv_status_id, b.dat_status_von, b.dat_status_bis, a.dat_miet_beginn, a.dat_miet_ende
   FROM dbp_view.v_immo_mietvertrag_per_2 a
   JOIN dbp_view.v_immo_mo_status_per_2 b
   ON a.mandant_id = b.mandant_id AND a.mv_intreno = b.mv_intreno
   WHERE a.dat_miet_beginn > CURRENT_DATE AND CURRENT_DATE BETWEEN b.dat_status_von AND b.dat_status_bis

   UNION ALL

   
   SELECT
    mandant_id, '' AS mo_intreno, '' AS nach_mv_intreno, '' AS nach_mv_mietvertrag_nr, -1 AS mo_status_id, CAST ('01.01.1900' AS VARCHAR) AS dat_status_von, CAST ('31.12.9999' AS VARCHAR) AS dat_status_bis, CAST ('01.01.1900' AS VARCHAR) AS dat_miet_beginn, CAST ('31.12.9999' AS VARCHAR) AS dat_miet_ende
   FROM dbp_view.v_mandant_2
   ) c
   ON b.mandant_id = c.mandant_id AND b.mo_intreno = c.mo_intreno
   LEFT JOIN
   (
     
   SELECT
    a.mandant_id, b.mo_intreno, a.mv_intreno, MAX(c.nach_mv_intreno) AS nach_mv_intreno, MAX(c.nach_mv_mietvertrag_nr) AS nach_mv_mietvertrag_nr
   FROM dbp_view.v_immo_mietvertrag_per_2 a
   JOIN dbp_view.v_immo_mietvertrag_mo_zu_per_2 b
   ON a.mandant_id = b.mandant_id AND a.mv_intreno = b.mv_intreno
   LEFT JOIN
   
   (SELECT
    b.mandant_id, b.mo_intreno, b.mv_intreno AS nach_mv_intreno, a.mietvertrag_nr AS nach_mv_mietvertrag_nr, b.mo_status_id AS nach_mv_status_id, b.dat_status_von, b.dat_status_bis, a.dat_miet_beginn, a.dat_miet_ende
   FROM dbp_view.v_immo_mietvertrag_per_2 a
   JOIN dbp_view.v_immo_mo_status_per_2 b
   ON a.mandant_id = b.mandant_id AND a.mv_intreno = b.mv_intreno
   WHERE a.dat_miet_beginn > CURRENT_DATE AND CURRENT_DATE BETWEEN b.dat_status_von AND b.dat_status_bis

   UNION ALL

   SELECT
    mandant_id, '' AS mo_intreno, '' AS nach_mv_intreno, '' AS nach_mv_mietvertrag_nr, -1 AS mo_status_id, CAST ('01.01.1900' AS VARCHAR) AS dat_status_von, CAST ('31.12.9999' AS VARCHAR) AS dat_status_bis, CAST ('01.01.1900' AS VARCHAR) AS dat_miet_beginn, CAST ('31.12.9999' AS VARCHAR) AS dat_miet_ende
   FROM dbp_view.v_mandant_2)
    c
   ON b.mandant_id = c.mandant_id AND b.mo_intreno = c.mo_intreno
   GROUP BY 1,2,3
   ) d
   ON b.mandant_id = d.mandant_id AND b.mo_intreno = d.mo_intreno AND b.mv_intreno = d.mv_intreno
   GROUP BY 1,2,3,4,5,6
  ) v
   LEFT JOIN
   (
    SELECT * FROM dbp_view.v_immo_mo_status_per_2 WHERE CURRENT_DATE BETWEEN dat_status_von AND dat_status_bis
   ) w
   ON v.mandant_id = w.mandant_id AND v.mo_intreno = w.mo_intreno AND v.nach_mv_intreno = w.mv_intreno


   UNION ALL

   
   SELECT
   t1.mandant_id, t1.mo_intreno, '' AS mv_intreno, '' AS konzessionaer_id, '' AS nach_mv_intreno, '' AS nach_mv_mietvertrag_nr, -1 AS nach_mv_status_id, 0 AS anz_nach_mv
   FROM dbp_view.v_immo_mo_status_per_2 t1_2
   WHERE CURRENT_DATE BETWEEN t1.dat_status_von AND t1.dat_status_bis
   AND t1.mo_status_id = 0;