CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_TRANSPORT_PLOMBE_2

--20.09.2018 NAKU: Neuanlegen der View mit aller Felder. SPEC0039809
(
mandant_id
,tour_id
,plombe_id
,dat_plombe_aenderung
)
AS
   SELECT
   mandant_id, tour_id, plombe_id, dat_plombe_aenderung
   FROM dbp_view.v_flw_transport_plombe_2;