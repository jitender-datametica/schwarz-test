CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_KUNDE_2

--20.09.2018 NAKU: Neuanlegen der View mit aller Felder. SPEC0039809
(
mandant_id
,wup_id
,flw_kunde_id
,kunde_nr
,kunde_name
,frueh_spaet_kz
,system_id
,kunde_land
,kunde_plz
,kunde_ort
)
AS
   SELECT

   mandant_id, wup_id, flw_kunde_id, kunde_nr, kunde_name, frueh_spaet_kz, system_id, kunde_land, kunde_plz, kunde_ort
   FROM dbp_view.v_flw_kunde_2;