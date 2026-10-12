CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_WUG_2 (
	MANDANT_ID,
	ARTHIERTYP_ID,
	WUG_ID,
	WG_ID,
     WGI_ID
) AS
--2024-11-22, dknop, adding wgi_id
   SELECT
   mandant_id  
   , arthiertyp_id, wug_id, wg_id
   ,CASE
  WHEN v01.wg_id < 0 THEN TO_VARCHAR(v01.wg_id, 'FM000')
   ELSE TO_VARCHAR(v01.wg_id, 'FM000') END ||
   CASE
   WHEN v01.wug_id < 0 THEN TO_VARCHAR(v01.wug_id, 'FM000')
   ELSE TO_VARCHAR(v01.wug_id, 'FM000') END AS wgi_id
   FROM dbp_view.v_wug_2 v01
   WHERE arthiertyp_id=2;