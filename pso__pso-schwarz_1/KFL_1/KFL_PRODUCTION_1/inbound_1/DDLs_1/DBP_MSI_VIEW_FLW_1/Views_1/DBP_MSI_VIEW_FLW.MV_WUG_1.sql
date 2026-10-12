CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_WUG_1
-- 02.10.2013 twie: Erweitert um mandant_id 2
(
mandant_id
,arthiertyp_id
,wug_id
,wg_id
)
AS
   SELECT mandant_id, arthiertyp_id, wug_id, wg_id
   FROM dbp_view.v_wug_1
   WHERE mandant_id IN (1,2)
   AND arthiertyp_id = 2;