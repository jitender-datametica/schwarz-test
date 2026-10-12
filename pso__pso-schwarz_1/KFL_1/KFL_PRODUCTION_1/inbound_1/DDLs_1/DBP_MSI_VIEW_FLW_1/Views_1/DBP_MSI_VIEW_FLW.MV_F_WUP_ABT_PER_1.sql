CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_WUP_ABT_PER_1
--02.02.2012 twie: arthiertyp_id gefiltert, da nur hierfuer sinnvolle Daten vorhanden
(
gjmo
,wup_id
,mandant_id
,nb_id
,abt_id
,umsatz_netto_plan
,umsatz_netto_plan_wrg
,umsatz_netto_plan_konz
)
AS
   SELECT

   v01.gjmo, v01.wup_id, v01.mandant_id, v01.nb_id, v01.abt_id, v01.umsatz_netto_plan   --Landeswaehrung
   , v01.umsatz_netto_plan_wrg, v01.umsatz_netto_plan_konz --Konzernwaehrung

   FROM dbp_view.v_wup_abt_per_1   v01

   WHERE v01.arthiertyp_id = 2;