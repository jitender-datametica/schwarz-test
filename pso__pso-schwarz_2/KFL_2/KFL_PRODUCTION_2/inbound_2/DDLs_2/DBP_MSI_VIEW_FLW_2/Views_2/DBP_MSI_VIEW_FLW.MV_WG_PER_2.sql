CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_WG_PER_2
--31.01.2012 twie: Mandant_2 2 hinzugefuegt
(
wg_id
,arthiertyp_id
,lead_mwst_id
,dat_von
,abt_id
,mandant_id
,dat_bis
)
AS
   SELECT wg_id, arthiertyp_id, lead_mwst_id, dat_von, abt_id, mandant_id, dat_bis
   FROM dbp_view.v_wg_per_2
   WHERE mandant_id in (1,2)
   AND arthiertyp_id = 2
   AND dat_bis > CURRENT_DATE;