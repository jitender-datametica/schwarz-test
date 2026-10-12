CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_COI_UMP_EK_MASSNAHME_PER_1
(
mandant_id
,gj_plan
,version_id
,land_level
,vs_id
,wup_id
,nb_id
,arthiertyp_id
,abt_id
,hwg_id
,ek_massnahme_typ
,dat_ek_massnahme_von
,massnahme_id
,ek_massnahme_bez
,dat_ek_massnahme_bis
,faktor_ek
,wert_ek
)
AS
   SELECT
   mandant_id, gj_plan, version_id, land_level, vs_id, wup_id, nb_id, arthiertyp_id, abt_id, hwg_id, ek_massnahme_typ, dat_ek_massnahme_von, massnahme_id, ek_massnahme_bez, dat_ek_massnahme_bis, faktor_ek, wert_ek
   FROM dbp_view.v_coi_ump_ek_massnahme_per_1;