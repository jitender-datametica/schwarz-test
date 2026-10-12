CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WUP_PLANUMSATZE_EINGABE
AS
   SELECT v2.kjmo, v1.mandant_id, v1.wup_id, v1.wrg_id, sum(CASE WHEN v1.ums_netto_plan_man <> 0 THEN v1.ums_netto_plan_man ELSE v1.ums_netto_plan END) as WST_ums_netto_plan_filiale, sum(CASE WHEN v1.ums_netto_plan_man_meldeschluss <> 0 THEN v1.ums_netto_plan_man_meldeschluss ELSE v1.ums_netto_plan END) as WST_ums_netto_plan_filiale_meldeschluss, (case when (sum(CASE WHEN v1.ums_netto_plan_man <> 0 THEN v1.ums_netto_plan_man ELSE v1.ums_netto_plan END) = sum(CASE WHEN v1.ums_netto_plan_man_meldeschluss <> 0 THEN v1.ums_netto_plan_man_meldeschluss ELSE v1.ums_netto_plan END) )
   then 0 else 1 end) as Anpassung_CO_Wert, (case when (sum(CASE WHEN v1.ums_netto_plan_man <> 0 THEN v1.ums_netto_plan_man ELSE v1.ums_netto_plan END) = sum(CASE WHEN v1.ums_netto_plan_man_meldeschluss <> 0 THEN v1.ums_netto_plan_man_meldeschluss ELSE v1.ums_netto_plan END) )
   then 1 else 0 end) as Ubernahme_CO

   
   FROM dbp_msi_view_vis.mv_wup_stunden_tag  v1
join dbp_msi_view_vis.mv_tag v2
on  v1.dat = v2.dat

group by 1,2,3,4
having sum(CASE WHEN v1.ums_netto_plan_man <> 0 THEN v1.ums_netto_plan_man ELSE v1.ums_netto_plan END) <>0 ;