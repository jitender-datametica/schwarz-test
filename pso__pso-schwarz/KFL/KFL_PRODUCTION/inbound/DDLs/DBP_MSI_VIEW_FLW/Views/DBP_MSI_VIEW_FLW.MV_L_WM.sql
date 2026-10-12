CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_WM
-- 11.12.2013 twie: Lookup fuer Frischemanager aus AIS_DE plus Dummy fuer CZ
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

   FROM dbp_view.v_wm

   WHERE mandant_id IN (1,2);