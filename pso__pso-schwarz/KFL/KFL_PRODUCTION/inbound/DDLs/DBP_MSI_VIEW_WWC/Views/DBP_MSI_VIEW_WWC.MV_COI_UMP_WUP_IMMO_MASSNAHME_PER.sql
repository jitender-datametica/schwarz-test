CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_COI_UMP_WUP_IMMO_MASSNAHME_PER
(
mandant_id
,gj_plan
,version_id
,wup_id
,nb_id
,dat_immo_massnahme_von
,dat_immo_auswirkung_von
,massnahme_id
,dat_immo_massnahme_bis
,dat_immo_auswirkung_bis
,immo_massnahme_typ
,immo_auswirkung_bez
,betriebsunterbrechung_fg
,faktor_immo
,wert_immo
)
AS
   SELECT
   mandant_id, gj_plan, version_id, wup_id, nb_id, dat_immo_massnahme_von, dat_immo_auswirkung_von, massnahme_id, dat_immo_massnahme_bis, dat_immo_auswirkung_bis, immo_massnahme_typ, immo_auswirkung_bez, betriebsunterbrechung_fg, faktor_immo, wert_immo
   FROM dbp_view.v_coi_ump_wup_immo_massnahme_per;