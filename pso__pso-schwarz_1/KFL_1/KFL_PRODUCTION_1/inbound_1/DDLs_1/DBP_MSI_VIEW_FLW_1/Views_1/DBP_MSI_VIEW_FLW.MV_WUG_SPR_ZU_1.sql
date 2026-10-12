CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_WUG_SPR_ZU_1
-- 02.10.2013 twie: Erweitert um mandant_id 2
(
mandant_id
,wug_id
,arthiertyp_id
,wg_id,spr_id
,wug_bez
,wug_id_bez
)
AS
   SELECT v01.mandant_id, v01.wug_id, v01.arthiertyp_id, v01.wg_id, v01.spr_id, v01.wug_bez, CAST( CAST(v01.wug_id AS CHAR(10)) || '   ' || v01.wug_bez AS CHAR(50)) AS wug_id_bez
   FROM dbp_view.v_wug_spr_zu_1 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_1 v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id IN (1,2)
   AND v01.arthiertyp_id = 2;