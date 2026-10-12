CREATE OR REPLACE VIEW DBP_MSI_VIEW_LOG.MV_L_TDL_PROMPT_2(
	MANDANT_ID,
	TDL_ID,
	TDL_NAME_BELOS,
	TDL_NAME_WANKO,
	BELOS_FG,
	WANKO_FG,
	TDL_NAME
) AS
--2024-10-22, AP0230823 , initial
--2025-01-29, nwag, prio DE over DE FLW
 SELECT
 mandant_id,
 tdl_id,
 MAX(CASE WHEN tdl_src = 'BELOS' THEN tdl_name END) AS tdl_name_belos,
 MAX(CASE WHEN tdl_src = 'WANKO' THEN tdl_name END) AS tdl_name_wanko,
 MAX(CASE WHEN tdl_src = 'BELOS' THEN 1 ELSE 0 END) AS belos_fg,
 MAX(CASE WHEN tdl_src = 'WANKO' THEN 1 ELSE 0 END) AS wanko_fg,
 COALESCE(tdl_name_wanko,tdl_name_belos) AS tdl_name
 FROM (
 SELECT 
   mandant_id,
   belos_adresse_id AS tdl_id,
   'BELOS' AS tdl_src,
   adress_name AS tdl_name
   FROM dbp_data.belos_adresse_2 WHERE spedition_fg=1
UNION
   SELECT 
   gp.mandant_id,
   gp.tms_gp_id AS tdl_id,
   'WANKO' AS tdl_src,
   gp.tms_gp_name AS tdl_name
   FROM dbp_data.tms_gp_2 gp_2
   JOIN dbp_view.v_l_system_2 s
   ON gp.system_id = s.system_id
   WHERE gp.tms_gp_typ_cd= 'S'
   --retain records from KTMS_DE if same id is used in KTMS_FLW_DE
   QUALIFY ROW_NUMBER() OVER (PARTITION BY gp.mandant_id, gp.tms_gp_id ORDER BY CASE WHEN LEFT(KL_SYSTEM_BEZ,3)  <> 'FLW' THEN 0 ELSE 1 END) = 1
   ) v00
    GROUP BY  mandant_id, tdl_id;