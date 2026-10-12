CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_FLW_TRANSPORT_DET
--20.09.2018 NAKU: Neuanlegen der View mit aller Felder. SPEC0039809
--05.02.2019 twie: flw_kunde_id entfernt, ist in mv_l_flw_handling_unit
--15.07.2019 pjan1603: in_kunde_id is brought back, in order to make the "Anz. Stellplaetze LKW" metric work well in the "01.11.02.04 Transportdaten Monat" report, SPEC0041902
(
mandant_id
,tour_id
,komm_bereich_id
,kunde_grp_id
,in_kunde_id
,lkw_postyp_id
,anz_stellplatz_ist
)
AS
   SELECT
  mandant_id, tour_id, komm_bereich_id, kunde_grp_id, flw_kunde_id as in_kunde_id, lkw_postyp_id, anz_stellplatz_ist
   FROM dbp_view.v_flw_transport_det;