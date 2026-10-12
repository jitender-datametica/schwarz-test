CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_IN_BUCHUNGSKREIS
--18.12.2012 SHoger Initial
--25.02.2013 A Lipkin sako_fg Filterung aktiviert


( buchungskreis_id
,mandant_id
,kontenplan_id
,sako_fg

)
AS
   SELECT
   buchungskreis_id,
   mandant_id,
   kontenplan_id,
   sako_fg


   FROM dbp_view.v_in_l_buchungskreis
   WHERE sako_fg=1;