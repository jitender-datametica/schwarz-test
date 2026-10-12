CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TDL_1(
	MANDANT_ID,
	TDL_ID,
	TDL_SRC,
	TDL_NAME
) AS
--2024-10-22, AP0230823 , initial
--2025-01-29, nwag, prio DE over DE FLW
   SELECT 
   mandant_id,
   belos_adresse_id AS tdl_id,
   'BELOS' AS tdl_src,
   adress_name AS tdl_name
   FROM dbp_view.v_belos_adresse_1 WHERE spedition_fg=1
UNION
   SELECT 
   gp.mandant_id,
   gp.tms_gp_id AS tdl_id,
   'WANKO' AS tdl_src,
   gp.tms_gp_name AS tdl_name
   FROM dbp_view.v_tms_gp_1 gp_1
   JOIN dbp_view.v_l_system_1 s
   ON gp.system_id = s.system_id
   WHERE gp.tms_gp_typ_cd= 'S'
   --retain records from KTMS_DE if same id is used in KTMS_FLW_DE
   QUALIFY ROW_NUMBER() OVER (PARTITION BY gp.mandant_id, gp.tms_gp_id ORDER BY CASE WHEN LEFT(KL_SYSTEM_BEZ,3)  <> 'FLW' THEN 0 ELSE 1 END) = 1
   
   ;