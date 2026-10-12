CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WG_WUP_PM_ZU_PER_1
-- AP0032822, SPEC0041631 - 31.10.2108, mkub1811 neue View
(
wup_id
,nb_id
,arthiertyp_id
,MATKL
,pm_id
,dat_von
,dat_bis
,mandant_id
)
AS
   SELECT
   wup_id, nb_id, arthiertyp_id, wg_id, pm_id, dat_von, dat_bis, mandant_id
   FROM dbp_view.v_pm_wup_wg_zu_per_1
   WHERE --mandant_id=1 AND
   arthiertyp_id=2
   AND dat_bis > CURRENT_DATE
   -- 20100330 Filterung der IWT Betriebe
   AND nb_id <> 99;