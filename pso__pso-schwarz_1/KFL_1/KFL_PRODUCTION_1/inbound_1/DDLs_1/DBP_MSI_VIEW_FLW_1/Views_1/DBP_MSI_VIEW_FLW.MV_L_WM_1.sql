CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_WM_1
-- 11.12.2013 twie: Lookup fuer Frischemanager aus AIS_DE plus Dummy_1 fuer CZ
(
wm_id ,
wm_name,
mandant_id
)
AS
   SELECT
   wm_id,
   wm_name,
   mandant_id

   FROM dbp_view.v_wm_1

   WHERE mandant_id IN (1,2);