CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_WM_2
-- 11.12.2013 twie: Lookup fuer Frischemanager aus AIS_DE plus Dummy_2 fuer CZ
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

   FROM dbp_view.v_wm_2

   WHERE mandant_id IN (1,2);