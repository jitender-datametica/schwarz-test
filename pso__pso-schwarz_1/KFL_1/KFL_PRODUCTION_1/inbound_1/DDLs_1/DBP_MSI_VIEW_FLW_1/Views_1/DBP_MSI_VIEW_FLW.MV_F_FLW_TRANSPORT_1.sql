CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_FLW_TRANSPORT_1
--14.09.2018 mmzy2302: Neuanlegen der View mit explizitem Ausweis aller Felder
--20.09.2018 NAKU: Angepasst mit aller Felder. Siehe SPEC0039809
(
mandant_id
,tour_id
,werk_id
,dat_verladung
,dat_transp_abschluss
,zeit_transp_abschluss
,route_id
,anz_stellplatz_soll
,spediteur_id
,lkw_typ_id
,temperatur
,lkw_kennz_id
,lkw_anh_kennz_id
,fracht_betrag_relevanz_fg
,rundlauf_transport_fg
,hauspost_fg
,kommentar1
,kommentar2
,kommentar3
,kommentar4
,dat_plan_verladung
,zeit_plan_verladung
,plan_ablade_dat
,plan_ablade_zeit
,lkw_status_id

)
AS
   SELECT
   v01.mandant_id, v01.tour_id, v01.werk_id, v01.dat_verladung, v01.dat_transp_abschluss, v01.zeit_transp_abschluss, v01.route_id, v01.anz_stellplatz_soll, v01.spediteur_id, v01.lkw_typ_id, v01.temperatur, v01.lkw_kennz_id, v01.lkw_anh_kennz_id, v01.fracht_betrag_relevanz_fg, v01.rundlauf_transport_fg, v01.hauspost_fg, v01.kommentar1, v01.kommentar2, v01.kommentar3, v01.kommentar4, v01.dat_plan_verladung, v01.zeit_plan_verladung, v01.dat_plan_ablade      AS plan_ablade_dat, v01.zeit_plan_ablade     AS plan_ablade_zeit, v01.lkw_status_id

   FROM dbp_view.v_flw_transport_1   v01;