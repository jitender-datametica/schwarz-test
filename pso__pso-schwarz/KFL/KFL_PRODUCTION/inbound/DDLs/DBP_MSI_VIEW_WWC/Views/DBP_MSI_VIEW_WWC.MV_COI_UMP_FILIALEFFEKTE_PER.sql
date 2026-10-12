CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_COI_UMP_FILIALEFFEKTE_PER
(
mandant_id
,gj_plan
,version_id
,land_level
,wup_id
,nb_id
,filialeffekt_massnahme_typ
,filialeffekt_auswirkung_bez
,massnahme_id
,dat_filialeffekt_von
,dat_filialeffekt_bis
,faktor_filialeffekt
,wert_filialeffekt
)
AS
   SELECT
   mandant_id, gj_plan, version_id, land_level, wup_id, nb_id, filialeffekt_massnahme_typ, filialeffekt_auswirkung_bez, massnahme_id, dat_filialeffekt_von, dat_filialeffekt_bis, faktor_filialeffekt, wert_filialeffekt
   FROM dbp_view.v_coi_ump_filialeffekte_per;