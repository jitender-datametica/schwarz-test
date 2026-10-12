CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_WG_PER_2
-- 05.08.2018, AP0021792, mkub1811: OWG Umstellung
(
wg_id
,arthiertyp_id
,lead_mwst_id
,dat_von, abt_id
,mandant_id
,dat_bis
,owg_id
)
AS
   SELECT wg_id, arthiertyp_id, lead_mwst_id, dat_von, abt_id, mandant_id, dat_bis, owg_id
   FROM dbp_view.v_wg_per_2
   WHERE arthiertyp_id = 2
   AND dat_bis = '9999-12-31'
   AND abt_id <> 0;